## ODEs of three species in a simple food chain

#### Define 3 species network
# i(rows) eats j(columns), with i,j =( 1,2,3) corresponding to (top, intermediate, basal) species 

# A = [0 1 0; 0 0 1; 0 0 0]

# ## Trophic levels 
# tl = [1, 2, 3]

# # Z is consumer-resource body-mass ratio
# Z = 100

# # basal species mass
# m = 0.01


#### Parameters
# write a function to generate mass and foodweb 
function Network(;Z, m = 0.01, tl = [1, 2, 3])
    # Body mass calculated from Z, trophic levels and basal mass
    M = m * (Z .^ (tl .- 1))
    FW = (Z = Z, M = M)
    return FW
end


Network(Z=10)[:M]
