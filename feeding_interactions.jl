####### Mass and temperature dependent feeding interaction functional responses

# function to generate F given B (biomass of species)

function functional_response(B, param, M, T)
    for i in eachindex(B)
    ### Calculate maximum ingestion
    y = max_ingestion_BA(param, M, T)

    ### Calculate half saturation density
    β = half_saturation_BA(param, M, T)

