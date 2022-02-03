####### Mass and temperature dependent feeding interaction functional responses

# function to generate F given B (biomass of species), and parameters generated using ModelParameters()

function functional_response(h = 1 ;B, parameters)
    ### Extract maximum ingestion and half saturation density
    y = parameters.y
    B0 = parameters.B0

    # Empty matrix to store functional responses 
    F = zeros(3,3)

    # find feeding interactions as cartesian index of matrix
    idf = findall(!iszero, y)
    # identify consumers from idf coords
    consumers = [i[2] for i in idf]
    # identify resources of consumers
    for c in consumers
        # find resource index
        resources = findall(!iszero, y[:,c]) # e.g if c = 2 (intermediate), then r = 1 (basal)
        for r in resources
            num = y[r,c] * (B[r]^h)
            denom = (B0[r,c]^h) + B[r]
            F[r,c] = num / denom
        end
    end 
    return F    
end

#functional_response(B = u, parameters = p)


## playing and testing

# Fex = [0 0.5 0; 0 0 0.6; 0 0 0]
# idf = findall(!iszero, Fex)
# unique([i[1] for i in idf])
# [i[2] for i in idf]

# p.y

# Fex[2,3]


