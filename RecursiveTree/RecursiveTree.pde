
float treeAngle = -HALF_PI;
float size = 100;
TreeNode tree;
PShape first;

float zoomFactor;
TreeNode currentNode, targetNode;
float currentScale, currentX, currentY, currentRotation;
float targetScale, targetX, targetY, targetRotation;
int frameCountSnapshot, targetFrameCount;

void setup() {
  size(750, 750);
  frameRate(60);
  
  first = equilateralTriangle(size);
  
  tree = makeTree(first, 10);
  
  zoomFactor = 0.01;
  
  currentNode = null;
  currentScale = 0.5; 
  currentX = 0;
  currentY = 0;
  currentRotation = 0;

  targetNode = tree;
  targetScale = 1;
  targetX = 0;
  targetY = 0;
  targetRotation = 0;
}

void draw() {
  background(#aaaaaa);
  translate(width / 2, height / 2);
  
  stepCamera();
  
  rotate(-treeAngle);
  scale(currentScale);
  
  tree.draw();
  scale(10);
  stroke(#ffffff);
  point(0, 0);
}

void stepCamera() {
  if (currentScale >= targetScale) {
    if (currentNode == null) currentNode = targetNode;
    
    TreeNode newTarget = currentNode.randomChild();
    currentNode = targetNode;
    targetNode = newTarget;
    
    println(currentX, currentY, currentRotation, targetX, targetY, targetRotation);
    
    targetScale *= 2;
    
    println(currentX, currentY, currentRotation, targetX, targetY, targetRotation);
    
    if (newTarget.equals(currentNode.left)) {
      if (currentNode.equals(tree)) {
        targetX = width;
        targetY = 0;
        targetRotation = treeAngle;
      } else {
        targetX = width / 2;
        targetY = 0;
        targetRotation = 2 * treeAngle;
        //noLoop();
      }
    } else {
      if (currentNode.equals(tree)) {
        targetX = -width;
        targetY = 0;
        targetRotation = -treeAngle;
      } else {
        targetX = -width / 2;
        targetY = 0;
        targetRotation = -2 * treeAngle;
        //noLoop();
      }
    }
    
    frameCountSnapshot = frameCount;
    targetFrameCount = frameCountSnapshot * 2;
    
    println(currentX, currentY, currentRotation, targetX, targetY, targetRotation);
  }
  
  currentScale = zoomFactor * frameCount;
  rotate(currentRotation);
  translate(currentX, currentY);
  
  if (currentNode == null) return;
  
  rotate(map(frameCount, frameCountSnapshot, targetFrameCount, currentRotation, targetRotation));
  translate(map(frameCount, frameCountSnapshot, targetFrameCount, currentX, targetX), map(frameCount, frameCountSnapshot, targetFrameCount, currentY, targetY));
}

TreeNode makeTree(PShape triangle, int level) {
  return makeTree(triangle, level, 0.5);
}

TreeNode makeTree(PShape triangle, int level, float scale) {  
  if (level == 0) {
    return new TreeNode(triangle, null, null);
  }
  
  int nextLevel = level - 1;
  
  PShape leftTriangle = equilateralTriangle(size);
  leftTriangle.scale(scale);
  PShape rightTriangle = equilateralTriangle(size);
  rightTriangle.scale(scale);
  
  TreeNode left = makeTree(leftTriangle, nextLevel, scale * 0.5);
  TreeNode right = makeTree(rightTriangle, nextLevel, scale * 0.5);
  
  return new TreeNode(triangle, left, right);
}
