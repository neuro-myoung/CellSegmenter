function GaussianKernel(arr, σₗ=0.5::Float, σₛ=0.5::Float)
		A = fill(0.0, size(arr,1), size(arr,1))

		for i in 1:size(A,1)
			for j in 1:size(A,1)
				if i == j
					A[i,j] = 0
				else
					# Distance in LAB space
                    #Aₗ= exp.((-euclidean(arr[i,1:3], arr[j,1:3]))/(2σₗ^2))
					Aₗ= exp.(-euclidean(arr[i,1], arr[j,1])/(2σₗ^2))
					
					# Distance in pixel space
          Aₛ = exp.((-euclidean(arr[i,4:5], arr[j,4:5]))/(2σₛ^2))
					
					# Comgined distance metric
					A[i,j] = Aₗ .* Aₛ

				end				
			end
		end
		
		return A
	end