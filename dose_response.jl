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
plot(doses, responses, ylim = 1.0, label = "b=5, c=0, d=1, e=50")



### Vary slope ###
plt1 = plot([NaN], [NaN], label = "", title = "Varying slopes", xlabel = "dose", ylabel = "response")

# range of slope values
slopes = collect(exp2.(range(1, stop = 6, length = 10)))
for sl in slopes
    responses = log_logistic(dose = doses, slope = sl, lower = 0.0, xmid = 50.0)
    plot!(doses, responses, label = "$sl")
end
plt1
log(100)



### Vary asymptote
plt2 = plot([NaN], [NaN], label = "", title = "Varying asymptotes"
, xlabel = "dose", ylabel = "response")

# range of asymptote values
asymptotes = collect(range(0, stop = 0.9, length = 10))
for as in asymptotes
    responses = log_logistic(dose = doses, slope = 8.0, lower = as, xmid = 50.0)
    plot!(doses, responses, label = "$as")
end
plt2


### Vary inflection point
plt3 = plot([NaN], [NaN], label = "", title = "Varying inflection points"
, xlabel = "dose", ylabel = "response")

# range of xmid values
inflections = collect(range(15, stop = 60, length = 10))
for infl in inflections
    responses = log_logistic(dose = doses, slope = 8.0, lower = 0.0, xmid = infl)
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