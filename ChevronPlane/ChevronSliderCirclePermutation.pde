class ChevronSliderCirclePermutation extends ChevronSlider {
  int initialGeneration = 0;

  ChevronSliderCirclePermutation(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames) {
    super(size, numHeight, numWidth, numXSections, numYSections, transitionFrames, false);
  }

  ChevronSliderCirclePermutation(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames, boolean debug) {
    super(size, numHeight, numWidth, numXSections, numYSections, transitionFrames, debug);
  }

  public void setInitialGeneration(int initialGeneration) {
    this.initialGeneration = initialGeneration;
  }

  protected void modifyInitialImage() {
    for (int i = 0; i < this.initialGeneration; i++) {
      shiftVertical(shiftHorizontal(this.lastGenerationSnapshot));
      stepOffsetGeneration(this.lastGenerationSnapshot);
      this.xOffsets = this.nextXOffsets;
      this.yOffsets = this.nextYOffsets;
    }
  }

  protected color getChevronColorForRow(int row) {
    if (row % 2 == 0) {
      return #0000ff;
    }
    return 0;
  }

  @Override
  protected void getNextXOffsets(IntList next) {
    for (int i = 0; i < this.numXSections; i++) {
      if (this.offsetGeneration % 8 == 2 && i < this.numXSections / 2) {
        next.add(i, 50);
      }

      if (this.offsetGeneration % 8 == 6 && i >= this.numXSections / 2) {
        next.add(i, -50);
      }
    }
  }

  @Override
  protected void getNextYOffsets(IntList next) {
    for (int i = 0; i < this.numYSections; i++) {
      if (this.offsetGeneration % 8 == 0 && i >= this.numYSections / 2) {
        next.add(i, 50);
      }
      if (this.offsetGeneration % 8 == 4 && i < this.numYSections / 2) {
        next.add(i, -50);
      }
    }
  }
}
