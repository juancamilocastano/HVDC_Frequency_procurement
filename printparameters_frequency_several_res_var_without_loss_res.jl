function printparameters_frequency_several_res_var_without_loss_res!(m::Model)
G=m.ext[:sets][:G]
G1=m.ext[:sets][:G1]
G2=m.ext[:sets][:G2]
E=m.ext[:sets][:E]
E1=m.ext[:sets][:E1]
E2=m.ext[:sets][:E2]
S=m.ext[:sets][:S]
S1=m.ext[:sets][:S1]
S2=m.ext[:sets][:S2]
CV=m.ext[:sets][:CV]
CV1=m.ext[:sets][:CV1]
CV2=m.ext[:sets][:CV2]
T=m.ext[:sets][:t]
N1=m.ext[:sets][:N1]
N2=m.ext[:sets][:N2]

baseKG=m.ext[:parameters][:baseKG]
baseMVA=m.ext[:parameters][:baseMVA]
pmax = m.ext[:parameters][:pmax]
ic = m.ext[:parameters][:ic]
f1 = m.ext[:parameters][:f1]
f2 = m.ext[:parameters][:f2]
Edeployment = m.ext[:parameters][:Edeployment]
G_dt = m.ext[:parameters][:G_dt]


conv_p_ac=JuMP.value.(m.ext[:variables][:conv_p_ac])*baseMVA
zgvec=JuMP.value.(m.ext[:variables][:zg])
δgvec=JuMP.value.(m.ext[:variables][:δg])
δhvdc=JuMP.value.(m.ext[:variables][:δhvdc])





demand = m.ext[:parameters][:demand]
wind = m.ext[:parameters][:wind]
baseKG=m.ext[:parameters][:baseKG]
baseMVA=m.ext[:parameters][:baseMVA]
pg=JuMP.value.(m.ext[:variables][:pg])*baseMVA
pgvec= [pg[g,t] for g in G, t in T]
pev=JuMP.value.(m.ext[:variables][:pe])*baseMVA
pevec= [pev[e,t] for e in E, t in T]
hfe=JuMP.value.(m.ext[:variables][:hfe])*baseKG
hfevec= [hfe[e,t] for e in E, t in T]
hss=JuMP.value.(m.ext[:variables][:hss])*baseKG
hssvec= [hss[e,t] for e in E, t in T]
hfgconsum=JuMP.value.(m.ext[:variables][:hfgconsum])*baseKG
hfgconsumvec= [hfgconsum[e,t] for e in E, t in T]
hfginyect=JuMP.value.(m.ext[:variables][:hfginyect])*baseKG
hfginyectvec= [hfginyect[e,t] for e in E, t in T]
psc=JuMP.value.(m.ext[:variables][:psc])*baseMVA
pscvec= [psc[s,t] for s in S, t in T]
psd=JuMP.value.(m.ext[:variables][:psd])*baseMVA
psdvec= [psd[s,t] for s in S, t in T]
pe_compressor=JuMP.value.(m.ext[:variables][:pe_compressor])*baseMVA
pevec_compressor= [pe_compressor[e,t] for e in E, t in T]
es=JuMP.value.(m.ext[:variables][:es])*baseMVA
esvec= [es[s,t] for s in S, t in T]
pg=JuMP.value.(m.ext[:variables][:pg])*baseMVA
pg1= [pg[g,t] for g in G1, t in T]
pg2= [pg[g,t] for g in G2, t in T]
plg1= JuMP.value.(m.ext[:variables][:plg1])*baseMVA
plg2= JuMP.value.(m.ext[:variables][:plg2])*baseMVA
plc1= JuMP.value.(m.ext[:variables][:plc1])*baseMVA
plc2= JuMP.value.(m.ext[:variables][:plc2])*baseMVA
plg1vec= Array(plg1)
plg2vec= Array(plg2)
plc1vec= Array(plc1)    
plc2vec= Array(plc2)
rg_lg1=JuMP.value.(m.ext[:variables][:rg_lg1])*baseMVA
rg_lc1=JuMP.value.(m.ext[:variables][:rg_lc1])*baseMVA
re_lg1=JuMP.value.(m.ext[:variables][:re_lg1])*baseMVA
re_lc1=JuMP.value.(m.ext[:variables][:re_lc1])*baseMVA
rs_lg1=JuMP.value.(m.ext[:variables][:rs_lg1])*baseMVA
rs_lc1=JuMP.value.(m.ext[:variables][:rs_lc1])*baseMVA
rhvdc_lg1=JuMP.value.(m.ext[:variables][:rhvdc_lg1])*baseMVA
rhvdc_lc1=JuMP.value.(m.ext[:variables][:rhvdc_lc1])*baseMVA
rg_lg2=JuMP.value.(m.ext[:variables][:rg_lg2])*baseMVA
rg_lc2=JuMP.value.(m.ext[:variables][:rg_lc2])*baseMVA
re_lg2=JuMP.value.(m.ext[:variables][:re_lg2])*baseMVA
re_lc2=JuMP.value.(m.ext[:variables][:re_lc2])*baseMVA
rs_lg2=JuMP.value.(m.ext[:variables][:rs_lg2])*baseMVA
rs_lc2=JuMP.value.(m.ext[:variables][:rs_lc2])*baseMVA
rhvdc_lg2=JuMP.value.(m.ext[:variables][:rhvdc_lg2])*baseMVA
rhvdc_lc2=JuMP.value.(m.ext[:variables][:rhvdc_lc2])*baseMVA
rg_lg1vec= [rg_lg1[g,t] for g in G1, t in T]
rg_lc1vec= [rg_lc1[g,t] for g in G1, t in T]
re_lg1vec= [re_lg1[e,t] for e in E1, t in T]
re_lc1vec= [re_lc1[e,t] for e in E1, t in T]
rs_lg1vec= [rs_lg1[s,t] for s in S1, t in T]
rs_lc1vec= [rs_lc1[s,t] for s in S1, t in T]
rhvdc_lg1vec= [rhvdc_lg1[cv,t] for cv in CV1, t in T]
rhvdc_lc1vec= [rhvdc_lc1[cv,t] for cv in CV1, t in T]
rg_lg2vec= [rg_lg2[g,t] for g in G2, t in T]
rg_lc2vec= [rg_lc2[g,t] for g in G2, t in T]
re_lg2vec= [re_lg2[e,t] for e in E2, t in T]
re_lc2vec= [re_lc2[e,t] for e in E2, t in T]
rs_lg2vec= [rs_lg2[s,t] for s in S2, t in T]
rs_lc2vec= [rs_lc2[s,t] for s in S2, t in T]
keys_1 = axes(rhvdc_lg1, 1)
order_keys_1 = sort(keys_1, by = x -> parse(Int, x))
keys_2 = axes(rhvdc_lg2, 1)
order_keys_2 = sort(keys_2, by = x -> parse(Int, x))
rhvdc_lg1vec= Array(rhvdc_lg1[order_keys_1, :])
rhvdc_lc1vec= Array(rhvdc_lc1[order_keys_1, :])
rhvdc_lg2vec= Array(rhvdc_lg2[order_keys_2, :])
rhvdc_lc2vec= Array(rhvdc_lc2[order_keys_2, :])




flows_hvdc=JuMP.value.(m.ext[:variables][:brdc_p])*baseMVA
flows_hvdc24= Array(flows_hvdc[("1", "2", "4"),:])
flows_hvdc31= Array(flows_hvdc[("2", "3", "1"),:])
conv_p_ac=JuMP.value.(m.ext[:variables][:conv_p_ac])*baseMVA
conv_p_dc=JuMP.value.(m.ext[:variables][:conv_p_dc])*baseMVA
δhvdc=JuMP.value.(m.ext[:variables][:δhvdc])
demandmatrix1= [demand[n][t] for n in N1, t in T]
demandwithoutEB1=vec(sum(demandmatrix1, dims=1))*baseMVA
demandmatrix2= [demand[n][t] for n in N2, t in T]
demandwithoutEB2=vec(sum(demandmatrix2, dims=1))*baseMVA
wind1= [wind[n][t] for n in N1, t in T]
wind1vec=vec(sum(wind1, dims=1))*baseMVA
wind2= [wind[n][t] for n in N2, t in T]
wind2vec=vec(sum(wind2, dims=1))*baseMVA
pb=JuMP.value.(m.ext[:variables][:pb])*baseMVA
pb_13= Array(pb[("2", "1", "3"),:])
pb_23= Array(pb[("3", "2", "3"),:])
pb_12= Array(pb[("1", "1", "2"),:])
pb_56= Array(pb[("6", "5", "6"),:])
pb_45= Array(pb[("4", "4", "5"),:])
pb_46= Array(pb[("5", "4", "6"),:])

rocof_plg1=Dict()
rocof_plg2=Dict()
rocof_plc1=Dict()
rocof_plc2=Dict()
Inertia_nadir_frequency_1=Dict()
Inertia_nadir_frequency_2=Dict()
Inertia_nadir_frequency_converter_1=Dict()
Inertia_nadir_frequency_converter_2=Dict()
procured_inertia_1=Dict()
procured_inertia_2=Dict()
Deltaf_nadir_plg1=Dict()
Deltaf_nadir_plg2=Dict()
Deltaf_nadir_plc1=Dict()
Deltaf_nadir_plc2=Dict()
total_rg_lg1=Dict()
total_rg_lc1=Dict()
total_re_lg1=Dict()
total_re_lc1=Dict()
total_rs_lg1=Dict()
total_rs_lc1=Dict()
total_rhvdc_lg1=Dict()
total_rhvdc_lc1=Dict()
total_rg_lg2=Dict()
total_rg_lc2=Dict()
total_re_lg2=Dict()
total_re_lc2=Dict()
total_rs_lg2=Dict()
total_rs_lc2=Dict()
total_rhvdc_lg2=Dict()
total_rhvdc_lc2=Dict()
total_fast_reserve_lg1=Dict()
total_fast_reserve_lg2=Dict()
total_fast_reserve_lc1=Dict()
total_fast_reserve_lc2=Dict()



t_nadir_plg1=Dict()
t_nadir_plg2=Dict()
t_nadir_plc1=Dict()
t_nadir_plc2=Dict()

for t in T 
        Inertia_nadir_frequency_1[t]=sum((zgvec[g,t]-δgvec[g,t])*ic[g]*pmax[g]*baseMVA for g in G1)
        Inertia_nadir_frequency_2[t]=sum((zgvec[g,t]-δgvec[g,t])*ic[g]*pmax[g]*baseMVA for g in G2)
        Inertia_nadir_frequency_converter_1[t]=sum((zgvec[g,t])*ic[g]*pmax[g]*baseMVA for g in G1)
        Inertia_nadir_frequency_converter_2[t]=sum((zgvec[g,t])*ic[g]*pmax[g]*baseMVA for g in G2)
        procured_inertia_1[t]=Inertia_nadir_frequency_converter_1[t] # When the converter fails, the total inertia is the inertia corresponding to the total procured inertia
        procured_inertia_2[t]=Inertia_nadir_frequency_converter_2[t]
        total_rg_lg1[t]=sum(rg_lg1[g,t] for g in G1)
        total_re_lg1[t]=sum(re_lg1[e,t] for e in E1)
        total_rs_lg1[t]=sum(rs_lg1[s,t] for s in S1)
        total_rhvdc_lg1[t]=sum(rhvdc_lg1[cv,t] for cv in CV1)
        total_fast_reserve_lg1[t]=sum(re_lg1[e,t] for e in E1)+sum(rs_lg1[s,t] for s in S1)+sum(rhvdc_lg1[cv,t] for cv in CV1)
        total_rg_lc1[t]=sum(rg_lc1[g,t] for g in G1)
        total_re_lc1[t]=sum(re_lc1[e,t] for e in E1)
        total_rs_lc1[t]=sum(rs_lc1[s,t] for s in S1)     
        total_rhvdc_lc1[t]=sum(rhvdc_lc1[cv,t] for cv in CV1)
        total_fast_reserve_lc1[t]=sum(re_lc1[e,t] for e in E1)+sum(rs_lc1[s,t] for s in S1)+sum(rhvdc_lc1[cv,t] for cv in CV1)
        total_rg_lg2[t]=sum(rg_lg2[g,t] for g in G2)
        total_re_lg2[t]=sum(re_lg2[e,t] for e in E2)
        total_rs_lg2[t]=sum(rs_lg2[s,t] for s in S2)
        total_rhvdc_lg2[t]=sum(rhvdc_lg2[cv,t] for cv in CV2)
        total_fast_reserve_lg2[t]=+sum(re_lg2[e,t] for e in E2)+sum(rs_lg2[s,t] for s in S2)+sum(rhvdc_lg2[cv,t] for cv in CV2)
        total_rg_lc2[t]=sum(rg_lc2[g,t] for g in G2)
        total_re_lc2[t]=sum(re_lc2[e,t] for e in E2)
        total_rs_lc2[t]=sum(rs_lc2[s,t] for s in S2)
        total_rhvdc_lc2[t]=sum(rhvdc_lc2[cv,t] for cv in CV2)
        total_fast_reserve_lc2[t]=sum(re_lc2[e,t] for e in E2)+sum(rs_lc2[s,t] for s in S2)+sum(rhvdc_lc2[cv,t] for cv in CV2) 
end

Inertia_nadir_frequency_1_vec = [Inertia_nadir_frequency_1[t] for t in T]
Inertia_nadir_frequency_2_vec = [Inertia_nadir_frequency_2[t] for t in T]
Inertia_nadir_frequency_converter_1_vec = [Inertia_nadir_frequency_converter_1[t] for t in T]
Inertia_nadir_frequency_converter_2_vec = [Inertia_nadir_frequency_converter_2[t] for t in T]


for t in T
        rocof_plg1[t]= f1*plg1[t]/(2*Inertia_nadir_frequency_1[t])
        rocof_plg2[t]= f2*plg2[t]/(2*Inertia_nadir_frequency_2[t])
        rocof_plc1[t]= f1*plc1[t]/(2*Inertia_nadir_frequency_converter_1[t])
        rocof_plc2[t]= f2*plc2[t]/(2*Inertia_nadir_frequency_converter_2[t])
        Deltaf_nadir_plg1[t] =((plg1[t]- sum(re_lg1[e, t] for e in E1)- sum(rs_lg1[s, t] for s in S1)- sum(rhvdc_lg1[cv, t] for cv in CV1))^2*G_dt["1"]/sum(rg_lg1[g, t]  for g in G1) + (sum(re_lg1[e, t] for e in E1) + sum(rs_lg1[s, t] for s in S1) + sum(rhvdc_lg1[cv, t]  for cv in CV1)) * Edeployment["1"] ) * f1 / (4 * Inertia_nadir_frequency_1[t])
        Deltaf_nadir_plg2[t] =((plg2[t]- sum(re_lg2[e, t] for e in E2)- sum(rs_lg2[s, t] for s in S2)- sum(rhvdc_lg2[cv, t] for cv in CV2))^2*G_dt["1"]/sum(rg_lg2[g, t]  for g in G2) + (sum(re_lg2[e, t] for e in E2) + sum(rs_lg2[s, t] for s in S2) + sum(rhvdc_lg2[cv, t]  for cv in CV2)) * Edeployment["1"] ) * f2 / (4 * Inertia_nadir_frequency_2[t])
        Deltaf_nadir_plc1[t] =((plc1[t]- sum(re_lc1[e, t] for e in E1)- sum(rs_lc1[s, t] for s in S1)- sum(rhvdc_lc1[cv, t] for cv in CV1))^2*G_dt["1"]/sum(rg_lc1[g, t]  for g in G1) + (sum(re_lc1[e, t] for e in E1) + sum(rs_lc1[s, t] for s in S1) + sum(rhvdc_lc1[cv, t]  for cv in CV1)) * Edeployment["1"] ) * f1 / (4 * Inertia_nadir_frequency_converter_1[t])
        Deltaf_nadir_plc2[t] =((plc2[t]- sum(re_lc2[e, t] for e in E2)- sum(rs_lc2[s, t] for s in S2)- sum(rhvdc_lc2[cv, t] for cv in CV2))^2*G_dt["1"]/sum(rg_lc2[g, t]  for g in G2) + (sum(re_lc2[e, t] for e in E2) + sum(rs_lc2[s, t] for s in S2) + sum(rhvdc_lc2[cv, t]  for cv in CV2)) * Edeployment["1"] ) * f2 / (4 * Inertia_nadir_frequency_converter_2[t])
 end


# ===============================
# Write results to a TXT file
# ===============================

output_file = "frequency_results.txt"

open(output_file, "w") do io


    println(io, "===== ROCOF =====")
    println(io, "rocof_plg1:")
    for t in T
        println(io, "t=$t  value=$(rocof_plg1[t])")
    end
    println(io)

    println(io, "rocof_plg2:")
    for t in T
        println(io, "t=$t  value=$(rocof_plg2[t])")
    end
    println(io)

    println(io, "rocof_plc1:")
    for t in T
        println(io, "t=$t  value=$(rocof_plc1[t])")
    end
    println(io)

    println(io, "rocof_plc2:")
    for t in T
        println(io, "t=$t  value=$(rocof_plc2[t])")
    end
    println(io)

    println(io, "===== INERTIA =====")
    println(io, "Inertia_nadir_frequency_1:")
    for t in T
        println(io, "t=$t  value=$(Inertia_nadir_frequency_1[t])")
    end
    println(io)

    println(io, "Inertia_nadir_frequency_2:")
    for t in T
        println(io, "t=$t  value=$(Inertia_nadir_frequency_2[t])")
    end
    println(io)

    println(io, "procured_inertia_1:")
    for t in T
        println(io, "t=$t  value=$(procured_inertia_1[t])")
    end
    println(io)

    println(io, "procured_inertia_2:")
    for t in T
        println(io, "t=$t  value=$(procured_inertia_2[t])")
    end
    println(io)

    println(io, "===== NADIR FREQUENCY DEVIATION =====")
    println(io, "Deltaf_nadir_plg1:")
    for t in T
        println(io, "t=$t  value=$(Deltaf_nadir_plg1[t])")
    end
    println(io)

    println(io, "Deltaf_nadir_plg2:")
    for t in T
        println(io, "t=$t  value=$(Deltaf_nadir_plg2[t])")
    end
    println(io)

    println(io, "Deltaf_nadir_plc1:")
    for t in T
        println(io, "t=$t  value=$(Deltaf_nadir_plc1[t])")
    end
    println(io)

    println(io, "Deltaf_nadir_plc2:")
    for t in T
        println(io, "t=$t  value=$(Deltaf_nadir_plc2[t])")
    end

    println(io, "===== TOTAL RESERVES LG1 =====")
    for t in T
        println(io, "t=$t  rg_lg1 =$(total_rg_lg1[t])",", re_lg1=$(total_re_lg1[t])", ", rs_lg1=$(total_rs_lg1[t])", ", rhvdc_lg1=$(total_rhvdc_lg1[t])", ", fast_reserve_lg1=$(total_fast_reserve_lg1[t])")
    end

    println(io, "===== TOTAL RESERVES LC1 =====")
   
    for t in T
        println(io, "t=$t  rg_lc1 =$(total_rg_lc1[t])",", re_lc1=$(total_re_lc1[t])", ", rs_lc1=$(total_rs_lc1[t])", ", rhvdc_lc1=$(total_rhvdc_lc1[t])", ", fast_reserve_lc1=$(total_fast_reserve_lc1[t])")
    end

    println(io, "===== TOTAL RESERVES LG2 =====")
    for t in T
        println(io, "t=$t  rg_lg2 =$(total_rg_lg2[t])",", re_lg2=$(total_re_lg2[t])", ", rs_lg2=$(total_rs_lg2[t])", ", rhvdc_lg2=$(total_rhvdc_lg2[t])", ", fast_reserve_lg2=$(total_fast_reserve_lg2[t])")
    end

    println(io, "===== TOTAL RESERVES LC2 =====")
    for t in T
        println(io, "t=$t  rg_lc2 =$(total_rg_lc2[t])",", re_lc2=$(total_re_lc2[t])", ", rs_lc2=$(total_rs_lc2[t])", ", rhvdc_lc2=$(total_rhvdc_lc2[t])", ", fast_reserve_lc2=$(total_fast_reserve_lc2[t])")
    end

     println(io, "===== LOSS OF POWER A1 =====")

     for t in T
         println(io, "t=$t  PLG1=$(plg1[t])", ", PLC1=$(plc1[t])")
     end

     println(io, "===== LOSS OF POWER A2 =====")
  
     for t in T
         println(io, "t=$t  PLG2=$(plg2[t])", ", PLC2=$(plc2[t])")
     end
     println(io)

end

println("Results written to frequency_results.txt")



end


