#### Biomass dynamics ODE 
# three species dynamical DifferentialEquations

# BEFW model
function BEFW(du, u, ModelParameters, t)
    # basal species growth 
    rB = growth_BA(...)                     ### fill in r arguments ###
    GB = 1 - (u[1] / carryingcapacity_BA()) ### fill in K arguments ###
    bas_growth = rB * GB * u[1]

    # consumption of basal species by intermediate
    consumption_int = 

    # consumption of intermediate by top
    consumption_top = 

    # metabolism of intermediate species
    xI = metabolism_BA(...)                 ### fill in x arguments ###
    metabolism_int = xI * u[2]

    # metabolism of top species
    xT = metabolism_BA(...)                 ### fill in x arguments ###
    metabolism_top = xT * u[3]

    # calculate changes in biomass
    du[1] = bas_growth - consumption_int 
    du[2] = (e.int * consumption_int) - consumption_top - metabolism_int
    du[3] = (e.top * consumption_top)  - metabolism_top
end

# all the parameters
ModelParameters = (
    FoodWebPar, # to generate tri-trophic food web
    param # to calculate biological rates
)
typeof(ModelParameters)