######## Checking to see if the values in Figure 2, of rates varying with temperature, align with our calcs

#### all species 0.01g
Z = 1
M = BodyMasses(Z=Z)

#### fertilisation level 3
I_K = 3

# Check T limits & intervals
Tmin = 273.15
T10 = 283.15
T20 = 293.15
T30 = 303.15
Tmax = 313.15

######### 1a - K 
carryingcapacity_BA(I_K, param, M, Tmin)  # 6.469796324965876
carryingcapacity_BA(I_K, param, M, T10)   # 2.229581330642422
carryingcapacity_BA(I_K, param, M, T20)   # 0.8262686110014499
carryingcapacity_BA(I_K, param, M, T30)   # 0.32693445475490657
carryingcapacity_BA(I_K, param, M, Tmax)  # 0.1372514415844402
# CORRECT #

######### 1b - r 
growth_BA(param, M, Tmin) # 4.293834089901734e-8
growth_BA(param, M, T20)  # 4.900749719809166e-7
growth_BA(param, M, T30)  # 1.4677418185488954e-6
growth_BA(param, M, Tmax) # 4.098371477948643e-6
# CORRECT #


######### 1c - x relative to r
metabolism_BA(param, M, Tmin) # 3.6997852501357905e-8
3.6997852501357905e-8/4.293834089901734e-8            # 0.8616507234960403

metabolism_BA(param, M, T10) # 1.0418637435157166e-7

metabolism_BA(param, M, T20)  # 2.7338159268322533e-7
2.7338159268322533e-7/4.900749719809166e-7            # 0.5578362665169335

metabolism_BA(param, M, T30)  # 6.731119190535962e-7
 
metabolism_BA(param, M, Tmax) # 1.5646345778326476e-6
1.5646345778326476e-6/4.098371477948643e-6            # 0.3817698288823232
# CORRECT #


######### 1d - y relative to x 
max_ingestion_BA(param, M, Z, Tmin) # 3.08851e-6 
3.08851e-6/3.6997852501357905e-8                      # 83.47808835355092

max_ingestion_BA(param, M, Z, T10) # 4.56222e-6
4.56222e-6/1.0418637435157166e-7                      # 43.78902738860092

max_ingestion_BA(param, M, Z, T20)  # 6.56212e-6
6.56212e-6/2.7338159268322533e-7                      # 24.003518070083476

max_ingestion_BA(param, M, Z, T30)  # 9.21504e-6 
9.21504e-6 /6.731119190535962e-7                      # 13.690204762614309

max_ingestion_BA(param, M, Z, Tmax) # 1.26629e-5
1.26629e-5/1.5646345778326476e-6                      # 8.093199638691877

# INCORRECT # 

######### 1e - B0 relative to K 
half_saturation_BA(param, M, Z, Tmin) #  2.20513
2.20513/ 6.469796324965876                            # 0.3408345316050781

half_saturation_BA(param, M, Z , T10) # 1.84178
1.84178/2.229581330642422                             # 0.8260654028123376

half_saturation_BA(param, M, Z , T20) # 1.55731
1.55731/0.8262686110014499                            # 1.884750284913422

half_saturation_BA(param, M, Z , T30) # 1.33143 
1.33143 /0.32693445475490657                          # 4.072467678569195

half_saturation_BA(param, M, Z , Tmax) #1.14977
1.14977/ 0.1372514415844402                           # 8.377106912153163