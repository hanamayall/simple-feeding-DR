#### Biomass dynamics ODE 
# three species dynamical DifferentialEquations

# BEFW model
function BEFW(du, u, ModelParameters, t)
    bas_growth = 
    consumption_int = 
    consumption_top = 
    metabolism_int = 
    metabolism_top = 
    du[1] = bas_growth - consumption_int 
    du[2] = (e.int * consumption_int) - consumption_top - metabolism_int
    du[3] = (e.top * consumption_top)  - metabolism_top
    return du
end