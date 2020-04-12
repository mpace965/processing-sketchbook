float GOLDEN = PI * (3 - sqrt(5));

enum Direction {
 CLOCKWISE,
 COUNTER_CLOCKWISE
}

abstract class Spiral {
 protected int nElements;
 protected float speed;
 protected float theta;
 protected float radius;
 protected Direction direction;
 
 public Spiral(int nElements, float speed, Direction direction) {
  this.nElements = nElements;
  this.speed = speed;
  this.direction = direction;
 }
 
 public void draw() {
  int directionModifier = this.direction.equals(Direction.COUNTER_CLOCKWISE) ? -1 : 1;
  
  for (int n = 0; n < this.nElements; n++) {
    this.theta = GOLDEN * n + directionModifier * this.speed * frameCount;
    this.radius = n;
    drawElement();
  }
 }
 
 public void setDirection(Direction direction) {
  this.direction = direction; 
 }
 
 public void setSpeed(float speed) {
   this.speed = speed;
 }
 
 protected abstract void drawElement();
}
