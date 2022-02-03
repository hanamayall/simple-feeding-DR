####### Mass and temperature dependent feeding interaction functional responses

# function to generate F given B (biomass of species)

function functional_response(h = 1 ;B, p)
    ### Extract maximum ingestion and half saturation density
    y = p.y
    β = p.β

    # Empty matrix to store functional responses 
    F = zeros(3,3)

    # find consumers
    
end



## playing and testing
B = (3,2,1)
C = []
for i in B
    b = i + 1
    C = append!(C, b)
    return C
end

Fex = [0 0.5 0; 0 0 0.6; 0 0 0]
idf = findall(!iszero, Fex)
unique([i[1] for i in idf])