using HDF5
using LCIO
using Glob
using StaticArrays
using LinearAlgebra

function getPrimaryParticle(collection, pdg::Int=22)
    for particle in collection
	if length(getParents(particle)) == 0 && abs(getPDG(particle)) == pdg
	    return particle
        end
    end
    return nothing
end

function getExpectedSeed(primary)
        p = SVector{3, Float64}(getMomentum(primary))
        mag = sqrt(sum(p.^2))
        p ./ mag .* 1.265 # ECAL inner radius
end

function computeCenterOfGravity(collection, expected)
    cellsForParticle = Vector{Vector{Float64}}()
    decode = CellIDDecoder(collection)
    for (cell_idx, hit) in enumerate(collection)
        layer = decode(hit)["layer"] 
        e = getEnergy(hit)
        if layer > 20
            e *= 2
        end
        pos = SVector{3, Float64}(getPosition(hit))
        angle = dot(pos, expected) / sqrt(dot(pos, pos)) / sqrt(dot(expected, expected))
        if angle < 0
            continue
        end
        push!(cellsForParticle, [e, pos[1], pos[2], pos[3]])
    end
    eSum = 0.0
    cog = [0, 0, 0]
    for cell in cellsForParticle
        cog += cell[1] * [cell[2], cell[3], cell[4]]
        eSum += cell[1]
    end
    eSum, cog / eSum
end

# read the files for calibration
h5open("SiD_CaloCalibTraining_allElectrons_2calib.h5", "w") do file
for (file_idx, fileName) in enumerate(ARGS)
    LCIO.open(fileName) do reader
        cellsForParticle = zeros(5, length(reader))
        for (evt_idx, event) in enumerate(reader)
            # sum up the uncalibrated ECalHits
            # this needs to be sorted by layer, so we need a decoder
            eCalBarrelHits = getCollection(event, "ECalBarrelHits")
    	    primary = getPrimaryParticle(getCollection(event, "MCParticle"), 11)
            expected = getExpectedSeed(primary)
            trueE = getEnergy(primary)
            # nHits = length(EcalBarrelHits)
            # cellsForParticle = zeros(5, nHits)
            # for (cell_idx, hit) in enumerate(EcalBarrelHits)
            #     pos = SVector{3, Float64}(getPosition(hit))
            #     angle = dot(pos, expected) / sqrt(dot(pos, pos)) / sqrt(dot(expected, expected))
            #     if angle < 0
            #         continue
            #     end
            #     # calibrate the hits in the later layers with a higher number,
            #     # because they are behind thicker tungsten slabs
            #     e = getEnergy(hit)
            #     # rawHit = getRawHit(hit)
        	# 	#t = getTime(hit)
            #     #ts = 0#getTimeStamp(rawHit)
            #     #adc = 0#getAmplitude(rawHit)
            #     cellsForParticle[:, cell_idx] = [e, pos[1], pos[2], pos[3], layer]
            #     #push!(cellsForParticle, [e, pos[1], pos[2], pos[3], layer])
            # end
            (e, pos) = computeCenterOfGravity(eCalBarrelHits, expected)
            cellsForParticle[:, evt_idx] = [e, pos[1], pos[2], pos[3], trueE]
        end
        write(file, "file_$(file_idx)", cellsForParticle)
    end
end
end
