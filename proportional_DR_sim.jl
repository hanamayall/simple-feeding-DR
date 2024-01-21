##### Run the BEFW with chemical effects on y and B0, varying the slope, asymptote and inflection point


#### Initial conditions ####
Z = 1
I_K = 3
T = 293.15

# starting biomasses
u0 = [ 0.41313430550072494, 0.41313430550072494, 0.41313430550072494]

# seconds * minutes * hours (1 day)
interval_tkeep = 60 * 60 * 24 
# time span for each simulation
start = 0.0
# week * year * 700
stop = interval_tkeep * 365 * 700
tspan = (start, stop)
t_keep = collect(start:interval_tkeep:stop)

##### Extinction call back
# define extinction threshold
threshold = 10e-12
function condition(out,u,t,integrator) # Event when event_f(u,t) == 0
    out[1] = u[1] - threshold
    out[2] = u[2] - threshold
    out[3] = u[3] - threshold
end
function affect!(integrator, idx)
    if idx == 1
     integrator.u[1] = 0.0
    elseif idx == 2
        integrator.u[2] = 0.0
    elseif idx == 3
        integrator.u[3] = 0.0
    end
end
cbs = VectorContinuousCallback(condition,affect!,3)


#### Varying slopes ####
slopes = collect(exp2.(range(3, stop = 6, length = 10)))
targets = ["y", "B0", "r", "x"]
doses = [0:1:100.0;]

# sl = 8.0
# rate = "x"
# dose = 90

## empty dataframe to store results
df = DataFrame(
    target = [],
    slope = [],
    dose = [], 
    r = [],
    x_2 = [],
    y_21 = [],
    B0_21 = [],
    meanB1 = [],
    meanB2 = [],
    meanB3 = [],
    maxB1 = [],
    maxB2 = [],
    maxB3 = [],
    minB1 = [],
    minB2 = [],
    minB3 = [],
    stabilityB1 = [],
    stabilityB2 = [],
    stabilityB3 = [],
    sp_survival = []
)


for rate in targets 
    for sl in slopes 
        for dose in doses
            # generate parameters specific to this combo of target rate, DR slope and dose 
            p = ModelParameters_CG(param, T, I_K, Z, dose, rate, slope = sl, lower = 0.0, xmid = 50.0)

            # Define the problem 
            prob = ODEProblem(BEFW, u0, tspan, p)

            # Solve the problem
            sol = solve(prob, maxiters = 1e7, saveat = t_keep, callback = cbs, adaptive = false, dt = interval_tkeep)

            ###### Output metrics ######
            # turn vector output of biomasses into matrix 
            matrix_u = hcat(sol.u...)' # 56×3 adjoint(::Matrix{Float64}) with eltype Float64: 

            # final 1000 biomasses
            final_u = matrix_u[end-(1000-1):end,:]
            
            ### Mean biomass
            meanB1 = mean(final_u[:,1])
            meanB2 = mean(final_u[:,2])
            meanB3 = mean(final_u[:,3])

            ### Biomass extremes
            maxB1 = maximum(final_u[:,1])
            maxB2 = maximum(final_u[:,2])
            maxB3 = maximum(final_u[:,3])

            minB1 = minimum(final_u[:,1])
            minB2 = minimum(final_u[:,2])
            minB3 = minimum(final_u[:,3])

            ### Stability
            stab = population_stability(final_u)


            ### Number of surviving species
            # count number of species remaining that are above extinction threshold
            survived = count(matrix_u[end,:].> threshold)

            ### Push outputs to DataFrame
            push!(df,[
                rate,
                sl,
                dose,
                p.r[1],
                p.x[2],
                p.y[2,1],
                p.B0[2,1],
                meanB1,
                meanB2,
                meanB3,
                maxB1,
                maxB2,
                maxB3,
                minB1,
                minB2,
                minB3,
                stab[1],
                stab[2],
                stab[3],
                survived
            ])

            # print some stuff - see how the simulation is progressing
            println(("target rate = $rate", "slope = $sl", "dose = $dose"))
        end
    end
end

### Save output
CSV.write("output_dfs/10_slope.csv", df)




#### Varying asymptotes ####
asymptotes = collect(range(0, stop = 0.9, length = 10))

## empty dataframe to store results
df2 = DataFrame(
    target = [],
    asymptote = [],
    dose = [], 
    r = [],
    x_2 = [],
    y_21 = [],
    B0_21 = [],
    meanB1 = [],
    meanB2 = [],
    meanB3 = [],
    maxB1 = [],
    maxB2 = [],
    maxB3 = [],
    minB1 = [],
    minB2 = [],
    minB3 = [],
    stabilityB1 = [],
    stabilityB2 = [],
    stabilityB3 = [],
    sp_survival = []
)

for rate in targets 
    for as in asymptotes 
        for dose in doses
            # generate parameters specific to this combo of target rate, DR slope and dose 
            p = ModelParameters_CG(param, T, I_K, Z, dose, rate, slope = 8.0, lower = as, xmid = 50.0)

            # Define the problem 
            prob = ODEProblem(BEFW, u0, tspan, p)

            # Solve the problem
            sol = solve(prob, maxiters = 1e7, saveat = t_keep, callback = cbs, adaptive = false, dt = interval_tkeep)

            ###### Output metrics ######
            # turn vector output of biomasses into matrix 
            matrix_u = hcat(sol.u...)' # 56×3 adjoint(::Matrix{Float64}) with eltype Float64: 

            # final 1000 biomasses
            final_u = matrix_u[end-(1000-1):end,:]
            
            ### Mean biomass
            meanB1 = mean(final_u[:,1])
            meanB2 = mean(final_u[:,2])
            meanB3 = mean(final_u[:,3])

            ### Biomass extremes
            maxB1 = maximum(final_u[:,1])
            maxB2 = maximum(final_u[:,2])
            maxB3 = maximum(final_u[:,3])

            minB1 = minimum(final_u[:,1])
            minB2 = minimum(final_u[:,2])
            minB3 = minimum(final_u[:,3])

            ### Stability
            stab = population_stability(final_u)

            ### Number of surviving species
            # count number of species remaining that are above extinction threshold
            survived = count(matrix_u[end,:].> threshold)

            ### Push outputs to DataFrame
            push!(df2,[
                rate,
                sl,
                dose,
                p.r[1],
                p.x[2],
                p.y[2,1],
                p.B0[2,1],
                meanB1,
                meanB2,
                meanB3,
                maxB1,
                maxB2,
                maxB3,
                minB1,
                minB2,
                minB3,
                stab[1],
                stab[2],
                stab[3],
                survived
            ])

            # print some stuff - see how the simulation is progressing
            println(("target rate = $rate", "asymptote = $as", "dose = $dose"))
        end
    end
end

### Save output
CSV.write("output_dfs/10_asymptote.csv", df2)


#### Varying inflection points ####
inflections = collect(range(15, stop = 60, length = 10))

## empty dataframe to store results
df3 = DataFrame(
    target = [],
    xmid = [],
    dose = [], 
    r = [],
    x_2 = [],
    y_21 = [],
    B0_21 = [],
    meanB1 = [],
    meanB2 = [],
    meanB3 = [],
    maxB1 = [],
    maxB2 = [],
    maxB3 = [],
    minB1 = [],
    minB2 = [],
    minB3 = [],
    stabilityB1 = [],
    stabilityB2 = [],
    stabilityB3 = [],
    sp_survival = []
)


for rate in targets 
    for in in inflections 
        for dose in doses
            # generate parameters specific to this combo of target rate, DR slope and dose 
            p = ModelParameters_CG(param, T, I_K, Z, dose, rate, slope = 8.0, lower = 0.0, xmid = in)

            # Define the problem 
            prob = ODEProblem(BEFW, u0, tspan, p)

            # Solve the problem
            sol = solve(prob, maxiters = 1e7, saveat = t_keep, callback = cbs, adaptive = false, dt = interval_tkeep)

            ###### Output metrics ######
            # turn vector output of biomasses into matrix 
            matrix_u = hcat(sol.u...)' # 56×3 adjoint(::Matrix{Float64}) with eltype Float64: 

            # final 1000 biomasses
            final_u = matrix_u[end-(1000-1):end,:]
            
            ### Mean biomass
            meanB1 = mean(final_u[:,1])
            meanB2 = mean(final_u[:,2])
            meanB3 = mean(final_u[:,3])

            ### Biomass extremes
            maxB1 = maximum(final_u[:,1])
            maxB2 = maximum(final_u[:,2])
            maxB3 = maximum(final_u[:,3])

            minB1 = minimum(final_u[:,1])
            minB2 = minimum(final_u[:,2])
            minB3 = minimum(final_u[:,3])

            ### Stability
            stab = population_stability(final_u)


            ### Number of surviving species
            # count number of species remaining that are above extinction threshold
            survived = count(matrix_u[end,:].> threshold)

            ### Push outputs to DataFrame
            push!(df3,[
                rate,
                sl,
                dose,
                p.r[1],
                p.x[2],
                p.y[2,1],
                p.B0[2,1],
                meanB1,
                meanB2,
                meanB3,
                maxB1,
                maxB2,
                maxB3,
                minB1,
                minB2,
                minB3,
                stab[1],
                stab[2],
                stab[3],
                survived
            ])

            # print some stuff - see how the simulation is progressing
            println(("target rate = $rate", "inflection point = $in", "dose = $dose"))
        end
    end
end

### Save output
CSV.write("output_dfs/10_inflection.csv", df3)


df
df2
df3



##### Run the BEFW with chemical effects on functional response, varying the slope, asymptote and inflection point

#### Varying slopes

# ## empty dataframe to store results
# df4 = DataFrame(
#     target = [],
#     slope = [],
#     dose = [], 
#     K = [],
#     r = [],
#     x_2 = [],
#     y_21 = [],
#     B0_21 = [],
#     maxB1 = [],
#     maxB2 = [],
#     maxB3 = [],
#     minB1 = [],
#     minB2 = [],
#     minB3 = [],
#     sp_survival = []
# )


# for sl in slopes 
#     for dose in doses
#         # generate parameters specific to this combo of target rate, DR slope and dose 
#         p = ModelParameters_CG(param, T, I_K, Z, dose, "FR", slope = 5.0, lower = 0.0, xmid = 50.0)

#         # Calculate starting biomasses
#         u0 = [p.K[1]/2, p.K[1]/2, p.K[1]/2]

#         # Define the problem 
#         prob = ODEProblem(BEFW_CG, u0, tspan, p)

#         # Solve the problem
#         sol = solve(prob, maxiters = 1e5)


#         ###### Output metrics ######
#         # turn vector output of biomasses into matrix 
#         matrix_u = hcat(sol.u...)' # 56×3 adjoint(::Matrix{Float64}) with eltype Float64: 

#         ### Biomass extremes
#         maxB1 = maximum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),1])
#         maxB2 = maximum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),2])
#         maxB3 = maximum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),3])

#         minB1 = minimum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),1])
#         minB2 = minimum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),2])
#         minB3 = minimum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),3])

#         ### Number of surviving species
#         # final biomasses
#         final_u = matrix_u[length(sol.t),:]

#         # count number of species remaining that are above extinction threshold
#         survived = count(final_u .> threshold)

#         ### Push outputs to DataFrame
#         push!(df4, [
#             "FR",
#             sl,
#             dose,
#             p.K[1],
#             p.r[1],
#             p.x[2],
#             p.y[2,1],
#             p.B0[2,1],
#             maxB1,
#             maxB2,
#             maxB3,
#             minB1,
#             minB2,
#             minB3,
#             survived
#         ])

#         # print some stuff - see how the simulation is progressing
#         println(("slope = $sl", "dose = $dose"))
#     end
# end

