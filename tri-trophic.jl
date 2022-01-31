## ODEs of three species in a simple food chain

#### Define 3 species network
# i(rows) eats j(columns), with i,j =( 1,2,3) corresponding to (top, intermediate, basal) species 

# A = [0 1 0; 0 0 1; 0 0 0]

## Trophic levels 
tl = [1, 2, 3]

# Z is consumer-resource body-mass ratio
Z = 1

# Body mass calculated from Z and trophic levels
f(x) = Z ^ (x - 1)
M = f.(tl)

#### Parameters
# Create a tuple containing the parameters required to build the initial food web
FoodWeb = (
    tl = tl, # 
    Z = 1, # body mass ratio 1 as default
    M = f.(tl) # body mass calculated by Z
)

FoodWeb()