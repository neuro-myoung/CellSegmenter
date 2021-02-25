function normalize(arr)
	return (arr .- minimum(arr)) ./ (maximum(arr) - minimum(arr))
end