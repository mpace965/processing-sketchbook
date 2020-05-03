class ChevronSliderCycle2 extends ChevronSlider {
  ChevronSliderCycle2(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames) {
    super(size, numHeight, numWidth, numXSections, numYSections, transitionFrames, false);
  }

  ChevronSliderCycle2(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames, boolean debug) {
    super(size, numHeight, numWidth, numXSections, numYSections, transitionFrames, debug);
  }

  @Override
  protected color getChevronColorForRow(int row) {
    if (row % 2 == 0) {
      return #000000;
    } else {
      return #0000ff;
    }
  }

  @Override
  protected void getNextXOffsets(IntList next) {
    if (this.offsetGeneration % 8 == 2) {
      for (int i = 0; i < this.numXSections; i++) {
        if (i % 2 == 0) next.add(i, 50);
      }
    }
    if (this.offsetGeneration % 8 == 6) {
      for (int i = 0; i < this.numXSections; i++) {
        if (i % 2 == 0) next.add(i, 100);
      }
    }
  }

  @Override
  protected void getNextYOffsets(IntList next) {
    if (this.offsetGeneration % 8 == 0) {
      for (int i = 0; i < this.numYSections; i++) {
        if (i % 2 == 0) next.add(i, 50);
      }
    }
    if (this.offsetGeneration % 8 == 4) {
      for (int i = 0; i < this.numYSections; i++) {
        if (i % 2 == 0) next.add(i, 100);
      }
    }
  }
}
