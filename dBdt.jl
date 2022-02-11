#### Biomass dynamics ODE 
# three species dynamical DifferentialEquations

# BEFW model
function BEFW(du, u, p, t)
    ### Growth (gain)
    producers = [1.0, 0.0, 0.0]
    G = (1 .- (u ./ p.K)) .* producers # logistic growth term
    growth = p.r .* G .* u 
    @assert growth[2] == 0
    @assert growth[3] == 0

    ### Consumption
    # functional response
    Fij = functional_response(B = u, parameters = p)

    # gains and losses
    consumption_gain, consumption_loss = consumption(B = u, fr = Fij)
    @assert consumption_gain[1] == 0
    @assert consumption_loss[3] == 0

    ### metabolism loss
    metabolism_loss = p.x .* u
    @assert metabolism_loss[1] == 0
    
    # calculate changes in biomass
    dbdt = growth .+ consumption_gain .- consumption_loss .- metabolism_loss

    for i in eachindex(dbdt)
        du[i] = dbdt[i] #can't return du directly, have to have 2 different objects dbdt and du for some reason... 
    end 

    return dbdt
end

G = ifelse.(G .== Inf, 0, G)

findall(G.=-Inf)

growth[2]
typeof(growth[2])