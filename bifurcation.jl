####### VARYING SLOPES #######

## Divide up dataframes into each slope


#### rate = y ####

# empty object to store multiple plots
Psly = []

for i in 1:length(slopes)
    sl = slopes[i]
    # initialise an empty plot
    plt = Plots.plot([NaN], [NaN],
            label = "",
            xlims = (0,100),
            ylims = (0,1),
            foreground_colour_legend = nothing,
            xlabel = "dose",
            ylabel = "biomass extremes",
            leg = :topleft,
            title = "Slope = $sl" * " (y)")
            
    # filter simulation output df by slope
    dfy_temp = filter(:slope => slope -> slope == slopes[i], dfy)

    # Add to empty plot
    plot!(plt, dfy_temp.dose, dfy_temp.maxB1, ls = :dot, c = :green, lw = 3, label = "basal")
    plot!(plt, dfy_temp.dose, dfy_temp.minB1, ls = :dot, c = :green, lw = 3, label = "")
    plot!(plt, dfy_temp.dose, dfy_temp.maxB2, ls = :dot, c = :blue, lw = 3, label = "intermediate")
    plot!(plt, dfy_temp.dose, dfy_temp.minB2, ls = :dot, c = :blue, lw = 3, label = "")
    plot!(plt, dfy_temp.dose, dfy_temp.maxB3, ls = :dot, c = :red, lw = 3, label = "top")
    plot!(plt, dfy_temp.dose, dfy_temp.minB3, ls = :dot, c = :red, lw = 3, label = "")

    display(plt)

    # add bifurc plot to collection of plots
    push!(Psly, plt)
end    


#### rate = B0 ####

# empty object to store multiple plots
PslB0 = []

for i in 1:length(slopes)
    sl = slopes[i]
    # initialise an empty plot
    plt = Plots.plot([NaN], [NaN],
            label = "",
            xlims = (0,100),
            ylims = (0,1),
            foreground_colour_legend = nothing,
            xlabel = "dose",
            ylabel = "biomass extremes",
            leg = :topleft,
            title = "Slope = $sl" * " (B0)")
            
    # filter simulation output df by slope
    dfB0_temp = filter(:slope => slope -> slope == slopes[i], dfB0)

    # Add to empty plot
    plot!(plt, dfB0_temp.dose, dfB0_temp.maxB1, ls = :dot, c = :green, lw = 3, label = "basal")
    plot!(plt, dfB0_temp.dose, dfB0_temp.minB1, ls = :dot, c = :green, lw = 3, label = "")
    plot!(plt, dfB0_temp.dose, dfB0_temp.maxB2, ls = :dot, c = :blue, lw = 3, label = "intermediate")
    plot!(plt, dfB0_temp.dose, dfB0_temp.minB2, ls = :dot, c = :blue, lw = 3, label = "")
    plot!(plt, dfB0_temp.dose, dfB0_temp.maxB3, ls = :dot, c = :red, lw = 3, label = "top")
    plot!(plt, dfB0_temp.dose, dfB0_temp.minB3, ls = :dot, c = :red, lw = 3, label = "")

    display(plt)

    # add bifurc plot to collection of plots
    push!(PslB0, plt)
end    



#### rate = r ####

# empty object to store multiple plots
Pslr = []

for i in 1:length(slopes)
    sl = slopes[i]
    # initialise an empty plot
    plt = Plots.plot([NaN], [NaN],
            label = "",
            xlims = (0,100),
            ylims = (0,1),
            foreground_colour_legend = nothing,
            xlabel = "dose",
            ylabel = "biomass extremes",
            leg = :topleft,
            title = "Slope = $sl" * " (r)")
            
    # filter simulation output df by slope
    dfr_temp = filter(:slope => slope -> slope == slopes[i], dfr)

    # Add to empty plot
    plot!(plt, dfr_temp.dose, dfr_temp.maxB1, ls = :dot, c = :green, lw = 3, label = "basal")
    plot!(plt, dfr_temp.dose, dfr_temp.minB1, ls = :dot, c = :green, lw = 3, label = "")
    plot!(plt, dfr_temp.dose, dfr_temp.maxB2, ls = :dot, c = :blue, lw = 3, label = "intermediate")
    plot!(plt, dfr_temp.dose, dfr_temp.minB2, ls = :dot, c = :blue, lw = 3, label = "")
    plot!(plt, dfr_temp.dose, dfr_temp.maxB3, ls = :dot, c = :red, lw = 3, label = "top")
    plot!(plt, dfr_temp.dose, dfr_temp.minB3, ls = :dot, c = :red, lw = 3, label = "")

    display(plt)

    # add bifurc plot to collection of plots
    push!(Pslr, plt)
end    



#### rate = x ####

# empty object to store multiple plots
Pslx = []

for i in 1:length(slopes)
    sl = slopes[i]
    # initialise an empty plot
    plt = Plots.plot([NaN], [NaN],
            label = "",
            xlims = (0,100),
            ylims = (0,1),
            foreground_colour_legend = nothing,
            xlabel = "dose",
            ylabel = "biomass extremes",
            leg = :topleft,
            title = "Slope = $sl" * " (x)")
            
    # filter simulation output df by slope
    dfx_temp = filter(:slope => slope -> slope == slopes[i], dfx)

    # Add to empty plot
    plot!(plt, dfx_temp.dose, dfx_temp.maxB1, ls = :dot, c = :green, lw = 3, label = "basal")
    plot!(plt, dfx_temp.dose, dfx_temp.minB1, ls = :dot, c = :green, lw = 3, label = "")
    plot!(plt, dfx_temp.dose, dfx_temp.maxB2, ls = :dot, c = :blue, lw = 3, label = "intermediate")
    plot!(plt, dfx_temp.dose, dfx_temp.minB2, ls = :dot, c = :blue, lw = 3, label = "")
    plot!(plt, dfx_temp.dose, dfx_temp.maxB3, ls = :dot, c = :red, lw = 3, label = "top")
    plot!(plt, dfx_temp.dose, dfx_temp.minB3, ls = :dot, c = :red, lw = 3, label = "")

    display(plt)

    # add bifurc plot to collection of plots
    push!(Pslx, plt)
end    




####### VARYING ASYMPTOTES #######


#### rate = y ####
# empty object to store multiple plots
Pasy = []

for i in 1:length(asymptotes)
    as = asymptotes[i]
    # initialise an empty plot
    plt = Plots.plot([NaN], [NaN],
            label = "",
            xlims = (0,100),
            ylims = (0,1),
            foreground_colour_legend = nothing,
            xlabel = "dose",
            ylabel = "biomass extremes",
            leg = :topleft,
            title = "Asymptote = $as" * " (y)")
            
    # filter simulation output df by slope
    df2y_temp = filter(:asymptote => asymptote -> asymptote == as, df2y)

    # Add to empty plot
    plot!(plt, df2y_temp.dose, df2y_temp.maxB1, ls = :dot, c = :green, lw = 3, label = "basal")
    plot!(plt, df2y_temp.dose, df2y_temp.minB1, ls = :dot, c = :green, lw = 3, label = "")
    plot!(plt, df2y_temp.dose, df2y_temp.maxB2, ls = :dot, c = :blue, lw = 3, label = "intermediate")
    plot!(plt, df2y_temp.dose, df2y_temp.minB2, ls = :dot, c = :blue, lw = 3, label = "")
    plot!(plt, df2y_temp.dose, df2y_temp.maxB3, ls = :dot, c = :red, lw = 3, label = "top")
    plot!(plt, df2y_temp.dose, df2y_temp.minB3, ls = :dot, c = :red, lw = 3, label = "")

    display(plt)

    # add bifurc plot to collection of plots
    push!(Pasy, plt)
end    


#### rate = B0 ####
# empty object to store multiple plots
PasB0 = []

for i in 1:length(asymptotes)
    as = asymptotes[i]
    # initialise an empty plot
    plt = Plots.plot([NaN], [NaN],
            label = "",
            xlims = (0,100),
            ylims = (0,1),
            foreground_colour_legend = nothing,
            xlabel = "dose",
            ylabel = "biomass extremes",
            leg = :topleft,
            title = "Asymptote = $as" * " (B0)")
            
    # filter simulation output df by slope
    df2B0_temp = filter(:asymptote => asymptote -> asymptote == as, df2B0)

    # Add to empty plot
    plot!(plt, df2B0_temp.dose, df2B0_temp.maxB1, ls = :dot, c = :green, lw = 3, label = "basal")
    plot!(plt, df2B0_temp.dose, df2B0_temp.minB1, ls = :dot, c = :green, lw = 3, label = "")
    plot!(plt, df2B0_temp.dose, df2B0_temp.maxB2, ls = :dot, c = :blue, lw = 3, label = "intermediate")
    plot!(plt, df2B0_temp.dose, df2B0_temp.minB2, ls = :dot, c = :blue, lw = 3, label = "")
    plot!(plt, df2B0_temp.dose, df2B0_temp.maxB3, ls = :dot, c = :red, lw = 3, label = "top")
    plot!(plt, df2B0_temp.dose, df2B0_temp.minB3, ls = :dot, c = :red, lw = 3, label = "")

    display(plt)

    # add bifurc plot to collection of plots
    push!(PasB0, plt)
end    


#### rate = r ####
# empty object to store multiple plots
Pasr = []

for i in 1:length(asymptotes)
    as = asymptotes[i]
    # initialise an empty plot
    plt = Plots.plot([NaN], [NaN],
            label = "",
            xlims = (0,100),
            ylims = (0,1),
            foreground_colour_legend = nothing,
            xlabel = "dose",
            ylabel = "biomass extremes",
            leg = :topleft,
            title = "Asymptote = $as" * " (r)")
            
    # filter simulation output df by slope
    df2r_temp = filter(:asymptote => asymptote -> asymptote == as, df2r)

    # Add to empty plot
    plot!(plt, df2r_temp.dose, df2r_temp.maxB1, ls = :dot, c = :green, lw = 3, label = "basal")
    plot!(plt, df2r_temp.dose, df2r_temp.minB1, ls = :dot, c = :green, lw = 3, label = "")
    plot!(plt, df2r_temp.dose, df2r_temp.maxB2, ls = :dot, c = :blue, lw = 3, label = "intermediate")
    plot!(plt, df2r_temp.dose, df2r_temp.minB2, ls = :dot, c = :blue, lw = 3, label = "")
    plot!(plt, df2r_temp.dose, df2r_temp.maxB3, ls = :dot, c = :red, lw = 3, label = "top")
    plot!(plt, df2r_temp.dose, df2r_temp.minB3, ls = :dot, c = :red, lw = 3, label = "")

    display(plt)

    # add bifurc plot to collection of plots
    push!(Pasr, plt)
end    


#### rate = x ####
# empty object to store multiple plots
Pasx = []

for i in 1:length(asymptotes)
    as = asymptotes[i]
    # initialise an empty plot
    plt = Plots.plot([NaN], [NaN],
            label = "",
            xlims = (0,100),
            ylims = (0,1),
            foreground_colour_legend = nothing,
            xlabel = "dose",
            ylabel = "biomass extremes",
            leg = :topleft,
            title = "Asymptote = $as" * " (x)")
            
    # filter simulation output df by slope
    df2x_temp = filter(:asymptote => asymptote -> asymptote == as, df2x)

    # Add to empty plot
    plot!(plt, df2x_temp.dose, df2x_temp.maxB1, ls = :dot, c = :green, lw = 3, label = "basal")
    plot!(plt, df2x_temp.dose, df2x_temp.minB1, ls = :dot, c = :green, lw = 3, label = "")
    plot!(plt, df2x_temp.dose, df2x_temp.maxB2, ls = :dot, c = :blue, lw = 3, label = "intermediate")
    plot!(plt, df2x_temp.dose, df2x_temp.minB2, ls = :dot, c = :blue, lw = 3, label = "")
    plot!(plt, df2x_temp.dose, df2x_temp.maxB3, ls = :dot, c = :red, lw = 3, label = "top")
    plot!(plt, df2x_temp.dose, df2x_temp.minB3, ls = :dot, c = :red, lw = 3, label = "")

    display(plt)

    # add bifurc plot to collection of plots
    push!(Pasx, plt)
end    







####### VARYING INFLECTION POINTS #######


#### rate = y ####
# empty object to store multiple plots
Piny = []

for i in 1:length(inflections)
    in = inflections[i]
    # initialise an empty plot
    plt = Plots.plot([NaN], [NaN],
            label = "",
            xlims = (0,100),
            ylims = (0,1),
            foreground_colour_legend = nothing,
            xlabel = "dose",
            ylabel = "biomass extremes",
            leg = :topleft,
            title = "Inflection point = $in" * " (y)")
            
    # filter simulation output df by slope
    df3y_temp = filter(:xmid => xmid -> xmid == in, df3y)

    # Add to empty plot
    plot!(plt, df3y_temp.dose, df3y_temp.maxB1, ls = :dot, c = :green, lw = 3, label = "basal")
    plot!(plt, df3y_temp.dose, df3y_temp.minB1, ls = :dot, c = :green, lw = 3, label = "")
    plot!(plt, df3y_temp.dose, df3y_temp.maxB2, ls = :dot, c = :blue, lw = 3, label = "intermediate")
    plot!(plt, df3y_temp.dose, df3y_temp.minB2, ls = :dot, c = :blue, lw = 3, label = "")
    plot!(plt, df3y_temp.dose, df3y_temp.maxB3, ls = :dot, c = :red, lw = 3, label = "top")
    plot!(plt, df3y_temp.dose, df3y_temp.minB3, ls = :dot, c = :red, lw = 3, label = "")

    display(plt)

    # add bifurc plot to collection of plots
    push!(Piny, plt)
end   

#### rate = B0 ####
# empty object to store multiple plots
PinB0 = []

for i in 1:length(inflections)
    in = inflections[i]
    # initialise an empty plot
    plt = Plots.plot([NaN], [NaN],
            label = "",
            xlims = (0,100),
            ylims = (0,1),
            foreground_colour_legend = nothing,
            xlabel = "dose",
            ylabel = "biomass extremes",
            leg = :topleft,
            title = "Inflection point = $in" * " (B0)")
            
    # filter simulation output df by slope
    df3B0_temp = filter(:xmid => xmid -> xmid == in, df3B0)

    # Add to empty plot
    plot!(plt, df3B0_temp.dose, df3B0_temp.maxB1, ls = :dot, c = :green, lw = 3, label = "basal")
    plot!(plt, df3B0_temp.dose, df3B0_temp.minB1, ls = :dot, c = :green, lw = 3, label = "")
    plot!(plt, df3B0_temp.dose, df3B0_temp.maxB2, ls = :dot, c = :blue, lw = 3, label = "intermediate")
    plot!(plt, df3B0_temp.dose, df3B0_temp.minB2, ls = :dot, c = :blue, lw = 3, label = "")
    plot!(plt, df3B0_temp.dose, df3B0_temp.maxB3, ls = :dot, c = :red, lw = 3, label = "top")
    plot!(plt, df3B0_temp.dose, df3B0_temp.minB3, ls = :dot, c = :red, lw = 3, label = "")

    display(plt)

    # add bifurc plot to collection of plots
    push!(PinB0, plt)
end   


#### rate = r ####
# empty object to store multiple plots
Pinr = []

for i in 1:length(inflections)
    in = inflections[i]
    # initialise an empty plot
    plt = Plots.plot([NaN], [NaN],
            label = "",
            xlims = (0,100),
            ylims = (0,1),
            foreground_colour_legend = nothing,
            xlabel = "dose",
            ylabel = "biomass extremes",
            leg = :topleft,
            title = "Inflection point = $in" * " (r)")
            
    # filter simulation output df by inflection
    df3r_temp = filter(:xmid => xmid -> xmid == in, df3r)

    # Add to empty plot
    plot!(plt, df3r_temp.dose, df3r_temp.maxB1, ls = :dot, c = :green, lw = 3, label = "basal")
    plot!(plt, df3r_temp.dose, df3r_temp.minB1, ls = :dot, c = :green, lw = 3, label = "")
    plot!(plt, df3r_temp.dose, df3r_temp.maxB2, ls = :dot, c = :blue, lw = 3, label = "intermediate")
    plot!(plt, df3r_temp.dose, df3r_temp.minB2, ls = :dot, c = :blue, lw = 3, label = "")
    plot!(plt, df3r_temp.dose, df3r_temp.maxB3, ls = :dot, c = :red, lw = 3, label = "top")
    plot!(plt, df3r_temp.dose, df3r_temp.minB3, ls = :dot, c = :red, lw = 3, label = "")

    display(plt)

    # add bifurc plot to collection of plots
    push!(Pinr, plt)
end   


#### rate = x ####
# empty object to store multiple plots
Pinx = []

for i in 
    1:length(inflections)
    in = inflections[i]
    # initialise an empty plot
    plt = Plots.plot([NaN], [NaN],
            label = "",
            xlims = (0,100),
            ylims = (0,1),
            foreground_colour_legend = nothing,
            xlabel = "dose",
            ylabel = "biomass extremes",
            leg = :topleft,
            title = "Inflection point = $in" * " (x)")
            
    # filter simulation output df by slope
    df3x_temp = filter(:xmid => xmid -> xmid == in, df3x)

    # Add to empty plot
    plot!(plt, df3x_temp.dose, df3x_temp.maxB1, ls = :dot, c = :green, lw = 3, label = "basal")
    plot!(plt, df3x_temp.dose, df3x_temp.minB1, ls = :dot, c = :green, lw = 3, label = "")
    plot!(plt, df3x_temp.dose, df3x_temp.maxB2, ls = :dot, c = :blue, lw = 3, label = "intermediate")
    plot!(plt, df3x_temp.dose, df3x_temp.minB2, ls = :dot, c = :blue, lw = 3, label = "")
    plot!(plt, df3x_temp.dose, df3x_temp.maxB3, ls = :dot, c = :red, lw = 3, label = "top")
    plot!(plt, df3x_temp.dose, df3x_temp.minB3, ls = :dot, c = :red, lw = 3, label = "")

    display(plt)

    # add bifurc plot to collection of plots
    push!(Pinx, plt)
end   
