float windowSize = 750;
float frameRate = 60;

float halfSize = windowSize / 2;
float quarterSize = windowSize / 4;

color[] rainbow = { #E64A39, #E97439, #EDD157, #65ED99, #5F8BE9, #6F1BC6 };
IntList rainbow11 = new IntList();

float[] scales = { 0.8, 0.6, 0.4, 0.3, 0.27, 0.25, 0.23, 0.2, 0.18, 0.16, 0.14, 0.12 };

int step = 1;
int totalSteps = scales.length - 1;
float stepSeconds = 2;
float fundamental = 97.997;
int stepMod = floor(frameRate * stepSeconds);

void setup() {
  size(750, 750);
  frameRate(frameRate);
  
  for (int i = 1; i <= 5; i++) {
    rainbow11.append(rainbow[i - 1]);
    rainbow11.append(lerpColor(rainbow[i - 1], rainbow[i], 0.5));
  }
  
  rainbow11.append(rainbow[5]);
  rainbow11.append(lerpColor(rainbow[4], rainbow[5], 1.5));
}

void draw() {
  background(0);
  translate(halfSize, halfSize);
  
  stroke(255);
  noFill();
  strokeWeight(30);
  
  if (step <= totalSteps && frameCount != 1 && frameCount % stepMod == 1) {
    step++;
  }
  
  boolean playing = step <= totalSteps;
  float stepProgressPct = map(((frameCount - 1) % stepMod), 0, stepMod - 1, 0, 1);
  
  float stepSinePct = playing && stepProgressPct < 0.1
    ? pow(sin(100 / 10 * HALF_PI * stepProgressPct), 2)
    : 1;
  //println(frameCount, ((frameCount - 1) % 120), stepSinePct, scales[step - 1], scales[step], lerp(scales[step - 1], scales[step], stepSinePct));
  scale(playing ? lerp(scales[step - 1], scales[step], stepSinePct) : scales[totalSteps]);
  
  for (int n = 0; n < step - 1; n++) {  
    float radiusN = 200 * (n + 1) + 50 * n;
    float amplitudeN = 100;
    float hertzN = (n + 1) * fundamental;
    //float subdivisionsN = 16 + 5 * n;
    float subdivisionsN = 16;
    int segmentDensityN = 10 + floor(1.25 * n);
    drawSineCircle(rainbow11.get(n), rainbow11.get(n + 1), 255, 0, 0, radiusN, amplitudeN, hertzN, subdivisionsN, segmentDensityN);
  }
  
  if (playing) {
      color baseColor = playing ? rainbow11.get(step - 1) : rainbow11.get(totalSteps - 1);
      color topColor = playing ? rainbow11.get(step) : rainbow11.get(totalSteps);
      float opacity = 255 * stepSinePct;
      float radius = 200 * step + 50 * (step - 1);
      float amplitude = 100;
      float hertz = step * fundamental;
      //float subdivisions = 16 + 5 * (step - 1);
      float subdivisions = 16;
      int segmentDensity = 10 + floor(1.25 * (step - 1));
      
      drawSineCircle(baseColor, topColor, opacity, 0, 0, radius, amplitude, hertz, subdivisions, segmentDensity);
  }
  
  //if (frameCount <= (totalSteps * stepMod)) {
  //if (frameCount <= 1500) {
  //  saveFrame("./frames/#####.png");
  //}
  
  //noLoop();
}

void drawSineCircle(color baseColor, color topColor, float opacity, float x, float y, float r, float amplitude, float hertz, float subdivisions, int segmentDensity) {
  push();
  
  float sineSpeed = (360 / frameRate) * hertz;
  float increment = TAU / subdivisions;
  float radianOffset = - radians(sineSpeed * (frameCount - 1));
  
  translate(x, y);
  
  for (float t = 0; t < TAU; t += increment) {
    //stroke(255, 0, 0);
    //strokeWeight(8);
    //point(r * cos(t), r * sin(t));

    for (int n = 0; n < segmentDensity; n += 1) {
      float outerCircleTheta = t + map(n, 0, segmentDensity, 0, increment);
      float sineWaveRadius = r + amplitude * sin(map(n, 0, segmentDensity, 0, TAU) + radianOffset);
      stroke(lerpColor(baseColor, topColor, map(sineWaveRadius, r - amplitude, r + amplitude, 0, 1)), opacity);
      point(sineWaveRadius * cos(outerCircleTheta), sineWaveRadius * sin(outerCircleTheta));
    }
  }
  
  //stroke(0);
  //line(0, 0, width / 2, 0);
  pop();
}
