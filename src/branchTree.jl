function branchTree(quadTree)
  x = quadTree.boundary.x
  y = quadTree.boundary.y
  width = quadTree.boundary.width/2
  height = quadTree.boundary.height/2
  branch = quadTree.branch + 1

  trBounds = Rectangle(x + width, y - height, width, height)
  topRight = QuadTree(trBounds, quadTree.capacity, branch)

  brBounds = Rectangle(x + width, y + height, width, height)
  bottomRight = QuadTree(brBounds, quadTree.capacity, branch)

  blBounds = Rectangle(x - width, y + height, width, height)
  bottomLeft = QuadTree(blBounds, quadTree.capacity, branch)

  tlBounds = Rectangle(x - width, y - height, width, height)
  topLeft = QuadTree(tlBounds, quadTree.capacity, branch)

  return [topRight, bottomRight, bottomLeft, topLeft]
end