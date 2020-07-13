using LCIO
using StatsPlots

kaonTimes = Float64[]
pionTimes = Float64[]
LCIO.open("ssReco_1000.slcio") do reader
	for (iEvent, event) in enumerate(reader)
    	coll = getCollection(event, "ECalBarrelHits")
		decode = CellIDDecoder(coll)
        for hit in coll
			layer = decode(hit)["layer"]
			if layer != 0
				continue
			end
			for i=1:LCIO.getNMCContributions(hit)
				pdgID = abs(getPDG(LCIO.getParticleCont(hit, i)))
				if pdgID == 321
					push!(kaonTimes, LCIO.getTimeCont(hit, i))
				elseif pdgID == 211
					push!(pionTimes, LCIO.getTimeCont(hit, i))
				end
			end
		end
		if iEvent % 500 == 0
			println("processed ", iEvent, " events")
		end
	end
end

plot(kaonTimes, seriestype=:stephist, label="K", bins=0:0.1:10, normalize=true)
plot!(pionTimes, seriestype=:stephist, label="pi", bins=0:0.1:10, normalize=true)
savefig("layer0times.png")
