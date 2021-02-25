module CellSegmenter

using Images, Distances

include("slic.jl")
include("normalize.jl")
include("gaussianKernel.jl")
include("dbscan.jl")

mutable struct Cluster
  l::Float32
  a::Float32
  b::Float32
  y::Int
  x::Int
end

export slic, normalize, gaussianKernel, dbscan

end
