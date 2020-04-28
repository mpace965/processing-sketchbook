class ChevronSlider {
  protected int size, halfSize, quarterSize, halfPixels, quarterPixels, chevWidth, chevHeight;
  
  protected int numHeight, numWidth;
  
  protected int numXSections, xSectionSize;
  protected IntList xOffsets, nextXOffsets;
  
  protected int numYSections, ySectionSize;
  protected IntList yOffsets, nextYOffsets;
  
  protected int offsetGeneration, transitionFrames;
  PImage lastGenerationSnapshot;
  
  boolean debug;
  
  public ChevronSlider(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames) {
    this(size, numHeight, numWidth, numXSections, numYSections, transitionFrames, false);
  }
  
  public ChevronSlider(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames, boolean debug) {
    this.size = size;
    this.halfSize = size / 2;
    this.quarterSize = size / 4;
    this.halfPixels = size * size / 2;
    this.quarterPixels = size * size / 4;
    this.chevWidth = quarterSize;
    this.chevHeight = chevWidth / 2;
    
    this.numHeight = numHeight;
    this.numWidth = numWidth;
    
    this.numXSections = numXSections;
    this.xSectionSize = size / numXSections;
    this.xOffsets = new IntList();
    this.nextXOffsets = new IntList();
    for (int i = 0; i < this.numXSections; i++) {
      this.xOffsets.append(0);
      this.nextXOffsets.append(0);
    }
    
    this.numYSections = numYSections;
    this.ySectionSize = size / numYSections;
    this.yOffsets = new IntList();
    this.nextYOffsets = new IntList();
    for (int i = 0; i < this.numYSections; i++) {
      this.yOffsets.append(0);
      this.nextYOffsets.append(0);
    }
    
    this.offsetGeneration = 0;
    this.transitionFrames = transitionFrames;
    
    this.debug = debug;
    debugOffset();
  }
  
  public void setDebug(boolean debug) {
    this.debug = debug;
  }
  
  private void debugOffset() {
    if (debug) {
      println("[Offset Generation]", offsetGeneration);
    }
  }

  private void debugFrameHeader() {
    if (debug) {
      String formattedFrame = nf(frameCount, 6);
      String frameHeaderSegment = "===============================================";
      println(frameHeaderSegment, formattedFrame, frameHeaderSegment);
    }
  }
  
  public void draw() {
    push();
    debugFrameHeader();

    stroke(0);
    strokeWeight(10);
    strokeCap(PROJECT);
    
    if (this.lastGenerationSnapshot == null) {
      drawInitialBackground();
      drawChevrons();
      this.lastGenerationSnapshot = snapshot();
      background(255);
    }
    
    image(shiftVertical(shiftHorizontal(this.lastGenerationSnapshot.copy())), 0, 0);
    stepOffsets();
    
    pop();
  }
  
  protected void drawInitialBackground() {
    background(255);
  }

  private void drawChevrons() {
    for (int y = 0; y < this.numHeight; y++) {
      stroke(getChevronColorForRow(y));
      for (int x = 0; x < this.numWidth; x++) {
        drawChevron(this.chevWidth * x - this.chevWidth, this.chevHeight * y / 2 - this.chevHeight, this.chevWidth, this.chevHeight);
      }
    }
    stroke(#000000);
  }
  
  protected color getChevronColorForRow(int row) {
    return #000000;
  }

  private void drawChevron(float x, float y, float chevWidth, float chevHeight) {
    line(x, y, x + chevWidth / 2, y + chevHeight);
    line(x + chevWidth / 2, y + chevHeight, x + chevWidth, y);
  }
  
  private PImage snapshot() {
    loadPixels();
    PImage snapshot = createImage(size, size, RGB);
    snapshot.loadPixels();
    snapshot.pixels = pixels;
    snapshot.updatePixels();
    
    return snapshot;
  }
  
  private PImage shiftHorizontal(PImage image) {
    for (int i = 0; i < this.numXSections; i++) {
      int startY = this.xSectionSize * i;
      int endY = this.xSectionSize * (i + 1);
      shiftHorizontalSectionImg(image, startY, endY, this.xOffsets.get(i));
    }
    
    return image;
  }
  
  private PImage shiftVertical(PImage image) {
    for (int i = 0; i < this.numYSections; i++) {
      int startX = this.ySectionSize * i;
      int endX = this.ySectionSize * (i + 1);
      shiftVerticalSectionImg(image, startX, endX, this.yOffsets.get(i));
    }
    
    return image;
  }
  
  private void stepOffsets() {
    int frameMod = (frameCount - 1) % this.transitionFrames;
    float progressTheta = map(frameMod, 0, this.transitionFrames - 1, 0, HALF_PI);
    float progress = pow(sin(progressTheta), 2);
    
    if (frameMod == 0) {
      this.offsetGeneration++;
      debugOffset();
      
      this.lastGenerationSnapshot = snapshot();
      
      this.xOffsets = new IntList();
      for (int i = 0; i < this.numXSections; i++) this.xOffsets.append(0);
      this.nextXOffsets = getNextXOffsets();
      
      this.yOffsets = new IntList();
      for (int i = 0; i < this.numYSections; i++) this.yOffsets.append(0);
      this.nextYOffsets = getNextYOffsets();
    }
    
    for (int i = 0; i < this.numXSections; i++) {
      this.xOffsets.set(i, ceil(map(progress, 0, 1, 0, this.nextXOffsets.get(i))));
    }
    
    for (int i = 0; i < this.numYSections; i++) {
      this.yOffsets.set(i, ceil(map(progress, 0, 1, 0, this.nextYOffsets.get(i))));
    }
  }
  
  private IntList getNextXOffsets() {
    IntList next = new IntList(this.xOffsets.array());
    
    getNextXOffsets(next);
    
    return next;
  }
  
  protected void getNextXOffsets(IntList next) { }
  
  private IntList getNextYOffsets() {
    IntList next = new IntList(this.yOffsets.array());
    
    getNextYOffsets(next);
    
    return next;
  }
  
  protected void getNextYOffsets(IntList next) { }
  
  private void shiftHorizontalSectionImg(PImage img, int startY, int endY, int offset) {
    img.loadPixels();
    shiftHorizontalSection(img.pixels, startY, endY, offset);
    img.updatePixels();
  }
  
  private void shiftVerticalSectionImg(PImage img, int startY, int endY, int offset) {
    img.loadPixels();
    shiftVerticalSection(img.pixels, startY, endY, offset);
    img.updatePixels();
  }
  
  private void shiftVerticalSection(color[] source, int startX, int endX, int offset) {
    if (offset == 0) return;

    int posOffset = abs(offset);
    
    for (int x = startX; x < endX; x++) {
      color[] pushedPixels = new color[posOffset];
      
      if (offset > 0) {
        for (int y = 0; y < this.size; y++) {
          int idx = index2D(this.size, y, x);
          if (y < this.size - offset) {
            if (y < offset) pushedPixels[y] = source[idx];
            source[idx] = source[index2D(this.size, y + offset, x)];
          } else {
            source[idx] = pushedPixels[abs(this.size - y - offset)];
          }
        }
      } else {
        for (int y = this.size - 1; y >= 0; y--) {
          int idx = index2D(this.size, y, x);
          if (y >= posOffset) {
            if (y > size + offset - 1) pushedPixels[posOffset - (this.size - y)] = source[idx];
            source[idx] = source[index2D(this.size, y - posOffset, x)];
          } else {
            source[idx] = pushedPixels[y];
          }
        }
      }
    }
  }
  
  private void shiftHorizontalSection(color[] source, int startY, int endY, int offset) {
    if (offset == 0) return;

    int posOffset = abs(offset);
    
    for (int y = startY; y < endY; y++) {
      color[] pushedPixels = new color[posOffset];
      
      if (offset > 0) {
        for (int x = 0; x < this.size; x++) {
          int idx = index2D(this.size, y, x);
          if (x < this.size - offset) {
            if (x < offset) pushedPixels[x] = source[idx];
            source[idx] = source[index2D(this.size, y, x + offset)];
          } else {
            source[idx] = pushedPixels[abs(this.size - x - offset)];
          }
        }
      } else if (offset < 0) {
        for (int x = this.size - 1; x >= 0; x--) {
          int idx = index2D(this.size, y, x);
          if (x >= posOffset) {
            if (x > size - posOffset - 1) pushedPixels[posOffset - (this.size - x)] = source[idx];
            source[idx] = source[index2D(this.size, y, x - posOffset)];
          } else {
            source[idx] = pushedPixels[x];
          }
        }
      }
    }
  }
  
  private int index2D(int arrayWidth, int row, int col) {
    return row * arrayWidth + col;
  }
}
