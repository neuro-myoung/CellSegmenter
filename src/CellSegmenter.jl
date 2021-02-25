module CellSegmenter

using Images, Distances, LinearAlgebra, Statistics, DataStructures

include("slic.jl")
include("normalizePixels.jl")
include("gaussianKernel.jl")
include("dbscan.jl")
include("spectralClustering.jl")
include("initQuadTree.jl")
include("buildTree.jl")
include("branchTree.jl")

mutable struct Cluster
  l::Float32
  a::Float32
  b::Float32
  y::Int
  x::Int
end

struct Pixel
  x::Int
  y::Int
  Pixel(x,y) = new(x,y)
end

struct Rectangle
  x::Int
  y::Int
  width::Int
  height::Int
  
  Rectangle(x,y,w,h) = new(x,y,w,h)
end

mutable struct QuadTree
  boundary::Rectangle
  capacity::Float64
  branch::Int
  leaf::Bool
  pixels::Array{Pixel}
  
  QuadTree(boundary, capacity, branch) = new(boundary, capacity, 
    branch, false, [])
end


export slic, normalizePixels, gaussianKernel, dbscan, spectralClustering, buildTree, branchTree, initQuadTree

end
