function spectralClustering(A::Array{Float64,2}, nEigen::Int)

	D = Diagonal(sum(A, dims=1)[:])
	L = D-A
	NL = D^(-1/2) * L * D^(-1/2)
	vals, vects = eigen(NL)
	X = vects[:,1:nEigen]
	XX = fill(0.0,size(X))
	
	for i in 1:size(X,1)
		XX[i,:] = X[i,:] ./ sqrt(sum(X[i,:].^2))
	end
	
	return vals, XX
end
