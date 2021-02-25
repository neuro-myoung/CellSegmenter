function dbscan(arr::Array{Float64,2} , ϵ::Number, minPoints::Int)
	
	nPoints = size(arr,1)
	dists = fill(0.0, nPoints, nPoints)
	connectedPaths = fill(0, nPoints, nPoints)
	
	seeds = Int[]
	counts = Int[]
	clusters = zeros(Int, nPoints)
	visited = zeros(Bool, nPoints)

	# Make superpixel distance matrix and connectivity matrix
	for i in  1:nPoints
		for j in 1:nPoints
			dists[i,j] = euclidean(arr[i,:],arr[j,:])
		end
	end
	
	reachable = findall(x->x <= ϵ, dists)
	connectedPaths[reachable] .= 1
	
	function regionQuery(idx)
		neighbors = findall(x -> x == 1, connectedPaths[:,idx])
		return neighbors
	end
	
	k = 0
	
	for pt in 1:nPoints
		if clusters[pt] == 0 && !visited[pt]
			visited[pt] == true
			neighbors = regionQuery(pt)
			if length(neighbors) >= minPoints
				k += 1
				clusters[pt] = k
				cnt = 1
				while !isempty(neighbors)
					q = popfirst!(neighbors)
					if !visited[q]
						visited[q] = true
						qNeighbors = regionQuery(q)
						for x in qNeighbors
							if clusters[x] == 0
								push!(neighbors, x)
							end
						end
					end
					if clusters[q] == 0
						clusters[q] = k
						cnt += 1
					end
				end
				push!(seeds, pt)
				push!(counts, cnt)
						
			end
		end
	end
	
	return clusters
end