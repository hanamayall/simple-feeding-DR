####### VARYING SLOPES #######

#### Import dataframes of simulation results
# df = CSV.read("output_dfs/full_slope.csv", DataFrame)
# df2 = CSV.read("output_dfs/full_asymptote.csv", DataFrame)
# df3 = CSV.read("output_dfs/full_inflection.csv", DataFrame)


# In order to visualize our results as heatmaps (or a contour plots), we first split df by target and turn into 2D arrays:

# subset df by target rate
dfy = filter(:target => target -> target == "y", df)
dfB0 = filter(:target => target -> target == "B0", df)
dfr = filter(:target => target -> target == "r", df)
dfx = filter(:target => target -> target == "x", df)

# empty 2D arrays
DR_array_persistence_y = fill(NaN, length(doses), length(slopes)) #preallocate a 2d array for persistence values target rate = y
DR_array_persistence_B0 = fill(NaN, length(doses), length(slopes))
DR_array_persistence_r = fill(NaN, length(doses), length(slopes))
DR_array_persistence_x = fill(NaN, length(doses), length(slopes))

# Colour palette
palette2 = [RGB(190/255, 242/255, 170/255), RGB(149/255, 188/255, 219/255), RGB(30/255, 80/255, 150/255)]

#### rate = y ####
# fill 2D array for rate = y
for (j,s) in enumerate(slopes) 
	for (i,d) in enumerate(doses)
		tmp = dfy[(dfy.slope .== s) .& (dfy.dose .== d),:]
		DR_array_persistence_y[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = y
p_sl_y = heatmap(string.(log2.(slopes)), string.(doses), DR_array_persistence_y
    , title  = "Persistence (Target = y)", classes = 3, color = palette2
    , xlabel = "log2(Slope)", ylabel ="Dose" 
    )

#### rate = B0 ####
# fill 2D array for rate = B0
for (j,s) in enumerate(slopes) 
	for (i,d) in enumerate(doses)
		tmp = dfB0[(dfB0.slope .== s) .& (dfB0.dose .== d),:]
		DR_array_persistence_B0[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = B0
p_sl_B0 = heatmap(string.(log2.(slopes)), string.(doses), DR_array_persistence_B0
    , title  = "Persistence (Target = B0)", classes = 3, color = palette2
    , xlabel = "log2(Slope)", ylabel ="Dose" 
    )

#### rate = r ####
# fill 2D array for rate = r
for (j,s) in enumerate(slopes) 
	for (i,d) in enumerate(doses)
		tmp = dfr[(dfr.slope .== s) .& (dfr.dose .== d),:]
		DR_array_persistence_r[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = r
p_sl_r = heatmap(string.(log2.(slopes)), string.(doses), DR_array_persistence_r
    , title  = "Persistence (Target = r)", classes = 3, color = palette2
    , xlabel = "log2(Slope)", ylabel ="Dose" 
    )

#### rate = x ####
# fill 2D array for rate = x
for (j,s) in enumerate(slopes) 
	for (i,d) in enumerate(doses)
		tmp = dfx[(dfx.slope .== s) .& (dfx.dose .== d),:]
		DR_array_persistence_x[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = x
p_sl_x = heatmap(string.(log2.(slopes)), string.(doses), DR_array_persistence_x
    , title  = "Persistence (Target = x)", classes = 3, color = palette2
    , xlabel = "log2(Slope)", ylabel ="Dose" 
    )



l2 = @layout [a; b]
l4 = @layout [a b; c d]
plot(p_sl_y, p_sl_B0, p_sl_r, p_sl_x, layout = l4)


####### VARYING ASYMPTOTES #######
# subset df2 by target rate
df2y = filter(:target => target -> target == "y", df2)
df2B0 = filter(:target => target -> target == "B0", df2)
df2r = filter(:target => target -> target == "r", df2)
df2x = filter(:target => target -> target == "x", df2)


# empty 2D arrays
DR_array_persistence_y2 = fill(NaN, length(doses), length(asymptotes)) #preallocate a 2d array for persistence values target rate = y
DR_array_persistence_B02 = fill(NaN, length(doses), length(asymptotes))
DR_array_persistence_r2 = fill(NaN, length(doses), length(asymptotes))
DR_array_persistence_x2 = fill(NaN, length(doses), length(asymptotes))

#### rate = y ####
# fill 2D array for rate = y
for (j,s) in enumerate(asymptotes) 
	for (i,d) in enumerate(doses)
		tmp = df2y[(df2y.asymptote .== s) .& (df2y.dose .== d),:]
		DR_array_persistence_y2[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = y
p_as_y = heatmap(string.(asymptotes), string.(doses), DR_array_persistence_y2
    , title  = "Persistence (Target = y)", classes = 3, color = palette2
    , xlabel = "Asymptote", ylabel ="Dose" 
    )

#### rate = B0 ####
# fill 2D array for rate = B0
for (j,s) in enumerate(asymptotes) 
	for (i,d) in enumerate(doses)
		tmp = df2B0[(df2B0.asymptote .== s) .& (df2B0.dose .== d),:]
		DR_array_persistence_B02[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = B0
p_as_B0 = heatmap(string.(asymptotes), string.(doses), DR_array_persistence_B02
    , title  = "Persistence (Target = B0)", classes = 3, color = palette2
    , xlabel = "Asymptote", ylabel ="Dose" 
    )

#### rate = r ####
# fill 2D array for rate = r
for (j,s) in enumerate(asymptotes) 
	for (i,d) in enumerate(doses)
		tmp = df2r[(df2r.asymptote .== s) .& (df2r.dose .== d),:]
		DR_array_persistence_r2[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = r
p_as_r = heatmap(string.(asymptotes), string.(doses), DR_array_persistence_r2
    , title  = "Persistence (Target = r)", classes = 3, color = palette2
    , xlabel = "Asymptote", ylabel ="Dose" 
    )

#### rate = x ####
# fill 2D array for rate = x
for (j,s) in enumerate(asymptotes) 
	for (i,d) in enumerate(doses)
		tmp = df2x[(df2x.asymptote .== s) .& (df2x.dose .== d),:]
		DR_array_persistence_x2[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = x
p_as_x = heatmap(string.(asymptotes), string.(doses), DR_array_persistence_x2
    , title  = "Persistence (Target = x)", classes = 3, color = palette2
    , xlabel = "Asymptote", ylabel ="Dose" 
    )



####### VARYING INFLECTION POINTS #######
# subset df3 by target rate
df3y = filter(:target => target -> target == "y", df3)
df3B0 = filter(:target => target -> target == "B0", df3)
df3r = filter(:target => target -> target == "r", df3)
df3x = filter(:target => target -> target == "x", df3)


# empty 2D arrays
DR_array_persistence_y3 = fill(NaN, length(doses), length(inflections)) #preallocate a 2d array for persistence values target rate = y
DR_array_persistence_B03 = fill(NaN, length(doses), length(inflections))
DR_array_persistence_r3 = fill(NaN, length(doses), length(inflections))
DR_array_persistence_x3 = fill(NaN, length(doses), length(inflections))

#### rate = y ####
# fill 2D array for rate = y
for (j,s) in enumerate(inflections) 
	for (i,d) in enumerate(doses)
		tmp = df3y[(df3y.xmid .== s) .& (df3y.dose .== d),:]
		DR_array_persistence_y3[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = y
p_xmid_y = heatmap(string.(inflections), string.(doses), DR_array_persistence_y3
    , title  = "Persistence (Target = y)", classes = 3, color = palette2
    , xlabel = "Inflection", ylabel ="Dose" 
    )

#### rate = B0 ####
# fill 2D array for rate = B0
for (j,s) in enumerate(inflections) 
	for (i,d) in enumerate(doses)
		tmp = df3B0[(df3B0.xmid .== s) .& (df3B0.dose .== d),:]
		DR_array_persistence_B03[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = B0
p_xmid_B0 = heatmap(string.(inflections), string.(doses), DR_array_persistence_B03
    , title  = "Persistence (Target = B0)", classes = 3, color = palette2
    , xlabel = "Inflection", ylabel ="Dose" 
    )

#### rate = r ####
# fill 2D array for rate = r
for (j,s) in enumerate(inflections) 
	for (i,d) in enumerate(doses)
		tmp = df3r[(df3r.xmid .== s) .& (df3r.dose .== d),:]
		DR_array_persistence_r3[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = r
p_xmid_r = heatmap(string.(inflections), string.(doses), DR_array_persistence_r3
    , title  = "Persistence (Target = r)", classes = 3, color = palette2
    , xlabel = "Inflection", ylabel ="Dose" 
    )
#### rate = x ####
# fill 2D array for rate = x
for (j,s) in enumerate(inflections) 
	for (i,d) in enumerate(doses)
		tmp = df3x[(df3x.xmid .== s) .& (df3x.dose .== d),:]
		DR_array_persistence_x3[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = x
p_xmid_x = heatmap(string.(inflections), string.(doses), DR_array_persistence_x3
    , title  = "Persistence (Target = x)", classes = 3, color = palette2
    , xlabel = "Inflection", ylabel ="Dose" 
    )
