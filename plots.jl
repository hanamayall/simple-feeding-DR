#### Plotting the interactive effects of temperature and fertilisation

# In order to visualize our results as heatmaps (or a contour plots), we first split df by target and turn into 2D arrays:

# # subset df by body mass ratio
# dfZ1 = filter(:Z => Z -> Z == 1, df)
# dfZ10 = filter(:Z => Z -> Z == 10, df)
# dfZ100 = filter(:Z => Z -> Z == 100, df)

# subset df by target rate
dfy = filter(:target => target -> target == "y", df)
dfB0 = filter(:target => target -> target == "B0", df)


# # empty 2D arrays
# TK_array_persistence1 = fill(NaN, length(allT), length(allI_K)) #preallocate a 2d array for persistence values Z = 1
# TK_array_persistence10 = fill(NaN, length(allT), length(allI_K))
# TK_array_persistence100 = fill(NaN, length(allT), length(allI_K))
# TK_array_cc = fill(NaN, length(allT), length(allI_K))

# empty 2D arrays
DR_array_persistence_y = fill(NaN, length(doses), length(slopes)) #preallocate a 2d array for persistence values target rate = y
DR_array_persistence_B0 = fill(NaN, length(doses), length(slopes))


# ###### Z = 1
# # fill 2D array for Z = 1
# for (j,k) in enumerate(allI_K) 
# 	for (i,t) in enumerate(allT)
# 		tmp = dfZ1[(dfZ1.I_K .== k) .& (dfZ1.T .== t),:]
# 		TK_array_persistence1[i,j] = tmp.sp_survival[1]
# 	end
# end

###### rate = y
# fill 2D array for rate = y
for (j,s) in enumerate(slopes) 
	for (i,d) in enumerate(doses)
		tmp = dfy[(dfy.slope .== s) .& (dfy.dose .== d),:]
		DR_array_persistence_y[i,j] = tmp.sp_survival[1]
	end
end

# # plot for Z = 1
# palette2 = [RGB(190/255, 242/255, 170/255), RGB(149/255, 188/255, 219/255), RGB(30/255, 80/255, 150/255)]
# p1 = heatmap(string.(allI_K), string.(allT .- 273.15), TK_array_persistence1
#     , title  = "3b, Z = 1", classes = 3, color = palette2
#     , xlabel = "Fertilisation", ylabel ="Temperature (C)" 
#     )

# plot for rate = y
palette2 = [RGB(190/255, 242/255, 170/255), RGB(149/255, 188/255, 219/255), RGB(30/255, 80/255, 150/255)]
p1 = heatmap(string.(slopes), string.(doses), DR_array_persistencey
    , title  = "Target rate = y", classes = 3, color = palette2
    , xlabel = "Slopes", ylabel ="Doses" 
    )



# ###### Z = 10
# # fill 2D array for Z = 10
# for (j,k) in enumerate(allI_K) 
# 	for (i,t) in enumerate(allT)
# 		tmp = dfZ10[(dfZ10.I_K .== k) .& (dfZ10.T .== t),:]
# 		TK_array_persistence10[i,j] = tmp.sp_survival[1]
# 	end
# end
###### rate = B0
# fill 2D array for rate = B0
for (j,s) in enumerate(slopes) 
	for (i,d) in enumerate(doses)
		tmp = dfB0[(dfy.slope .== s) .& (dfB0.dose .== d),:]
		DR_array_persistence_B0[i,j] = tmp.sp_survival[1]
	end
end


# plot for Z = 10
p10 = heatmap(string.(allI_K), string.(allT .- 273.15), TK_array_persistence10
    , title  = "3c, Z = 10", classes = 3, color = palette2
    , xlabel = "Fertilisation", ylabel ="Temperature (C)" )


###### Z = 100
# fill 2D array for Z = 100
for (j,k) in enumerate(allI_K) 
	for (i,t) in enumerate(allT)
		tmp = dfZ100[(dfZ100.I_K .== k) .& (dfZ100.T .== t),:]
		TK_array_persistence100[i,j] = tmp.sp_survival[1]
	end
end

# plot for Z = 1
p100 = heatmap(string.(allI_K), string.(allT .- 273.15), TK_array_persistence100
    , title  = "3d, Z = 100", classes = 3, color = palette2
    , xlabel = "Fertilisation", ylabel ="Temperature (C)" )



###### Log 10 of the carrying capacity of the system
# fill 2D array for Z = 1 of carrying capacity
for (j,k) in enumerate(allI_K) 
	for (i,t) in enumerate(allT)
		tmp = dfZ1[(dfZ1.I_K .== k) .& (dfZ1.T .== t),:]
		TK_array_cc[i,j] = log10(tmp.K[1])
	end
end

# plot for Z = 1
palette1 = reverse([RGB(255/255, 255/255, 255/255)
    , RGB(245/255, 242/255, 81/255)
    , RGB(255/255, 242/255, 0/255)
    , RGB(255/255, 196/255, 0/255)
    , RGB(255/255, 145/255, 0/255)
    , RGB(255/255, 111/255, 0/255)
    , RGB(255/255, 25/255, 0/255)])
pcc = heatmap(string.(allI_K), string.(allT .- 273.15), TK_array_cc
    , title  = "3a, log10(K)", classes = 7, color = palette1
    , xlabel = "Fertilisation", ylabel ="Temperature (C)" )





l3 = @layout [a b; c d]
plot(pcc, p1, p10, p100, layout = l3)