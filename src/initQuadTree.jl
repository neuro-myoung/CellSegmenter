function initQuadTree(img, var, branch)
  qTree = QuadTree(Rectangle(Int(size(img)[1]/2),
    Int(size(img)[1]/2),
    Int(size(img)[1]/2),
    Int(size(img)[2]/2)), var, branch)
  return qTree
end