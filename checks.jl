### Initial conditions

# body mass ratio
Z = 1

# fertilisation gradient
allI_K = [1:1:20;]

# temperature gradient
allT = [0:1:40;] .+ 273.15

# time span for each simulation
tspan = (0.0, 315360000000.0)

# define extinction threshold
threshold = 10e-12

#### data frame to store outputs
df3 = DataFrame(
    Z = [],
    I_K = [],
    T = [],
    K = [],
    r = [],
    x_2 = [],
    y_21 = [],
    B0_21 = [],
    maxB1 = [],
    maxB2 = [],
    maxB3 = [],
    sp_survival = []
)

### Simulation loops

for I_K in allI_K
    for T in allT

        # generate parameters specific to this combo of Z, I_K and T
        p = ModelParameters(param, T, I_K, Z)

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
        maxB1 = maximum(matrix_u[:,1])
        maxB2 = maximum(matrix_u[:,2])
        maxB3 = maximum(matrix_u[:,3])

        ### Number of surviving species
        # final biomasses
        final_u = matrix_u[length(sol.t),:]

        # count number of species remaining that are above extinction threshold
        survived = count(final_u .> threshold)

        ### Push outputs to DataFrame
        push!(df3, [
            Z,
            I_K,
            T,
            p.K[1],
            p.r[1],
            p.x[2],
            p.y[2,1],
            p.B0[2,1],
            maxB1,
            maxB2,
            maxB3,
            survived
        ])

        # print some stuff - see how the simulation is progressing
        println(("Z = $Z", "I_K = $I_K", "T = $T"))

    end
end



df
df2