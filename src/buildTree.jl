function buildTree(img, capacity)
	
  root = initQuadTree(img, capacity, 1)

  q=Queue{QuadTree}()
  enqueue!(q, root)
  leaves = []

  while ~isempty(q)
    quadTree = dequeue!(q)
  
    if quadTree.leaf == true
      continue

    elseif var(Float64.(
        img[quadTree.boundary.x - 
          quadTree.boundary.width + 1: quadTree.boundary.x + 
          quadTree.boundary.width,
          quadTree.boundary.y - 
          quadTree.boundary.height + 1: quadTree.boundary.y + 
          quadTree.boundary.height])) < capacity
      quadTree.leaf = true
      
      xs = quadTree.boundary.x - quadTree.boundary.width +
         1:quadTree.boundary.x + quadTree.boundary.width
      ys = quadTree.boundary.y - quadTree.boundary.height +
         1:quadTree.boundary.y + quadTree.boundary.height
      pxls = collect(zip(repeat(ys, inner=length(xs)), 
          repeat(xs, outer=length(ys))))
      
      for i in pxls
        push!(quadTree.pixels, Pixel(i[1], i[2]))
      end
        
      push!(leaves, quadTree)
  
    else
      children = branchTree(quadTree)
    
      for child in children
        enqueue!(q, child)
      end
    
      continue
    end
  end

  return leaves
end