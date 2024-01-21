"""
**Coefficient of variation**
Corrected for the sample size.
"""
function coefficient_of_variation(x)
    cv = std(x) / mean(x)
    norm = 1 + 1 / (4 * length(x))
    return norm * cv
end




"""
**Population stability**
Population stability is measured as the mean of the negative coefficient
of variations of all species with an abundance higher than `threshold`. By
default, the stability is measured over the last `last=1000` timesteps.
"""
function population_stability(matrix_u; threshold::Float64=eps(), last=1000)
    @assert last <= size(matrix_u, 1)
    measure_on = matrix_u[end-(1000-1):end,:]
    stability = -mapslices(coefficient_of_variation, measure_on, dims = 1)
    return stability
end

mean(measure_on, dims = 1)

stab = population_stability(matrix_u)

matrix_u[end-(1000-1):end,:]

mean(final_u[:,1])
final_u[:,1]

stab[]