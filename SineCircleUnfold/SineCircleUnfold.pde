
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
  color color1 = #ff0000;
  color color2 = #00ffff;

  background(0);  
  //text(step, 0, 10);
  
  translate(halfSize, halfSize);
  
  scale(2.5);
  
  stroke(255);
  strokeWeight(10);
  
  for (float t = 0; t < TAU; t += 0.1) {
    float sineWaveRadius = r + amplitude * sin(t + radians(step));
    if (t < PI) {
      stroke(lerpColor(color1, color2, map(t, 0, PI, 0, 1)));
    } else {
      stroke(lerpColor(color2, color1, map(t, PI, TAU, 0, 1)));
    }
    
    point(sineWaveRadius * cos(t), sineWaveRadius * sin(t));
  }
  
  //if (step <= 900) {
  //  saveFrame("./frames/#####.png");
  //}
  
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
