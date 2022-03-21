######### function for a sigmoid curve
### dose input
# x is a vector of concentrations
### parameters for a sigmoid curve 
# slope 
# upper asymptote (fixed)
# lower asymptote (varying)
# inflection point (xmid)

function log_logistic(upper = 1.0; dose, slope::Float64, lower::Float64, xmid::Float64)
    num = upper - lower
    denom = 1 .+ ((dose ./ xmid) .^ slope)
    return lower .+ num ./ denom
end

doses = [0:1:100.0;]

# example to test 
responses = log_logistic(dose = doses, slope = 5.0, lower = 0.0, xmid = 50.0)
plot(doses, responses, ylim = 1.0)



### Vary slope
plt1 = plot([NaN], [NaN], label = "", title = "Varying slopes")

# range of slope values
slopes = [0.5, 1.0, 5.0, 10.0, 20.0, 50.0]
for sl in slopes
    responses = log_logistic(dose = doses, slope = sl, lower = 0.3, xmid = 50.0)
    plot!(doses, responses, label = "$sl")
end
plt1

### Vary asymptote
plt2 = plot([NaN], [NaN], label = "", title = "Varying asymptotes")

# range of asymptote values
asymptotes = [0.1, 0.3, 0.5, 0.8]
for as in asymptotes
    responses = log_logistic(dose = doses, slope = 5.0, lower = as, xmid = 50.0)
    plot!(doses, responses, label = "$as")
end
plt2


### Vary inflection point
plt3 = plot([NaN], [NaN], label = "", title = "Varying inflection points")

# range of asymptote values
inflections = [1.0, 5.0, 10.0, 20.0, 50.0, 80.0]
for infl in inflections
    responses = log_logistic(dose = doses, slope = 5.0, lower = 0.5, xmid = infl)
    plot!(doses, responses, label = "$infl")
end
plt3

plot(plt1, plt2, plt3)

### loop for high low combos
plt4 = plot([NaN], [NaN], label = "", title = "High/low parameters")

slopes2 = [5.0, 50.0]
asymps2 = [0.0, 0.5]
inflex2 = [10.0, 50.0]

for b in slopes2
    for d in asymps2
        for e in inflex2
            responses = log_logistic(dose = doses, slope = b, lower = d, xmid = e)
            plot!(doses, responses, label = "b = $b, d = $d, e = $e")
        end
    end
end
plt4 



# function Hill_equation(; dose::Vector{Float64}, slope::Float64, asym::Float64, xmid::Float64)
#     xb = dose .^ (-slope)
#     num = (1-asym) .* xb
#     denom = xb .+ (xmid .^ (-slope))
#     sigmoid = num ./ denom 
#     return sigmoid 
# end

# responses = Hill_equation(x = doses, slope = 10.0, asym = 1.0, xmid = 30.0)
# plot(doses, responses, ylim = 1.0)