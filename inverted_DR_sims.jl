############# Inverted DR
doses = [0:1:100.0;]

# example to test 
responses = log_logistic(0.0, dose = doses, slope = 5.0, lower = 1.0, xmid = 50.0)
plot(doses, responses)

### Vary slope ###
plt1_inv = plot([NaN], [NaN], label = "", title = "Varying slopes", xlabel = "dose", ylabel = "response", legend=:bottomright)

# range of slope values
for sl in slopes
    responses = log_logistic(0.0, dose = doses, slope = sl, lower = 1.0, xmid = 40.0)
    plot!(doses, responses, label = "$sl")
end
plt1_inv


### Vary asymptote
plt2_inv = plot([NaN], [NaN], label = "", title = "Varying asymptotes"
, xlabel = "dose", ylabel = "response", legend=:bottomright)

# range of asymptote values
for as in asymptotes
    inv_as = 1-as
    responses = log_logistic(0.0, dose = doses, slope = 8.0, lower = inv_as, xmid = 50.0)
    plot!(doses, responses, label = "$inv_as")
end
plt2_inv


### Vary inflection point
plt3_inv = plot([NaN], [NaN], label = "", title = "Varying inflection points"
, xlabel = "dose", ylabel = "response", legend=:bottomright)

# range of xmid values
for infl in inflections
    responses = log_logistic(0.0, dose = doses, slope = 8.0, lower = 1.0, xmid = infl)
    plot!(doses, responses, label = "$infl")
end
plt3_inv


plot(plt1_inv, plt2_inv, plt3_inv)

############# Simulations on metabolism 


#### Initial conditions ####
Z = 1
I_K = 3
T = 293.15

doses = [0:1:100.0;]

# time span for each simulation
tspan = (0.0, 315360000000.0)

# define extinction threshold
threshold = 10e-12


#### Varying slopes ####
slopes = [4.0, 8.0, 16.0, 32.0, 64.0]
targets = ["y", "B0", "r", "x"]

## empty dataframe to store results
df = DataFrame(
    target = [],
    slope = [],
    dose = [], 
    K = [],
    r = [],
    x_2 = [],
    y_21 = [],
    B0_21 = [],
    maxB1 = [],
    maxB2 = [],
    maxB3 = [],
    minB1 = [],
    minB2 = [],
    minB3 = [],
    sp_survival = []
)

for rate in targets 
    for sl in slopes 
        for dose in doses
            # generate parameters specific to this combo of target rate, DR slope and dose 
            p = ModelParameters_CG(param, T, I_K, Z, dose, rate, slope = sl, lower = 0.0, xmid = 50.0)

            # Calculate starting biomasses
            u0 = [p.K[1]/2, p.K[1]/2, p.K[1]/2]

            # Define the problem 
            prob = ODEProblem(BEFW, u0, tspan, p)

            # Solve the problem
            sol = solve(prob, maxiters = 1e7)


            ###### Output metrics ######
            # turn vector output of biomasses into matrix 
            matrix_u = hcat(sol.u...)' # 56×3 adjoint(::Matrix{Float64}) with eltype Float64: 

            ### Biomass extremes
            maxB1 = maximum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),1])
            maxB2 = maximum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),2])
            maxB3 = maximum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),3])

            minB1 = minimum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),1])
            minB2 = minimum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),2])
            minB3 = minimum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),3])

            ### Number of surviving species
            # final biomasses
            final_u = matrix_u[length(sol.t),:]

            # count number of species remaining that are above extinction threshold
            survived = count(final_u .> threshold)

            ### Push outputs to DataFrame
            push!(df, [
                rate,
                sl,
                dose,
                p.K[1],
                p.r[1],
                p.x[2],
                p.y[2,1],
                p.B0[2,1],
                maxB1,
                maxB2,
                maxB3,
                minB1,
                minB2,
                minB3,
                survived
            ])

            # print some stuff - see how the simulation is progressing
            println(("target rate = $rate", "slope = $sl", "dose = $dose"))
        end
    end
end
