"""
normalizePixels(img)

Normalize pixels using val-min/max-min to span the interval [0,1].
...
# Arguments
- `img`: a grayscale image. 

# Output
- a normalized image with pixel intensity between 0 and 1
...
"""
function normalizePixels(img)

	arr = Float64.(img)
	return Gray.((arr .- minimum(arr)) ./ (maximum(arr) - minimum(arr)))

end