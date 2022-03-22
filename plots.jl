####### VARYING SLOPES #######

# In order to visualize our results as heatmaps (or a contour plots), we first split df by target and turn into 2D arrays:

# subset df by target rate
dfy = filter(:target => target -> target == "y", df)
dfB0 = filter(:target => target -> target == "B0", df)


# empty 2D arrays
DR_array_persistence_y = fill(NaN, length(doses), length(slopes)) #preallocate a 2d array for persistence values target rate = y
DR_array_persistence_B0 = fill(NaN, length(doses), length(slopes))

###### rate = y
# fill 2D array for rate = y
for (j,s) in enumerate(slopes) 
	for (i,d) in enumerate(doses)
		tmp = dfy[(dfy.slope .== s) .& (dfy.dose .== d),:]
		DR_array_persistence_y[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = y
palette2 = [RGB(190/255, 242/255, 170/255), RGB(149/255, 188/255, 219/255), RGB(30/255, 80/255, 150/255)]
p1 = heatmap(string.(log2.(slopes)), string.(doses), DR_array_persistence_y
    , title  = "Persistence (Target = y)", classes = 3, color = palette2
    , xlabel = "log2(Slopes)", ylabel ="Doses" 
    )

###### rate = B0
# fill 2D array for rate = B0
for (j,s) in enumerate(slopes) 
	for (i,d) in enumerate(doses)
		tmp = dfB0[(dfy.slope .== s) .& (dfB0.dose .== d),:]
		DR_array_persistence_B0[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = B0
p2 = heatmap(string.(log2.(slopes)), string.(doses), DR_array_persistence_B0
    , title  = "Persistence (Target = B0)", classes = 3, color = palette2
    , xlabel = "log2(slopes)", ylabel ="Doses" 
    )

l2 = @layout [a; b]
plot(p1, p2, layout = l2)


####### VARYING ASYMPTOTES #######
# subset df2 by target rate
df2y = filter(:target => target -> target == "y", df2)
df2B0 = filter(:target => target -> target == "B0", df2)


# empty 2D arrays
DR_array_persistence_y2 = fill(NaN, length(doses), length(asymptotes)) #preallocate a 2d array for persistence values target rate = y
DR_array_persistence_B02 = fill(NaN, length(doses), length(asymptotes))

###### rate = y
# fill 2D array for rate = y
for (j,s) in enumerate(asymptotes) 
	for (i,d) in enumerate(doses)
		tmp = df2y[(df2y.asymptote .== s) .& (df2y.dose .== d),:]
		DR_array_persistence_y2[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = y
p3 = heatmap(string.(asymptotes), string.(doses), DR_array_persistence_y2
    , title  = "Persistence (Target = y)", classes = 3, color = palette2
    , xlabel = "asymptotes", ylabel ="Doses" 
    )

###### rate = B0
# fill 2D array for rate = B0
for (j,s) in enumerate(asymptotes) 
	for (i,d) in enumerate(doses)
		tmp = df2B0[(df2y.asymptote .== s) .& (df2B0.dose .== d),:]
		DR_array_persistence_B02[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = B0
p4 = heatmap(string.(asymptotes), string.(doses), DR_array_persistence_B02
    , title  = "Persistence (Target = B0)", classes = 3, color = palette2
    , xlabel = "asymptotes", ylabel ="Doses" 
    )





####### VARYING INFLECTION POINTS #######
# subset df3 by target rate
df3y = filter(:target => target -> target == "y", df3)
df3B0 = filter(:target => target -> target == "B0", df3)


# empty 2D arrays
DR_array_persistence_y3 = fill(NaN, length(doses), length(inflections)) #preallocate a 2d array for persistence values target rate = y
DR_array_persistence_B03 = fill(NaN, length(doses), length(inflections))

###### rate = y
# fill 2D array for rate = y
for (j,s) in enumerate(inflections) 
	for (i,d) in enumerate(doses)
		tmp = df3y[(df3y.xmid .== s) .& (df3y.dose .== d),:]
		DR_array_persistence_y3[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = y
p5 = heatmap(string.(inflections), string.(doses), DR_array_persistence_y3
    , title  = "Persistence (Target = y)", classes = 3, color = palette2
    , xlabel = "inflection", ylabel ="Doses" 
    )

###### rate = B0
# fill 2D array for rate = B0
for (j,s) in enumerate(inflections) 
	for (i,d) in enumerate(doses)
		tmp = df3B0[(df3y.xmid .== s) .& (df3B0.dose .== d),:]
		DR_array_persistence_B03[i,j] = tmp.sp_survival[1]
	end
end

# plot for rate = B0
p6 = heatmap(string.(inflections), string.(doses), DR_array_persistence_B03
    , title  = "Persistence (Target = B0)", classes = 3, color = palette2
    , xlabel = "inflection", ylabel ="Doses" 
    )

