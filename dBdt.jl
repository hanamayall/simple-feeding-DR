#### Biomass dynamics ODE 
# three species dynamical DifferentialEquations

# BEFW model
function BEFW(du, u, p, t)
    ### growth gain 
    G = 1 .- (u ./ p.K) # logistic growth term
    growth = r .* G .* B 
    @assert growth[2] ==0
    @assert growth[3] ==0

    ### consumption loss
    consumption_loss =  

    ### consumption gain

    consumption_gain

    ### metabolism loss
    metabolism_loss = p.x .* u
    @assert metabolism_loss[1] == 0
    
    # calculate changes in biomass
    dBdt = growth .- consumption_loss .+ consumption_gain .- metabolism_loss

    return dBdt
end

