
class TreeNode {
  public PShape shape;
  public TreeNode left, right;
  
  TreeNode(PShape shape, TreeNode left, TreeNode right) {
    this.shape = shape;
    this.left = left;
    this.right = right;
  }
  
  private void draw() {
    draw(1);
  }
  
  private void draw(int depth) {
    push();
    
    rotate(treeAngle);
    
    shape(this.shape, 0, 0);
    
    int translateFactor = 2 * depth;
    translate(width / translateFactor, 0);
    
    if (this.left != null) this.left.draw(depth + 1);
    
    translate(-width / translateFactor, 0);
    
    rotate(-2 * treeAngle);
    
    translate(width / translateFactor, 0);
    
    if (this.right != null) this.right.draw(depth + 1);
    
    pop();
  }
  
  TreeNode randomChild() {
    return round(random(1)) == 1 ? this.right : this.left;
  }
}
