int size = 800;
int halfSize = size / 2;
int quarterSize = size / 4;
int halfPixels = size * size / 2;
int quarterPixels = size * size / 4;
int chevWidth = quarterSize;
int chevHeight = chevWidth / 2;

int numHeight = 19;
int numWidth = 6;

int numXSections = 8;
int xSectionSize = size / numXSections;
IntList xOffsets = new IntList();
IntList nextXOffsets = new IntList();

int numYSections = 8;
int ySectionSize = size / numYSections;
IntList yOffsets = new IntList();
IntList nextYOffsets = new IntList();

int offsetGeneration = 0;
int transitionFrames = 45;
PImage lastGenerationSnapshot;

boolean debug = false;

void debugOffset() {
  if (debug) {
    println("[Offset Generation] ", offsetGeneration);
  }
}

void debugFrameHeader() {
  if (debug) {
    String formattedFrame = nf(frameCount, 6);
    String frameHeaderSegment = "===============================================";
    println(frameHeaderSegment, formattedFrame, frameHeaderSegment);
  }
}

void setup() {
  size(800, 800);
  frameRate(60);
  
  for (int i = 0; i < numXSections; i++) {
    xOffsets.append(0);
    nextXOffsets.append(0);
  }
  
  for (int i = 0; i < numYSections; i++) {
    yOffsets.append(0);
    nextYOffsets.append(0);
  }
  
  debugOffset();
}

void draw() {
  debugFrameHeader();
  background(255);

  stroke(0);
  strokeWeight(10);
  strokeCap(PROJECT);
  
  if (lastGenerationSnapshot == null) {  
    drawChevrons();
    
    lastGenerationSnapshot = snapshot();
    
    background(255);
  }
  
  image(shiftVertical(shiftHorizontal(lastGenerationSnapshot.copy())), 0, 0);
  stepOffsets();
}

void drawChevrons() {
  for (int y = 0; y < numHeight; y++) {
    for (int x = 0; x < numWidth; x++) {
      drawChevron(chevWidth * x - chevWidth, chevHeight * y / 2 - chevHeight, chevWidth, chevHeight);
    }
  }
}

void drawChevron(float x, float y, float chevWidth, float chevHeight) {
  line(x, y, x + chevWidth / 2, y + chevHeight);
  line(x + chevWidth / 2, y + chevHeight, x + chevWidth, y);
}

PImage snapshot() {
  loadPixels();
  PImage snapshot = createImage(size, size, RGB);
  snapshot.loadPixels();
  snapshot.pixels = pixels;
  snapshot.updatePixels();
  
  return snapshot;
}

PImage shiftHorizontal(PImage image) {
  for (int i = 0; i < numXSections; i++) {
    int startY = xSectionSize * i;
    int endY = xSectionSize * (i + 1);
    shiftHorizontalSectionImg(image, startY, endY, xOffsets.get(i));
  }
  
  return image;
}

PImage shiftVertical(PImage image) {
  for (int i = 0; i < numYSections; i++) {
    int startX = ySectionSize * i;
    int endX = ySectionSize * (i + 1);
    shiftVerticalSectionImg(image, startX, endX, yOffsets.get(i));
  }
  
  return image;
}

void stepOffsets() {
  int frameMod = (frameCount - 1) % transitionFrames;
  float progressTheta = map(frameMod, 0, transitionFrames - 1, 0, HALF_PI);
  float progress = pow(sin(progressTheta), 2);
  
  if (frameMod == 0) {
    offsetGeneration++;
    debugOffset();
    
    lastGenerationSnapshot = snapshot();
    
    xOffsets = new IntList();
    for (int i = 0; i < numXSections; i++) xOffsets.append(0);
    nextXOffsets = getNextXOffsets();
    
    yOffsets = new IntList();
    for (int i = 0; i < numYSections; i++) yOffsets.append(0);
    nextYOffsets = getNextYOffsets();
  }
  
  for (int i = 0; i < numXSections; i++) {
    xOffsets.set(i, ceil(map(progress, 0, 1, 0, nextXOffsets.get(i))));
  }
  
  for (int i = 0; i < numYSections; i++) {
    yOffsets.set(i, ceil(map(progress, 0, 1, 0, nextYOffsets.get(i))));
  }
}

IntList getNextXOffsets() {
  IntList next = new IntList(xOffsets.array());
  
  return next;
}

IntList getNextYOffsets() {
  IntList next = new IntList(yOffsets.array());
  
  return next;
}

void shiftHorizontalSectionImg(PImage img, int startY, int endY, int offset) {
  img.loadPixels();
  shiftHorizontalSection(img.pixels, startY, endY, offset);
  img.updatePixels();
}

void shiftVerticalSectionImg(PImage img, int startY, int endY, int offset) {
  img.loadPixels();
  shiftVerticalSection(img.pixels, startY, endY, offset);
  img.updatePixels();
}

void shiftVerticalSection(color[] source, int startX, int endX, int offset) {
  for (int x = startX; x < endX; x++) {
    color[] pushedPixels = new color[offset];
    for (int y = 0; y < size; y++) {
      int idx = index2D(size, y, x);
      if (y < size - offset) {
        if (y < offset) pushedPixels[y] = source[idx];
        source[idx] = source[index2D(size, y + offset, x)];
      } else {
        source[idx] = pushedPixels[abs(size - y - offset)];
      }
    }
  }
}

void shiftHorizontalSection(color[] source, int startY, int endY, int offset) {
  for (int y = startY; y < endY; y++) {
    color[] pushedPixels = new color[offset];
    for (int x = 0; x < size; x++) {
      int idx = index2D(size, y, x);
      if (x < size - offset) {
        if (x < offset) pushedPixels[x] = source[idx];
        source[idx] = source[index2D(size, y, x + offset)];
      } else {
        source[idx] = pushedPixels[abs(size - x - offset)];
      }
    }
  }
}

int index2D(int arrayWidth, int row, int col) {
  return row * arrayWidth + col;
}
