simple-feeding-DR

# Feeding rates with a Dose-response curve

Implementing a sigmoid dose-response curve with adjustable slope, asymptote and inflection point into the feeding rates in a simple 3 species food chain.


### Contents

1. setup.jl                 (Packages and project activation)
2. tri-trophic.jl           (functions to create a food chain and calculate body masses from body mass ratio)
3. biological_rates.jl      
4. parameters.jl            (function to generate tuple of parameters from body mass ratio, temperature and fertilisation gradient)
5. feeding_interactions.jl  (Functional response and consumption functions)
6. dBdt.jl                  (Bioenergetic Food Web Model ODE)
7. simulation.jl            (loops for varying body mass ratio, temperature and fertilisation gradient)

