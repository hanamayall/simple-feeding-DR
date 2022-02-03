#### Function to define parameters 

##### FUNCTION to create tuple of parameters needed for dBdt 

# assign a value for Z, I_K and T as it would be in a loop, just to check if ModelParameters works to generate parameters
Z = 10
I_K = 1
T = 293.15

function ModelParameters(param, T, I_K, Z)
    ### Calculate body masses
    M = BodyMasses(Z=Z)

    ### Calculate carrying capacity
    K = carryingcapacity_BA(I_K, param, M, T)
    @assert K[2] == 0 # defensive programming
    @assert K[3] == 0 

    ### Calculate producer growth rate
    r = growth_BA(param, M, T)
    @assert r[2] == 0 # defensive programming
    @assert r[3] == 0 

    ### Calculate metabolism
    x = metabolism_BA(param, M, T)
    @assert x[1] == 0

    ### Calculate maximum ingestion
    y = max_ingestion_BA(param, M, T, Z)

    ### Calculate half saturation density
    B0 = half_saturation_BA(param, M, T, Z)

    # Combine parameters into Tuple
    ModelParameters = (M = M, K = K, r = r, x = x, y = y, B0 = B0)
    return ModelParameters
end

p = ModelParameters(param, T, I_K, Z)
typeof(p)
p.B0