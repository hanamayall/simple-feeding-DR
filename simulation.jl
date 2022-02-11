### Initial conditions

# body mass ratios
allZ = [1, 10, 100]

# fertilisation gradient
allI_K = [1:1:20;]

# temperature gradient
allT = [0:1:40;] .+ 273.15

# time span for each simulation
tspan = (0.0, 315360000000.0)

### Simulation loops
for Z in allZ
    for I_K in allI_K
        for T in allT

            # generate parameters specific to this combo of Z, I_K and T
            p = ModelParameters(param, T, I_K, Z)

            # Calculate starting biomasses
            u0 = [p.K[1]/2, p.K[1]/2, p.K[1]/2]
            
            # Define the problem 
            prob = ODEProblem(BEFW, u0, tspan, p)

            # Solve the problem
            sol = solve(prob)

            # save output metrics
            




            # print some stuff - see how the simulation is progressing
            println(("Z = $Z", "I_K = $I_K", "T = $T"))

        end
    end
end

Z = 100
I_K = 10
T = 293.15
u0
typeof(u0)

p

plot(sol)

10000*365*24*60*60