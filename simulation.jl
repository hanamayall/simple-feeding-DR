### Initial conditions

# body mass ratios
Z = [1, 10, 100]

# fertilisation gradient
I_K = [1:1:20;]

# temperature gradient
T = [0:1:40;] .+ 273.15


# generate parameters specific to this combo of Z, I_K and t
p <- ModelParameters(param = param, )