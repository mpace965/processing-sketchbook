
boolean paused = false;
int step = 0;
int resume;

void setup() {
  size(750, 750);
  frameRate(60);
}

void draw() {
  sineCircleUnfold();
}

void sineCircleUnfold() {
  float sineSpeed = 5;
  float amplitude = 30;
  float r = 100;
  float size = 750;
  float halfSize = size / 2;

  background(0);  
  text(step, 0, 10);
  
  translate(halfSize, halfSize);
  
  scale(2.5);
  
  stroke(255);
  strokeWeight(10);
  
  for (float t = 0; t < TWO_PI; t += 0.04) {
    float sineWaveRadius = r + amplitude * sin(sineSpeed * radians(t * step));
    stroke(lerpColor(#ffffff, #ff0000, map(t, 0, TWO_PI, 0, 1)));
    point(sineWaveRadius * cos(t), sineWaveRadius * sin(t));
  }
  
  if (!paused) step++;
}

void keyPressed() {
  if (key == ' ') {
    paused = !paused;
  } else if (key == CODED) {
    if (keyCode == LEFT && paused) step--;
    if (keyCode == RIGHT && paused) step++;
  }
}