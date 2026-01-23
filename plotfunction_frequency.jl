function plotfunction_frequency!(m::Model)
    
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
conv_p_dc=JuMP.value.(m.ext[:variables][:conv_p_dc])*baseMVA
δhvdc=JuMP.value.(m.ext[:variables][:δhvdc])




#sum(pgvec[:,1])+sum(psdvec[:,1])-sum(pscvec[:,1])+52.12-sum(pevec_compressor[:,1])-205-sum(pevec[:,1])



fig1 = Figure()
ax = fig1[1, 1] = Axis(fig1,
    title = "Storage and Hydrogen flows Area 1",
    xlabel = "Time (hours)",
    ylabel = "Hydrogen Flow (Kg/h) and Storage (Kg)"
)

lines!(ax, hfginyectvec[1, :], label = "Hydrogen injected")
lines!(ax, hssvec[1, :], label = "Hydrogen stored")
lines!(ax, hfevec[1, :], label = "Hydrogen Electrolyzer")
lines!(ax, hfgconsumvec[1, :], label = "Hydrogen consumed")

# Legend in separate panel
fig1[1, 2] = Legend(fig1, ax, "Hydrogen Flows", framevisible = false)

fig1



fig2 = Figure()
ax2 = fig2[1, 1] = Axis(fig2,
    title = "Storage and Hydrogen flows Area 2",
    xlabel = "Time (hours)",
    ylabel = "Hydrogen Flow (Kg/h) and Storage (Kg)"
)

lines!(ax2, hfginyectvec[2, :], label = "Hydrogen injected")
lines!(ax2, hssvec[2, :], label = "Hydrogen stored")
lines!(ax2, hfevec[2, :], label = "Hydrogen Electrolyzer")
lines!(ax2, hfgconsumvec[2, :], label = "Hydrogen consumed")

fig2[1, 2] = Legend(fig2, ax2, "Hydrogen Flows", framevisible = false)  
fig2

fig3 = Figure()
ax3 = fig3[1, 1] = Axis(fig3,
    title = "Energy and power flows of the storage Area 1",
    xlabel = "Time (hours)",
    ylabel = "Power (MW) and Storage (Mwh)"
)
lines!(ax3, pscvec[1, :], label = "charging power")
lines!(ax3, psdvec[1, :], label = "discharging power")
lines!(ax3, esvec[1, :], label = "Energy stored")
fig3[1, 2] = Legend(fig3, ax3, "Storage Power and Energy", framevisible = false)  
fig3

fig4 = Figure()
ax4 = fig4[1, 1] = Axis(fig4,
    title = "Energy and power flows of the storage Area 2",
    xlabel = "Time (hours)",
    ylabel = "Power (MW) and Storage (Mwh)"
)
lines!(ax4, pscvec[2, :], label = "charging power")
lines!(ax4, psdvec[2, :], label = "discharging power")
lines!(ax4, esvec[2, :], label = "Energy stored")   
fig4[1, 2] = Legend(fig4, ax4, "Storage Power and Energy", framevisible = false)
fig4

fig5 = Figure()
ax5 = fig5[1, 1] = Axis(fig5,
    title = "Generation by unit Area 1",
    xlabel = "Time (hours)",
    ylabel = "Generation (MW)"
)
lines!(ax5, pg1[1, :], label = "Generator 1")
lines!(ax5, pg1[2, :], label = "Generator 2")
lines!(ax5, pg1[3, :], label = "Generator 3")
fig5[1, 2] = Legend(fig5, ax5, "Generation Area 1", framevisible = false)
fig5

fig6 = Figure()
ax6 = fig6[1, 1] = Axis(fig6,
    title = "Generation by unit Area 2",
    xlabel = "Time (hours)",
    ylabel = "Generation (MW)"
)   
lines!(ax6, pg2[1, :], label = "Generator 4")
lines!(ax6, pg2[2, :], label = "Generator 5")
lines!(ax6, pg2[3, :], label = "Generator 6")
fig6[1, 2] = Legend(fig6, ax6, "Generation Area 2", framevisible = false)
fig6

fig7 = Figure()
ax7 = fig7[1, 1] = Axis(fig7,
    title = "Loss of power area 1",
    xlabel = "Time (hours)",
    ylabel = "Power (MW)"
)

lines!(ax7, plg1vec, label = "Loss generator 1")
lines!(ax7, plc1vec, label = "Loss converter 1")
fig7[1, 2] = Legend(fig7, ax7, "Power loss Area 1", framevisible = false)
fig7

fig8 = Figure()
ax8 = fig8[1, 1] = Axis(fig8,
    title = "Loss of power area 2",
    xlabel = "Time (hours)",
    ylabel = "Power (MW)"
)
lines!(ax8, plg2vec, label = "Loss generator 2")    
lines!(ax8, plc2vec, label = "Loss converter 2")
fig8[1, 2] = Legend(fig8, ax8, "Power loss Area 2", framevisible = false)
fig8

fig9 = Figure()
ax9 = fig9[1, 1] = Axis(fig9,
     title  = "Reserve allocation Area 1",
     xlabel = "Time (hours)",
     ylabel = "Reserve Power (MW)"
)
rg9    = vec(sum(rgvec1,    dims=1))
re9    = vec(sum(revec1,    dims=1))
rhvdc9 = vec(sum(rhvdcvec1, dims=1))
rs9    = vec(sum(rsvec1,    dims=1))
lines!(ax9, rg9, label = "Reserve thermal generators Area 1")
lines!(ax9, re9, label = "Reserve electrolyzers Area 1")
lines!(ax9, rhvdc9, label = "Reserve HVDC Area 1")
lines!(ax9, rs9, label = "Reserve storage Area 1")
fig9[1, 2] = Legend(fig9, ax9, "Reserve Area 1", framevisible = false)
fig9

fig10 = Figure()
ax10 = fig10[1, 1] = Axis(fig10,
     title  = "Reserve allocation Area 2",
     xlabel = "Time (hours)",
     ylabel = "Reserve Power (MW)"
)
rg10    = vec(sum(rgvec2,    dims=1))
re10    = vec(sum(revec2,    dims=1))   
rhvdc10 = vec(sum(rhvdcvec2, dims=1))
rs10    = vec(sum(rsvec2,    dims=1))
lines!(ax10, rg10, label = "Reserve thermal generators Area 2")
lines!(ax10, re10, label = "Reserve electrolyzers Area 2")
lines!(ax10, rhvdc10, label = "Reserve HVDC Area 2")
lines!(ax10, rs10, label = "Reserve storage Area 2")
fig10[1, 2] = Legend(fig10, ax10, "Reserve Area 2", framevisible = false)
fig10

# fig9 = Figure()
# ax9 = Axis(fig9[1, 1];
#     title  = "Reserve allocation Area 1",
#     xlabel = "Time (hours)",
#     ylabel = "Reserve Power (MW)"
# )
# ax9.xticklabelsize = 8
# ax9.xticklabelrotation = π/4
# rg9    = vec(sum(rgvec1,    dims=1))
# re9    = vec(sum(revec1,    dims=1))
# rhvdc9 = vec(sum(rhvdcvec1, dims=1))
# rs9    = vec(sum(rsvec1,    dims=1))
# T = length(rg9)
# M = hcat(re9, rg9, rhvdc9, rs9)
# positions = repeat(1:T, inner=4)
# heights   = vec(permutedims(M))
# groups    = repeat(1:4, T)
# barplot!(
#     ax9,
#     positions,
#     heights;
#     dodge = groups,
#     color = groups
# )
# ax9.xticks = (1:T, string.(0:T-1))
# labels = [
#     "Reserve thermal generators Area 1",
#     "Reserve electrolyzers Area 1",
#     "Reserve HVDC Area 1",
#     "Reserve storage Area 1"
# ]
# colors = Makie.wong_colors()[1:4]
# elements = [PolyElement(polycolor = colors[i]) for i in 1:4]
# Legend(
#     fig9[1, 2],
#     elements,
#     labels,
#     "Reserve Area 1";
#     framevisible = false
# )
# fig9

# fig10 = Figure()
# ax10 = Axis(fig10[1, 1];
#     title  = "Reserve allocation Area 2",
#     xlabel = "Time (hours)",
#     ylabel = "Reserve Power (MW)"
# )
# ax10.xticklabelsize = 8
# ax10.xticklabelrotation = π/4
# rg10    = vec(sum(rgvec2,    dims=1))
# re10    = vec(sum(revec2,    dims=1))
# rhvdc10 = vec(sum(rhvdcvec2, dims=1))
# rs10    = vec(sum(rsvec2,    dims=1))
# T = length(rg10)
# M = hcat(re10, rg10, rhvdc10, rs10)
# positions = repeat(1:T, inner=4)
# heights   = vec(permutedims(M))
# groups    = repeat(1:4, T)
# barplot!(
#     ax10,
#     positions,
#     heights;
#     dodge = groups,
#     color = groups
# )  
# ax10.xticks = (1:T, string.(0:T-1))
# labels = [
#     "Reserve thermal generators Area 2",
#     "Reserve electrolyzers Area 2",
#     "Reserve HVDC Area 2",
#     "Reserve storage Area 2"
# ] 
# colors = Makie.wong_colors()[1:4]
# elements = [PolyElement(polycolor = colors[i]) for i in 1:4]
# Legend(
#     fig10[1, 2],
#     elements,
#     labels,
#     "Reserve Area 2";
#     framevisible = false
# )       
# fig10  

fig11 = Figure()
ax11 = fig11[1, 1] = Axis(fig11,
    title = "HVDC power flows",
    xlabel = "Time (hours)",
    ylabel = "Generation (MW)"
)   
lines!(ax11, flows_hvdc24, label = "Flow HVDC 2-4")
lines!(ax11, flows_hvdc31, label = "Flow HVDC 3-1")
fig11[1, 2] = Legend(fig11, ax11, "HVDC flows", framevisible = false)
fig11


save("hydrogen_storage1.png", fig1)
save("hydrogen_storage_2.png", fig2)
save("storage_power_energy_1.png", fig3)
save("storage_power_energy_2.png", fig4)
save("generation_area1.png", fig5)
save("generation_area2.png", fig6)
save("power_loss_area1.png", fig7)
save("power_loss_area2.png", fig8)
save("reserve_area1.png", fig9)
save("reserve_area2.png", fig10)
save("hvdc_flows.png", fig11)
end


