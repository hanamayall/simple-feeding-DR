######## Checking to see if the values in Figure 1, of rates varying with fertilisation, align with our calcs

#### all species 0.01g
Z = 1
M = BodyMasses(Z=Z)

#### at 20C
T = 293.15

# Check limits
I_Kmin = 1
I_Kmax = 20

######### 1a - K 
carryingcapacity_BA(I_Kmin, param, M, T) # 0.2754228703338166
carryingcapacity_BA(5, param, M, T)      # 1.3771143516690831
carryingcapacity_BA(10, param, M, T)     # 2.7542287033381663
carryingcapacity_BA(I_Kmax, param, M, T) # 5.5084574066763325
# CORRECT


######### 1b - r 
growth_BA(param, M, T) # 4.900749719809166e-7
# CORRECT


######### 1c - x relative to r
metabolism_BA(param, M, T) # 2.7338159268322533e-7
2.7338159268322533e-7/4.900749719809166e-7 # 0.5578362665169335
# CORRECT

######### 1d - y relative to x 
max_ingestion_BA(param, M, Z, T) # 1.11074e-5
1.11074e-5/2.7338159268322533e-7 # 40.62965575326955
# CORRECT 


######### 1e - B0 relative to K 
half_saturation_BA(param, M, Z , T) # 2.63599
2.63599/0.2754228703338166 # 9.570701215934395 # I_K = 1
2.63599/1.3771143516690831 # 1.914140243186879 # I_K = 5
2.63599/2.7542287033381663 # 0.9570701215934395 # I_K = 10
2.63599/5.5084574066763325 # 0.47853506079671976 # I_K = 20
# CORRECT 

######### 1f - biomass extremes
# fertilisation gradient
allI_K = [1:1:20;]
# time span for each simulation
tspan = (0.0, 315360000000.0)
# define extinction threshold
threshold = 10e-12
#### data frame to store outputs
dfK = DataFrame(
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

for I_K in allI_K

    # generate parameters specific to this combo of Z, I_K and T
    p = ModelParameters(param, T, I_K, Z)

    # Calculate starting biomasses
    u0 = [p.K[1]/2, p.K[1]/8, p.K[1]/8]
            
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
    push!(dfK, [
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


dfK

maximum(df[!,9])
