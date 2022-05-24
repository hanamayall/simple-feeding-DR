##### Looking at the biomass dynamics of combinations of DR params and dose that result in unstable dynamics

## Initial conditions
Z = 1
I_K = 3
T = 293.15

# time span for each simulation
tspan = (0.0, 315360000000.0)

# define extinction threshold
threshold = 10e-12



# DR params
sl = 0.0
asym  = 0.0
xmid = 50.0

dose = 98

# generate parameters specific to this combo of target rate, DR slope and dose 
p = ModelParameters_CG(param, T, I_K, Z, dose, "x", slope = sl, lower = asym, xmid = xmid)

# Calculate starting biomasses
u0 = [p.K[1]/2, p.K[1]/2, p.K[1]/2]

# Define the problem 
prob = ODEProblem(BEFW, u0, tspan, p)

# Solve the problem
sol = solve(prob, maxiters = 1e7, saveat = t_keep)

plot(sol, title = "sl = $sl, as = $asym, xmid = $xmid, dose = $dose")
plot(sol[1:500],title = "sl = $sl, as = $asym, xmid = $xmid, dose = $dose")


u0



######### Save at interval 
### Using Eva's code to make an interval to collect biomasses
interval_tkeep = 5
t_keep = collect(0:interval_tkeep:tspan[2])

tspan[2]