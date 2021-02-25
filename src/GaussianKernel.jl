function gaussianKernel(arr, σₗ=0.5::Float, σₛ=0.5::Float)
	A = fill(0.0, size(arr,1), size(arr,1))

	for i in 1:size(A,1)
		for j in 1:size(A,1)
			if i == j
				A[i,j] = 0
			else
				# Distance in LAB space
				aₗ= exp.(-((arr[i,1] - arr[j,1])^2)/(σₗ^2))
				
				# Distance in pixel space
				aₛ = exp.(-euclidean(arr[i,4:5], arr[j,4:5])/(σₛ^2))
				
				# Combined distance metric
				A[i,j] = aₗ .* aₛ
			
			end				
		end
	end
	
	return A
end