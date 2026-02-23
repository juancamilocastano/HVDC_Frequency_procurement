function printparameters!(m::Model)
    
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

baseKG=m.ext[:parameters][:baseKG]
baseMVA=m.ext[:parameters][:baseMVA]
pmax = m.ext[:parameters][:pmax]
ic = m.ext[:parameters][:ic]
f1 = m.ext[:parameters][:f1]
f2 = m.ext[:parameters][:f2]
Edeployment = m.ext[:parameters][:Edeployment]
G_dt = m.ext[:parameters][:G_dt]




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
rg=JuMP.value.(m.ext[:variables][:rg])*baseMVA
rgvec1= [rg[g,t] for g in G1, t in T]
rgvec2= [rg[g,t] for g in G2, t in T]
rs=JuMP.value.(m.ext[:variables][:rs])*baseMVA
rsvec1= [rs[s,t] for s in S1, t in T]
rsvec2= [rs[s,t] for s in S2, t in T]
re=JuMP.value.(m.ext[:variables][:re])*baseMVA
revec1= [re[e,t] for e in E1, t in T]
revec2= [re[e,t] for e in E2, t in T]
rhvdc=JuMP.value.(m.ext[:variables][:rhvdc])*baseMVA
rhvdcvec1= [rhvdc[cv,t] for cv in CV1, t in T]
rhvdcvec2= [rhvdc[cv,t] for cv in CV2, t in T]
flows_hvdc=JuMP.value.(m.ext[:variables][:brdc_p])*baseMVA
flows_hvdc24= Array(flows_hvdc[("1", "2", "4"),:])
flows_hvdc31= Array(flows_hvdc[("2", "3", "1"),:])
conv_p_ac=JuMP.value.(m.ext[:variables][:conv_p_ac])*baseMVA
zgvec=JuMP.value.(m.ext[:variables][:zg])
δgvec=JuMP.value.(m.ext[:variables][:δg])
δhvdc=JuMP.value.(m.ext[:variables][:δhvdc])


slackinercia1=JuMP.value.(m.ext[:variables][:slackinercia1])*baseMVA
slackinercia2=JuMP.value.(m.ext[:variables][:slackinercia2])*baseMVA
slackreserve1=JuMP.value.(m.ext[:variables][:slackreserve1])*baseMVA
slackreserve2=JuMP.value.(m.ext[:variables][:slackreserve2])*baseMVA

loss_power_g1=
rocof_plg1=Dict()
rocof_plg2=Dict()
rocof_plc1=Dict()
rocof_plc2=Dict()
Inertia_nadir_frequency_1=Dict()
Inertia_nadir_frequency_2=Dict()
procured_inertia_1=Dict()
procured_inertia_2=Dict()
Deltaf_nadir_plg1=Dict()
Deltaf_nadir_plg2=Dict()
Deltaf_nadir_plc1=Dict()
Deltaf_nadir_plc2=Dict()
total_rg_1=Dict()
total_re_1=Dict()
total_rs_1=Dict()
total_rhvdc_1=Dict()
total_fast_reserve_1=Dict()
total_rg_2=Dict()
total_re_2=Dict()
total_rs_2=Dict()
total_rhvdc_2=Dict()
total_fast_reserve_2=Dict()

t_nadir_plg1=Dict()
t_nadir_plg2=Dict()
t_nadir_plc1=Dict()
t_nadir_plc2=Dict()

for t in T 
        Inertia_nadir_frequency_1[t]=sum((zgvec[g,t]-δgvec[g,t])*ic[g]*pmax[g]*baseMVA for g in G1)+slackinercia1[t]
        Inertia_nadir_frequency_2[t]=sum((zgvec[g,t]-δgvec[g,t])*ic[g]*pmax[g]*baseMVA for g in G2)+slackinercia2[t]
        procured_inertia_1[t]=sum(zgvec[g,t]*ic[g]*pmax[g]*baseMVA for g in G1)+slackinercia1[t]
        procured_inertia_2[t]=sum(zgvec[g,t]*ic[g]*pmax[g]*baseMVA for g in G2)+slackinercia2[t]
        t_nadir_plg1[t]=plg1[t]*G_dt["1"]/(sum(rg[g,t]*(1-δgvec[g,t]) for g in G1)+sum(re[e,t] for e in E1)+sum(rs[s,t] for s in S1)+sum(rhvdc[cv,t]*(1-δhvdc[cv,t]) for cv in CV1)+slackreserve1[t])
        t_nadir_plg2[t]=plg2[t]*G_dt["2"]/(sum(rg[g,t]*(1-δgvec[g,t]) for g in G2)+sum(re[e,t] for e in E2)+sum(rs[s,t] for s in S2)+sum(rhvdc[cv,t]*(1-δhvdc[cv,t]) for cv in CV2)+slackreserve2[t])
        t_nadir_plc1[t]=plc1[t]*G_dt["1"]/(sum(rg[g,t]*(1-δgvec[g,t]) for g in G1)+sum(re[e,t] for e in E1)+sum(rs[s,t] for s in S1)+sum(rhvdc[cv,t]*(1-δhvdc[cv,t]) for cv in CV1)+slackreserve1[t])
        t_nadir_plc2[t]=plc2[t]*G_dt["2"]/(sum(rg[g,t]*(1-δgvec[g,t]) for g in G2)+sum(re[e,t] for e in E2)+sum(rs[s,t] for s in S2)+sum(rhvdc[cv,t]*(1-δhvdc[cv,t]) for cv in CV2)+slackreserve2[t])
        total_rg_1[t]=sum(rg[g,t] for g in G1)
        total_re_1[t]=sum(re[e,t] for e in E1)
        total_rs_1[t]=sum(rs[s,t] for s in S1)
        total_rhvdc_1[t]=sum(rhvdc[cv,t] for cv in CV1)
        total_fast_reserve_1[t]=slackreserve1[t]+sum(re[e,t] for e in E1)+sum(rs[s,t] for s in S1)+sum(rhvdc[cv,t] for cv in CV1)
        total_rg_2[t]=sum(rg[g,t] for g in G2)
        total_re_2[t]=sum(re[e,t] for e in E2)
        total_rs_2[t]=sum(rs[s,t] for s in S2)
        total_rhvdc_2[t]=sum(rhvdc[cv,t] for cv in CV2)
        total_fast_reserve_2[t]=slackreserve2[t]+sum(re[e,t] for e in E2)+sum(rs[s,t] for s in S2)+sum(rhvdc[cv,t] for cv in CV2)
end

Inertia_nadir_frequency_1_vec = [Inertia_nadir_frequency_1[t] for t in T]
Inertia_nadir_frequency_2_vec = [Inertia_nadir_frequency_2[t] for t in T]
procured_inertia_1_vec = [procured_inertia_1[t] for t in T]
procured_inertia_2_vec = [procured_inertia_2[t] for t in T]


for t in T
        rocof_plg1[t]= f1*plg1[t]/(2*Inertia_nadir_frequency_1[t])
        rocof_plg2[t]= f2*plg2[t]/(2*Inertia_nadir_frequency_2[t])
        rocof_plc1[t]= f1*plc1[t]/(2*Inertia_nadir_frequency_1[t])
        rocof_plc2[t]= f2*plc2[t]/(2*Inertia_nadir_frequency_2[t]) 
        Deltaf_nadir_plg1[t] =((plg1[t]- sum(re[e, t] for e in E1)- sum(rs[s, t] for s in S1)- sum(rhvdc[cv, t] * (1 - δhvdc[cv, t]) for cv in CV1)-sum(slackreserve1[t]))^2*G_dt["1"]/sum(rg[g, t] * (1 - δgvec[g, t]) for g in G1) + (sum(re[e, t] for e in E1) + sum(rs[s, t] for s in S1) + sum(rhvdc[cv, t] * (1 - δhvdc[cv, t]) for cv in CV1)+ slackreserve1[t]) * Edeployment["1"] ) * f1 / (4 * Inertia_nadir_frequency_1[t])
        Deltaf_nadir_plg2[t] =((plg2[t]- sum(re[e, t] for e in E2)- sum(rs[s, t] for s in S2)- sum(rhvdc[cv, t] * (1 - δhvdc[cv, t]) for cv in CV2)-sum(slackreserve2[t]))^2*G_dt["1"]/sum(rg[g, t] * (1 - δgvec[g, t]) for g in G2) + (sum(re[e, t] for e in E2) + sum(rs[s, t] for s in S2) + sum(rhvdc[cv, t] * (1 - δhvdc[cv, t]) for cv in CV2)+ slackreserve2[t]) * Edeployment["1"] ) * f2 / (4 * Inertia_nadir_frequency_2[t])
        Deltaf_nadir_plc1[t] =((plc1[t]- sum(re[e, t] for e in E1)- sum(rs[s, t] for s in S1)- sum(rhvdc[cv, t] * (1 - δhvdc[cv, t]) for cv in CV1)-sum(slackreserve1[t]))^2*G_dt["1"]/sum(rg[g, t] * (1 - δgvec[g, t]) for g in G1) + (sum(re[e, t] for e in E1) + sum(rs[s, t] for s in S1) + sum(rhvdc[cv, t] * (1 - δhvdc[cv, t]) for cv in CV1)+ slackreserve1[t]) * Edeployment["1"] ) * f1 / (4 * Inertia_nadir_frequency_1[t])
        Deltaf_nadir_plc2[t] =((plc2[t]- sum(re[e, t] for e in E2)- sum(rs[s, t] for s in S2)- sum(rhvdc[cv, t] * (1 - δhvdc[cv, t]) for cv in CV2)-sum(slackreserve2[t]))^2*G_dt["1"]/sum(rg[g, t] * (1 - δgvec[g, t]) for g in G2) + (sum(re[e, t] for e in E2) + sum(rs[s, t] for s in S2) + sum(rhvdc[cv, t] * (1 - δhvdc[cv, t]) for cv in CV2)+ slackreserve2[t]) * Edeployment["1"] ) * f2 / (4 * Inertia_nadir_frequency_2[t])
 
end


# ===============================
# Write results to a TXT file
# ===============================

output_file = "frequency_results.txt"

open(output_file, "w") do io
    println(io, "===== SLACK VARIABLES =====")
    println(io, "slackinercia1:")
    for t in T
        println(io, "t=$t  value=$(slackinercia1[t])")
    end
    println(io)

    #= println(io, "slackinercia2:")
    for t in T
        println(io, "t=$t  value=$(slackinercia2[t])")
    end
    println(io) =#

    println(io, "slackreserve1:")
    for t in T
        println(io, "t=$t  value=$(slackreserve1[t])")
    end
    println(io)

    #= println(io, "slackreserve2:")
    for t in T
        println(io, "t=$t  value=$(slackreserve2[t])")
    end
    println(io) =#

    println(io, "===== ROCOF =====")
    println(io, "rocof_plg1:")
    for t in T
        println(io, "t=$t  value=$(rocof_plg1[t])")
    end
    println(io)

  #=   println(io, "rocof_plg2:")
    for t in T
        println(io, "t=$t  value=$(rocof_plg2[t])")
    end
    println(io) =#

    println(io, "rocof_plc1:")
    for t in T
        println(io, "t=$t  value=$(rocof_plc1[t])")
    end
    println(io)

  #=   println(io, "rocof_plc2:")
    for t in T
        println(io, "t=$t  value=$(rocof_plc2[t])")
    end
    println(io) =#

    println(io, "===== INERTIA =====")
    println(io, "Inertia_nadir_frequency_1:")
    for t in T
        println(io, "t=$t  value=$(Inertia_nadir_frequency_1[t])")
    end
    println(io)

    #= println(io, "Inertia_nadir_frequency_2:")
    for t in T
        println(io, "t=$t  value=$(Inertia_nadir_frequency_2[t])")
    end
    println(io) =#

    println(io, "procured_inertia_1:")
    for t in T
        println(io, "t=$t  value=$(procured_inertia_1[t])")
    end
    println(io)

   #=  println(io, "procured_inertia_2:")
    for t in T
        println(io, "t=$t  value=$(procured_inertia_2[t])")
    end
    println(io) =#

    println(io, "===== NADIR FREQUENCY DEVIATION =====")
    println(io, "Deltaf_nadir_plg1:")
    for t in T
        println(io, "t=$t  value=$(Deltaf_nadir_plg1[t])")
    end
    println(io)

   #=  println(io, "Deltaf_nadir_plg2:")
    for t in T
        println(io, "t=$t  value=$(Deltaf_nadir_plg2[t])")
    end
    println(io) =#

    println(io, "Deltaf_nadir_plc1:")
    for t in T
        println(io, "t=$t  value=$(Deltaf_nadir_plc1[t])")
    end
    println(io)

   #=  println(io, "Deltaf_nadir_plc2:")
    for t in T
        println(io, "t=$t  value=$(Deltaf_nadir_plc2[t])")
    end =#

    println(io, "===== TOTAL RESERVES =====")
    println(io, "total_rg_1:")
    for t in T
        println(io, "t=$t  value=$(total_rg_1[t])")
    end
    println(io)

    println(io, "total_re_1:")
    for t in T
        println(io, "t=$t  value=$(total_re_1[t])")
    end
    println(io)

    println(io, "total_rs_1:")
    for t in T
        println(io, "t=$t  value=$(total_rs_1[t])")
    end
    println(io)

    println(io, "total_rhvdc_1:")
    for t in T
        println(io, "t=$t  value=$(total_rhvdc_1[t])")
    end
    println(io)

    println(io, "total_fast_reserve_1:")
    for t in T
        println(io, "t=$t  value=$(total_fast_reserve_1[t])")
    end
    println(io)
#= 
    println(io, "total_rg_2:")
    for t in T
        println(io, "t=$t  value=$(total_rg_2[t])")
    end
    println(io)

    println(io, "total_re_2:")
    for t in T
        println(io, "t=$t  value=$(total_re_2[t])")
    end
    println(io)

     println(io, "total_rs_2:")
     for t in T
         println(io, "t=$t  value=$(total_rs_2[t])")
     end
     println(io)

     println(io, "total_rhvdc_2:")
     for t in T
         println(io, "t=$t  value=$(total_rhvdc_2[t])")
     end
     println(io)

     println(io, "total_fast_reserve_2:")
     for t in T
         println(io, "t=$t  value=$(total_fast_reserve_2[t])")
     end
 =#
     println(io, "===== LOSS OF POWER =====")
     println(io, "loss_power_g1:")
     for t in T
         println(io, "t=$t  value=$(plg1[t])")
     end
     println(io)

 #=     println(io, "loss_power_g2:")
     for t in T
         println(io, "t=$t  value=$(plg2[t])")
     end
     println(io) =#

end

println("Results written to frequency_results.txt")



end


