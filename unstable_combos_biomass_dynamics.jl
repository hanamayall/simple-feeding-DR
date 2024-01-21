##### Looking at the biomass dynamics of combinations of DR params and dose that result in unstable dynamics

## Initial conditions
Z = 1
I_K = 3
T = 293.15


# seconds * minutes * hours (1 day)
interval_tkeep = 60 * 60 * 24 
# time span for each simulation
start = 0.0
# week * year * 700
stop = interval_tkeep * 365 * 700
tspan = (start, stop)
t_keep = collect(start:interval_tkeep:stop)

(254146) / (365)

##### Extinction call back
function condition(out,u,t,integrator) # Event when event_f(u,t) == 0
    out[1] = u[1] - threshold
    out[2] = u[2] - threshold
    out[3] = u[3] - threshold
end
function affect!(integrator, idx)
    if idx == 1
     integrator.u[1] = 0.0
    elseif idx == 2
        integrator.u[2] = 0.0
    elseif idx == 3
        integrator.u[3] = 0.0
    end
end
cbs = VectorContinuousCallback(condition,affect!,3)

# define extinction threshold
threshold = 10e-12




# DR params
sl = 8.0
asym  = 0.0
xmid = 50.0

dose = 80

# generate parameters specific to this combo of target rate, DR slope and dose 
p = ModelParameters_CG(param, T, I_K, Z, dose, "x", slope = sl, lower = asym, xmid = xmid)
p = ModelParameters(param, T, I_K, Z)
# Calculate starting biomasses
u0 = [p.K[1]/2, p.K[1]/2, p.K[1]/2]

# Define the problem 
prob = ODEProblem(BEFW, u0, tspan, p)

# Solve the problem
sol = solve(prob, maxiters = 1e7, saveat = t_keep, callback = cbs, adaptive = false, dt = interval_tkeep)
# sol2 = solve(prob, maxiters = 1e7, callback = cbs)
# sol3 = solve(prob, maxiters = 1e7,saveat = t_keep, adaptive = false, dt = interval_tkeep)
# sol4 = solve(prob, maxiters = 1e7) #, saveat = t_keep)

plot(sol, title = "sl = $sl, as = $asym, xmid = $xmid, dose = $dose")
plot(sol[255001:255501],title = "sl = $sl, as = $asym, xmid = $xmid, dose = $dose (start)")


matrix_u = hcat(sol.u...)'
size(matrix_u,1)

matrix_u[end,:]
matrix_u[end,:] .> threshold

sol.t[1:15]
sol2.t[1:15]
sol.u[254146]
sol2.u[1:15]



p.x
u0
