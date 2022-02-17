######## Checking to see if the values in Figure 2, of rates varying with temperature, align with our calcs

#### all species 0.01g
Z = 1
M = BodyMasses(Z=Z)

#### fertilisation level 3
I_K = 3

# Check T limits & intervals
Tmin = 273.15
T10 = 283.15
T20 = 293.15
T30 = 303.15
Tmax = 313.15

######### 2a - K 
carryingcapacity_BA(I_K, param, M, Tmin)  # 6.469796324965876
carryingcapacity_BA(I_K, param, M, T10)   # 2.229581330642422
carryingcapacity_BA(I_K, param, M, T20)   # 0.8262686110014499
carryingcapacity_BA(I_K, param, M, T30)   # 0.32693445475490657
carryingcapacity_BA(I_K, param, M, Tmax)  # 0.1372514415844402
# CORRECT #

######### 2b - r 
growth_BA(param, M, Tmin) # 4.293834089901734e-8
growth_BA(param, M, T20)  # 4.900749719809166e-7
growth_BA(param, M, T30)  # 1.4677418185488954e-6
growth_BA(param, M, Tmax) # 4.098371477948643e-6
# CORRECT #


######### 2c - x relative to r
metabolism_BA(param, M, Tmin) # 3.6997852501357905e-8
3.6997852501357905e-8/4.293834089901734e-8            # 0.8616507234960403

metabolism_BA(param, M, T10) # 1.0418637435157166e-7

metabolism_BA(param, M, T20)  # 2.7338159268322533e-7
2.7338159268322533e-7/4.900749719809166e-7            # 0.5578362665169335

metabolism_BA(param, M, T30)  # 6.731119190535962e-7
 
metabolism_BA(param, M, Tmax) # 1.5646345778326476e-6
1.5646345778326476e-6/4.098371477948643e-6            # 0.3817698288823232
# CORRECT #


######### 2d - y relative to x 
max_ingestion_BA(param, M, Z, Tmin) # 2.92703e-6 
2.92703e-6/3.6997852501357905e-8                      # 79.11351070694093

max_ingestion_BA(param, M, Z, T10) # 6.58049e-6
6.58049e-6/1.0418637435157166e-7                      # 63.16075437844174

max_ingestion_BA(param, M, Z, T20)  #  1.11074e-5
1.11074e-5/2.7338159268322533e-7                      # 40.62965575326955

max_ingestion_BA(param, M, Z, T30)  #  1.41136e-5
1.41136e-5/6.731119190535962e-7                      # 20.96768694847047

max_ingestion_BA(param, M, Z, Tmax) #  1.35309e-5
1.35309e-5/1.5646345778326476e-6                      # 8.647961761616685
# CORRECT # 


######### 2e - B0 relative to K 
half_saturation_BA(param, M, Z, Tmin) # 2.08984 
2.08984 / 6.469796324965876                            # 0.3230148052629806

half_saturation_BA(param, M, Z , T10) #  2.65656 
2.65656 /2.229581330642422                             # 1.1915062094794946

half_saturation_BA(param, M, Z , T20) # 2.63599
2.63599/0.8262686110014499                            # 3.1902337386447983

half_saturation_BA(param, M, Z , T30) # 2.0392
2.0392 /0.32693445475490657                          # 6.237335864550373

half_saturation_BA(param, M, Z , Tmax) # 1.22858
1.22858/ 0.1372514415844402                           # 8.951308531387262
# CORRECT #

######### 2f - biomass extremes
# temperature gradient
allT = [0:1:40;] .+ 273.15
# time span for each simulation
tspan = (0.0, 315360000000.0)
# define extinction threshold
threshold = 10e-12
#### data frame to store outputs
dfT = DataFrame(
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

### Loop over fertilisation gradient

for T in allT

    # generate parameters specific to this combo of Z, I_K and T
    p = ModelParameters(param, T, I_K, Z)

    # Calculate starting biomasses
    u0 = [p.K[1]/2, p.K[1]/2, p.K[1]/2]
            
    # Define the problem 
    prob = ODEProblem(BEFW, u0, tspan, p)

    # Solve the problem
    sol = solve(prob)


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
    push!(dfT, [
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


dfT
