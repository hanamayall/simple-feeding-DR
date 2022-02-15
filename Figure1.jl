######## Checking to see if the values in Figure 1, of rates varying with fertilisation, align with our calcs

#### all species 0.01g
Z = 1
M = BodyMasses(Z=Z)

#### at 20C
T = 293.15

# Check limits
I_Kmin = 1
I_Kmax = 20

######### 1a - K 
carryingcapacity_BA(I_Kmin, param, M, T) # 0.2754228703338166
carryingcapacity_BA(5, param, M, T)      # 1.3771143516690831
carryingcapacity_BA(10, param, M, T)     # 2.7542287033381663
carryingcapacity_BA(I_Kmax, param, M, T) # 5.5084574066763325
# CORRECT


######### 1b - r 
growth_BA(param, M, T) # 4.900749719809166e-7
# CORRECT


######### 1c - x relative to r
metabolism_BA(param, M, T) # 2.7338159268322533e-7
2.7338159268322533e-7/4.900749719809166e-7 # 0.5578362665169335
# CORRECT

######### 1d - y relative to x 
max_ingestion_BA(param, M, Z, T) # 6.56212e-6
6.56212e-6/2.7338159268322533e-7 # 24.003518070083476
# INCORRECT # should be approx 41


######### 1e - B0 relative to K 
half_saturation_BA(param, M, Z , T) # 1.55731
1.55731/0.2754228703338166 # 5.6542508547402655 # I_K = 1
1.55731/1.3771143516690831 # 1.1308501709480532 # I_K = 5
1.55731/2.7542287033381663 # 0.5654250854740266 # I_K = 10
1.55731/5.5084574066763325 # 0.2827125427370133 # I_K = 20
# INCORRECT # Should be about twice these values