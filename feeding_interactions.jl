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
    consumers = [i[1] for i in idf]
    # identify resources of consumers
    for c in consumers
        # find all resource indexes for each consumer
        resources = findall(!iszero, y[c,:]) # e.g if c = 2 (intermediate), then r = 1 (basal)
        for r in resources
            num = y[c,r] * (B[r]^h)
            denom = (B0[c,r]^h) + B[r]
            F[c,r] = num / denom
        end
    end 
    return F    
end

# fr = functional_response(B = B, parameters = p)
# p.B0[]
# B = [1,0.5,0.5]

function functional_response_CG(h = 1;B, parameters, dose = doses, slope = 5.0, lower = 0.0, xmid = 50.0)
    ### Extract maximum ingestion and half saturation density
    y = parameters.y
    B0 = parameters.B0

    # Empty matrix to store functional responses 
    F = zeros(3,3)

    # find feeding interactions as cartesian index of matrix
    idf = findall(!iszero, y)
    # identify consumers from idf coords
    consumers = [i[1] for i in idf]
    # identify resources of consumers
    for c in consumers
        # find all resource indexes for each consumer
        resources = findall(!iszero, y[c,:]) # e.g if c = 2 (intermediate), then r = 1 (basal)
        for r in resources
            num = y[c,r] * (B[r]^h)
            denom = (B0[c,r]^h) + B[r]
            F[c,r] = num / denom
        end
    end 

    ### Calculate effect proportion from concentration C 
    response = log_logistic(dose, slope, lower, xmid)

    return response * F    
end

#write function to calculate consumption gains and losses from the functional response, biomasses and assimilation energy
function consumption(e = 0.85; B, fr)
    feeding = B .* fr
    gain = e .* vec(sum(feeding, dims = 2))
    loss = vec(sum(feeding, dims = 1))
    return (gain, loss)
end
#consumption(B = v1, fr = f1)

### Playing, testing ...
# v1 = [1, 10, 100]
# f1 = [0 0 0; .5 0 0; 0 .8 0]

# vf1 = v1 .* f1

