class CircleSpiral extends Spiral {
  float strokeWeight = 1;
  
  CircleSpiral(int nElements, float speed) {
    super(nElements, speed, Direction.CLOCKWISE);
  }
  
  CircleSpiral(int nElements, float speed, Direction direction) {
    super(nElements, speed, direction);
  }
  
  void drawElement() {
    fill(getFillColor());
    strokeWeight(getStrokeWeight());
    stroke(getStrokeColor());
    circle(this.radius * cos(theta), this.radius * sin(theta), getSize());
  }
  
  protected color getFillColor() {
    return white; 
  }
  
  protected float getStrokeWeight() {
   return strokeWeight; 
  }
  
  protected void setStrokeWeight(float weight) {
    this.strokeWeight = weight;
  }
  
  protected color getStrokeColor() {
    return black;
  }
  
  protected float getSize() {
   return 50; 
  }
}

class ScalableCircleSpiral extends CircleSpiral {
  protected float startSize = 50;
  protected float endSize = 50;
  
  ScalableCircleSpiral(int nElements, float speed) {
    super(nElements, speed, Direction.CLOCKWISE);
  }
  
  ScalableCircleSpiral(int nElements, float speed, Direction direction) {
    super(nElements, speed, direction);
  }
  
  public void setSizeRange(float minSize, float maxSize) {
    this.startSize = minSize;
    this.endSize = maxSize;
  }
  
  float getSize() {
    return map(this.radius, 0, this.nElements, this.startSize, this.endSize);
  }
}

class SineScalableCircleSpiral extends CircleSpiral {
  protected float minSize = 0;
  protected float maxSize = 50;
  protected float sineSpeed = 1;
  protected float amplitude, midline;
  
  SineScalableCircleSpiral(int nElements, float speed, float minSize, float maxSize, Direction direction) {
    super(nElements, speed, direction);
    this.minSize = minSize;
    this.maxSize = maxSize;
    this.updateSineProperties();
  }
  
  SineScalableCircleSpiral(int nElements, float speed, float minSize, float maxSize) {
    this(nElements, speed, minSize, maxSize, Direction.CLOCKWISE);
  }
  
  public void setMinSize(float minSize) {
    this.minSize = minSize;
    this.updateSineProperties();
  }
  
  public void setMaxSize(float maxSize) {
    this.maxSize = maxSize;
    this.updateSineProperties();
  }
  
  public void setSineSpeed(float sineSpeed) {
    this.sineSpeed = sineSpeed;
  }
  
  protected void updateSineProperties() {
    this.amplitude = (this.maxSize - this.minSize) / 2;
    this.midline = this.maxSize - this.amplitude;
  }
  
  float getSize() {
    return this.amplitude * cos(radians(this.radius + frameCount * this.sineSpeed)) + this.midline;
  }
}

class RadialGrayscaleCircleSpiral extends ScalableCircleSpiral {
  protected color startColor = white;
  protected color endColor = white;
  
  RadialGrayscaleCircleSpiral(int nElements, float speed) {
    super(nElements, speed, Direction.CLOCKWISE);
  }
  
  RadialGrayscaleCircleSpiral(int nElements, float speed, Direction direction) {
    super(nElements, speed, direction);
  }
  
  public void setColorRange(color startColor, color endColor) {
    this.startColor = startColor;
    this.endColor = endColor;
  }
  
  color getFillColor() {
    return floor(map(this.radius, 0, this.nElements, this.startColor, this.endColor));
  }
}

class RadialColorscaleCircleSpiral extends ScalableCircleSpiral {
  protected int startRedValue = 0;
  protected int endRedValue = 0;
  
  protected int startGreenValue = 0;
  protected int endGreenValue = 0;
  
  protected int startBlueValue = 0;
  protected int endBlueValue = 0;
  
  RadialColorscaleCircleSpiral(int nElements, float speed) {
    super(nElements, speed, Direction.CLOCKWISE);
  }
  
  RadialColorscaleCircleSpiral(int nElements, float speed, Direction direction) {
    super(nElements, speed, direction);
  }
  
  public void setRedColorRange(int startRedValue, color endRedValue) {
    this.startRedValue = startRedValue;
    this.endRedValue = endRedValue;
  }
  
  public void setGreenColorRange(int startGreenValue, color endGreenValue) {
    this.startGreenValue = startGreenValue;
    this.endGreenValue = endGreenValue;
  }
  
  public void setBlueColorRange(int startBlueValue, color endBlueValue) {
    this.startBlueValue = startBlueValue;
    this.endBlueValue = endBlueValue;
  }
  
  protected int getRedValue() {
    return floor(map(this.radius, 0, this.nElements, this.startRedValue, this.endRedValue));
  }
  
  protected int getGreenValue() {
    return floor(map(this.radius, 0, this.nElements, this.startGreenValue, this.endGreenValue));
  }
  
  protected int getBlueValue() {
    return floor(map(this.radius, 0, this.nElements, this.startBlueValue, this.endBlueValue));
  }
  
  color getFillColor() {
    return color(getRedValue(), getGreenValue(), getBlueValue());
  }
}

class SineColorscaleCircleSpiral extends SineScalableCircleSpiral {
  protected int startRedValue = 0;
  protected int endRedValue = 0;
  
  protected int startGreenValue = 0;
  protected int endGreenValue = 0;
  
  protected int startBlueValue = 0;
  protected int endBlueValue = 0;
  
  SineColorscaleCircleSpiral(int nElements, float speed, float minSize, float maxSize, Direction direction) {
    super(nElements, speed, minSize, maxSize, direction);
  }
  
  SineColorscaleCircleSpiral(int nElements, float speed, float minSize, float maxSize) {
    this(nElements, speed, minSize, maxSize, Direction.CLOCKWISE);
  }
  
  public void setRedColorRange(int startRedValue, color endRedValue) {
    this.startRedValue = startRedValue;
    this.endRedValue = endRedValue;
  }
  
  public void setGreenColorRange(int startGreenValue, color endGreenValue) {
    this.startGreenValue = startGreenValue;
    this.endGreenValue = endGreenValue;
  }
  
  public void setBlueColorRange(int startBlueValue, color endBlueValue) {
    this.startBlueValue = startBlueValue;
    this.endBlueValue = endBlueValue;
  }
  
  protected int getRedValue() {
    return floor(map(this.radius, 0, this.nElements, this.startRedValue, this.endRedValue));
  }
  
  protected int getGreenValue() {
    return floor(map(this.radius, 0, this.nElements, this.startGreenValue, this.endGreenValue));
  }
  
  protected int getBlueValue() {
    return floor(map(this.radius, 0, this.nElements, this.startBlueValue, this.endBlueValue));
  }
  
  color getFillColor() {
    return color(getRedValue(), getGreenValue(), getBlueValue());
  }
}
