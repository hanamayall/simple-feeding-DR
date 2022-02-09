#### Biomass dynamics ODE 
# three species dynamical DifferentialEquations

# BEFW model
function BEFW(du, u, p, t)
    ### Growth (gain) 
    G = 1 .- (u ./ p.K) # logistic growth term
    growth = r .* G .* B 
    @assert growth[2] ==0
    @assert growth[3] ==0

    ### Consumption
    # functional response
    Fij = functional_response(B = u, parameters = p)

    # gains and losses
    consumption_gain, consumption_loss = consumption(B = u, fr = Fij)
    @assert consumption_gain[0] == 0 

    ### metabolism loss
    metabolism_loss = p.x .* u
    @assert metabolism_loss[1] == 0
    
    # calculate changes in biomass
    dBdt = growth .+ consumption_gain .- consumption_loss .- metabolism_loss

    return dBdt
end

