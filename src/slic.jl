function slic(img, K::Int, M::Int, iters=20::Int)
	
	# Initialize variables
	imgLAB = Lab.(img)
	height, width = size(img)
	S = round(Int, (sqrt((height * width) / K)))
	clusters = Cluster[]
	labels = fill(-1, height, width)
	distance = fill(Inf, height, width)
	nPixels = Integer[]
	
	#################### Define methods ###########################
	function getGradient(y, x)
		x+1 > width && (x -= 2)
		y+1 > height && (y -= 2)
		
		return imgLAB[y+1, x+1].l - imgLAB[y, x].l + 
               imgLAB[y+1, x+1].a - imgLAB[y, x].a + 
               imgLAB[y+1, x+1].b - imgLAB[y, x].b
    end
	
	function clusterPixels()
        for i = 1:length(clusters)
            for x = (clusters[i].x - 2 * S):(clusters[i].x + 2 * S)
                (x <= 0 || x > width) && continue

				for y = (clusters[i].y - 2 * S):(clusters[i].y + 2 * S)
                    (y <= 0 || y > height) && continue 

					# Distance in LAB space
                    Dc = sqrt((imgLAB[y, x].l - clusters[i].l)^2 + 
                              (imgLAB[y, x].a - clusters[i].a)^2 +
                              (imgLAB[y, x].b - clusters[i].b)^2)
					
					# Distance in pixel space
                    Ds = sqrt((y - clusters[i].y)^2 +
                              (x - clusters[i].x)^2)
					
					# Scaled distance metric
                    D = sqrt((Dc / M)^2 + (Ds / S)^2)

                    if D < distance[y, x]
                        distance[y, x] = D
                        labels[y, x] = i
                    end
                end
            end
        end
    end
	
	function updateClusters()
        # Reset clusters
        for i = 1:length(clusters)
           clusters[i].y = clusters[i].x = nPixels[i] = 0 
        end
		
		# Recalculate clusters
        for x in 1:width
            for y in 1:height
                labelIdx = labels[y, x]
                labelIdx == -1 && continue

                clusters[labelIdx].y += y
                clusters[labelIdx].x += x
                nPixels[labelIdx] += 1
            end
        end
		
		# Reassign clusters
        for i = 1:length(clusters)
            newY = div(clusters[i].y, nPixels[i])
            newX = div(clusters[i].x, nPixels[i])
            clusters[i].l = imgLAB[newY, newX].l
            clusters[i].a = imgLAB[newY, newX].a
            clusters[i].b = imgLAB[newY, newX].b
            clusters[i].y = newY
            clusters[i].x = newX
        end
    end
	
	function iterateClusters(cluster, i)
		if i == 1
			return cluster.l
		elseif i == 2
			return cluster.a
		elseif i == 3
			return cluster.b
		elseif i == 4
			return cluster.x
		elseif i == 5
			return cluster.y
		end
	end
	###################################################################
	# Initialize cluster
	for x = div(S, 2):S:width
        for y = div(S, 2):S:height
            push!(clusters, Cluster(imgLAB[y, x].l, imgLAB[y, x].a, imgLAB[y, x].b,
                                   y, x))
            push!(nPixels, 0)
        end
    end
	
	# Check gradient against surrounding pixels and reassign if lower
	for i = 1:length(clusters)
        grad = getGradient(clusters[i].y, clusters[i].x)
		
        for dy = -1:1
            for dx = -1:1
                _y = clusters[i].y + dy
                _x = clusters[i].x + dx
                newGrad = getGradient(_y, _x)
                if newGrad < grad
                    clusters[i].l = imgLAB[_y, _x].l
                    clusters[i].a = imgLAB[_y, _x].a
                    clusters[i].b = imgLAB[_y, _x].b
                    clusters[i].y = _y
                    clusters[i].x = _x
                    grad = newGrad
                end
            end
        end
    end
	
	# Run SLIC algorithm
	@time for i = 1:iters
        println("Running SLIC iteration $(i) ...")
        clusterPixels()
        updateClusters()
    end

	return clusters, labels
end
