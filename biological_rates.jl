
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

# Max ingestion and half sat density also require mass dependent attack rate and mass and temperature dependent handling time, which is consumer-resource body mass ratio dependent and needs:
    # I - intercept 
    # s1 - simple Z coefficient
    # s2 - quadratic Z coefficient
    # Z

## Attack rate (mass dependence) αm
function attack_mass(param, Z)
    # extract parameter values from param
    I = param.I_αm 
    s1 = param.s1_αm
    s2 = param.s2_αm
    # Z scaling 
    Z_scale1 = s1 * log(Z)
    Z_scale2 = s2 * (log(Z))^2
    return exp(I + Z_scale1 + Z_scale2)
end 


## Handling time (mass dependence) thm
function handling_mass(param, Z)
    # extract parameter values from param
    I = param.I_thm 
    s1 = param.s1_thm
    s2 = param.s2_thm
    # Z scaling 
    Z_scale1 = s1 * log(Z)
    Z_scale2 = s2 * (log(Z))^2
    return exp(I + Z_scale1 + Z_scale2)
end


## Handling time (temperature dependence) thT
function handling_temp(param, T)
    # extract parameter values from param
    I = param.I_thT 
    s1 = param.s1_thT
    s2 = param.s2_thT
    # temperature scaling
    T_scale1 = s1 * T
    T_scale2 = s2 * T^2
    return exp(I + T_scale1 + T_scale2)
end


## Maximum ingestion - y
function max_ingestion_BA(param, M, Z, T)
    # extract parameter values from param
    I = param.I_y
    si = param.si_y
    sj = param.sj_y
    Ea = param.Ea_y
    # calculate terms in max ingestion equation
    intercept = exp(I)
    massi = M[i]^si 
    massj = M[j]^sj 
    boltz = boltmann(Ea, T)
    th_m = handling_mass(param, Z)
    th_T = handling_temp(param, Z)
    return intercept * massi * massj * boltz * 1/th_m * 1/th_T
end


## Half saturation density 
function half_saturation_BA(param, M, Z, T)
    # extract parameter values from param
    I = param.I_B0
    si = param.si_B0
    sj = param.sj_B0
    Ea = param.Ea_B0
    # calculate terms in half saturation equation
    intercept = exp(I)
    massi = M[i]^si 
    massj = M[j]^sj 
    boltz = boltmann(Ea, T)
    α_m = attack_mass(param, Z)
    th_m = handling_mass(param, Z)
    th_T = handling_temp(param, Z)
    return intercept * massi * massj * boltz * 1/(α_m * th_m * th_T)
end


##### Parameters
# Create a tuple containing the parameters required to calculate the mass/ temperature dependent biological rates
param = (
    # Intercepts
    I_K = [1:1:20;],
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
    s2_thT = -0.055,

    # Quadratic ratio slopes (attack and handling)
    s2_αm = -0.017,
    s2_thm = 0.0256,
    s2_thT = 0.0013,
    
    # Activation energies
    Ea_K = 0.71,
    Ea_r = -0.84,
    Ea_y = -0.26,
    Ea_B0 = 0.12,
    Ea_x = -0.69
)

typeof(param)