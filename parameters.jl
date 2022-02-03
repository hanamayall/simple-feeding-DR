#### Function to define parameters 
# Create a NamedTuple containing the parameters required to calculate the mass/ temperature dependent biological rates

# define parameters 
param = (
    # Intercepts
    I_r = -15.68,
    I_y = -9.66,
    I_B0 = 3.44,
    I_x = -16.54,
    I_αm = -1.81,
    I_thm = 1.92,
    I_thT = 0.5,

    # Resource slopes
    si_K = 0.28,
    si_r = -0.25,
    si_y = 0.45,
    si_B0 = 0.2,
    si_x = -0.31,

    # Consumer slopes (consumption)
    sj_y = -0.47,
    sj_B0 = 0.33,

    # Ratio slopes (attack and handling)
    s1_αm = 0.39,
    s1_thm = -0.48,
    s1_thT = -0.055,

    # Quadratic ratio slopes (attack and handling)
    s2_αm = -0.017,
    s2_thm = 0.0256,
    s2_thT = 0.0013,
    
    # Activation energies
    Ea_K = 0.71,
    Ea_r = -0.84,
    Ea_y = -0.26,
    Ea_B0 = 0.12,
    Ea_x = -0.69,

    # Assimilation efficiencies
    e = 0.85
)
typeof(param)

##### FUNCTION to create tuple of parameters needed for dBdt 

# assign a value for Z, I_K and T as it would be in a loop, just to check if ModelParameters works to generate parameters
Z = 10
I_K = 1
T = 293.15


function ModelParameters(param, T, I_K, Z)
    
    ### Calculate body masses
    M = BodyMasses(Z)

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
    y = max_ingestion_BA(param, M, T)

    ### Calculate half saturation density
    β = half_saturation_BA(param, M, T)

    # Combine parameters into Tuple
    ModelParameters = (FW)
    return ModelParameters

end

ModelParameters(param, T, I_K, Z)