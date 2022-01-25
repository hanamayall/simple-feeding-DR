
#### Mass and temperature dependenct biological rates


# write a function to calculate the Boltzmann term from the activation energy
function boltmann(Ea, T)
    T0 = 293.15
    k = 8.617e-5 
    normalised_T = T0 - T
    denom = k * T0 * T
    return exp(Ea *(normalised_T / denom))
end


# the following parameters are required for growth rate, carrying capacity and metabolism, which are only specific to one species at a time
    # I (exponent) - intercept
    # si - slope 
    # Ea - activation energy

## Growth rate - r
# function to calculate the growth rate for the basal species
function growth_BA(param, M, T)
    # extract parameter values from param
    I = param.I_r
    si = param.si_r
    Ea = param.Ea_r
    # calculate terms in growth equation
    intercept = exp(I)
    massi = M[i]^si 
    boltz = boltmann(Ea, T)
    return intercept * massi * boltz
end



## Carrying capacity - K 
# the intercept I is varied to investigate the effects of enrichment
function carryingcapacity_BA(param, M, T)
    # extract parameter values from param
    I = param.I_K
    si = param.si_K
    Ea = param.Ea_K
    # calculate terms in carrying capacity equation
    intercept = exp(I)
    massi = M[i]^si 
    boltz = boltmann(Ea, T)
    return intercept * massi * boltz
end

## Metabolism - x
function metabolism_BA(param, M, T)
    # extract parameter values from param
    I = param.I_x
    si = param.si_x
    Ea = param.Ea_x
    # calculate terms in metabolism equation
    intercept = exp(I)
    massi = M[i]^si 
    boltz = boltmann(Ea, T)
    return intercept * massi * boltz
end


# the following parameters are required for feeding terms maximum ingestion and half saturation density, which are resource and consumer specific
    # I (exponent)
    # si - resource slope
    # sj - consumer slope
    # Ea - activation energy 


## Maximum ingestion - y





## Half saturation density 





##### Parameters
# Create a tuple containing the parameters required to calculate the mass/ temperature dependent biological rates
    # Ea - list of activation energies 


param = (
    # Intercepts
    I_K = [1:1:20;],
    I_r = -15.68,
    I_y = -9.66,
    I_B0 = 3.44,
    I_x = -16.54,

    # Resource slopes
    si_K = 0.28,
    si_r = -0.25,
    si_y = 0.45,
    si_B0 = 0.2,
    si_x = -0.31,

    # Consumer slopes (consumption)
    sj_y = -0.47,
    sj_B0 = 0.33,

    # Activation energies
    Ea_K = 0.71,
    Ea_r = -0.84,
    Ea_y = -0.26,
    Ea_B0 = 0.12,
    Ea_x = -0.69

)

typeof(param)