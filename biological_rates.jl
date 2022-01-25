
#### Mass and temperature dependenct biological rates


# write a function to calculate the Boltzmann term from the activation energy
function boltmann(Ea, T)
    T0 = 293.15
    k = 8.617e-5 
    normalised_T = T0 - T
    denom = k * T0 * T
    return exp(Ea *(normalised_T / denom))
end

### Parameters
# the following parameters are required for growth rate, carrying capacity and metabolism, which are only specific to one species at a time
    # I (exponent)
    # s_i - slope (i=3 for r and K, i = 1,2 for x)
    # Ea - activation energy


## Growth rate - r
# function to calculate the growth rate for the basal species
function BoltzmannArrhenius(i, BApar, M, T)
    intercept = exp(BApar.I)
    massi = M[i]^BApar.s_i 
    boltz = boltmann(Ea.x, T)
end



## Carrying capacity - K 
# the intercept I is varied to investigate the effects of enrichment





## Metabolism - x



# the following parameters are required for feeding terms maximum ingestion and half saturation density, which are resource and consumer specific
    # I (exponent)
    # s_i - resource slope
    # s_j - consumer slope
    # Ea - activation energy 


## Maximum ingestion - y





## Half saturation density 





##### Parameters
# Create a tuple containing the parameters required to calculate the mass/ temperature dependent biological rates
    # Ea - list of activation energies 


Ea = (
    K = 0.71,
    r = -0.84,
    y = -0.26,
    B0 = 0.12,
    x = -0.69
)