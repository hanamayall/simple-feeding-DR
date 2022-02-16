Recreating_Binzer12

# Binzer 2012

This repository contains trials (and errors) of recreating the three species food web with temperature dependence in [Binzer _et al_'s 2012 paper](https://royalsocietypublishing.org/doi/abs/10.1098/rstb.2012.0230)


### Contents

1. setup.jl                 (Packages and project activation)
2. tri-trophic.jl           (functions to create a food chain and calculate body masses from body mass ratio)
3. biological_rates.jl      (mass and temperature dependent rate functions)
4. parameters.jl            (function to generate tuple of parameters from body mass ratio, temperature and fertilisation gradient)
5. feeding_interactions.jl  (Functional response and consumption functions)
6. dBdt.jl                  (Bioenergetic Food Web Model ODE)
7. simulation.jl            (loops for varying body mass ratio, temperature and fertilisation gradient)
8. Figure1.jl
9. Figure2.jl 
