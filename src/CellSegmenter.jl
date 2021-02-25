module CellSegmenter

using Images

include("slic.jl")

mutable struct Cluster
  l::Float32
  a::Float32
  b::Float32
  y::Int
  x::Int
end

export slic

end
