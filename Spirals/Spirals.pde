color bg = #dddddd;
color black = #000000;
color white = #ffffff;
color primary = #0000ff;
color secondary = #ff0000;

Direction direction;
Spiral spiral;
float speed, sineSpeed, largeSpeedDelta, smallSpeedDelta;
Float pause, sineSpeedPause;
float zoom, zoomDomain;

void setup() {
  size(750, 750);
  frameRate(60);

  direction = Direction.CLOCKWISE;
  speed = 0.917;
  sineSpeed = 6;
  pause = null;
  largeSpeedDelta = 0.05;
  smallSpeedDelta = 0.001;
  zoom = 0.818;
  zoomDomain = 1;

  CircleSpiral c = new CircleSpiral(375, speed);

  ScalableCircleSpiral sc = new ScalableCircleSpiral(375, speed);
  sc.setSizeRange(0, 50);

  ScalableCircleSpiral sc2 = new ScalableCircleSpiral(1000, speed);
  sc2.setSizeRange(0, 50);

  // Direction: CLOCKWISE Speed: 0.59 Scale: 0.36787945
  SineScalableCircleSpiral ssc = new SineScalableCircleSpiral(1000, speed, 15, 60);
  ssc.setSineSpeed(3);

  RadialGrayscaleCircleSpiral rgc = new RadialGrayscaleCircleSpiral(700, speed);
  rgc.setSizeRange(5, 50);
  rgc.setColorRange(220, 0);

  RadialGrayscaleCircleSpiral rgc2 = new RadialGrayscaleCircleSpiral(550, speed);
  rgc2.setSizeRange(30, 100);
  rgc2.setColorRange(220, 0);

  RadialColorscaleCircleSpiral rcc = new RadialColorscaleCircleSpiral(550, speed);
  rcc.setSizeRange(30, 12);
  rcc.setRedColorRange(255, 255);
  rcc.setGreenColorRange(255, 127);

  // TODO export this
  // Direction: CLOCKWISE Speed: 0.92499983 Scale: 0.8187308
  SineColorscaleCircleSpiral sccs = new SineColorscaleCircleSpiral(700, speed, 21, 55);
  sccs.setRedColorRange(255, 255);
  sccs.setGreenColorRange(255, 127);
  sccs.setStrokeWeight(2);

  spiral = sccs;
}

void draw() {
  background(primary);
  translate(width / 2, height / 2);

  scale(zoom);

  spiral.setDirection(direction);
  spiral.setSpeed(speed);
  if (spiral instanceof SineScalableCircleSpiral) {
    ((SineScalableCircleSpiral) spiral).setSineSpeed(sineSpeed);
  }

  spiral.draw();

  //if (frameCount <= 184) {
  //  saveFrame("frames/#####.png");
  //}
}

void gradient() {
}

void keyPressed() {
  if (key == 'p') {
    if (pause == null) {
      pause = speed;
      sineSpeedPause = sineSpeed;
      speed = 0;
      sineSpeed = 0;
    } else {
      speed = pause;
      sineSpeed = sineSpeedPause;
      pause = null;
      sineSpeedPause = null;
    }
  } else if (pause == null) {
    if (key == ' ') {
      direction = direction.equals(Direction.CLOCKWISE)
        ? Direction.COUNTER_CLOCKWISE
        : Direction.CLOCKWISE;
    } else if (key == '0') {
      zoomDomain = 1;
      zoom = 1;
    } else if (key == CODED) {
      if (pause == null) {
        if (keyCode == UP) {
          speed -= smallSpeedDelta;
        } else if (keyCode == DOWN) {
          speed += smallSpeedDelta;
        } else if (keyCode == LEFT) {
          speed += largeSpeedDelta;
        } else if (keyCode == RIGHT) {
          speed -= largeSpeedDelta;
        }
      }
    }
  }
  printParams();
}

void mouseWheel(MouseEvent event) {
  zoomDomain -= event.getCount();
  zoom = exp(zoomDomain / 10);
  printParams();
}

void printParams() {
  println("Direction:", direction, "Speed:", speed, "Scale: " + zoom);
}
