class ChevronSliderCirclePermutation extends ChevronSlider {
  ChevronSliderCirclePermutation(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames) {
    super(size, numHeight, numWidth, numXSections, numYSections, transitionFrames, false);
  }

  ChevronSliderCirclePermutation(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames, boolean debug) {
    super(size, numHeight, numWidth, numXSections, numYSections, transitionFrames, debug);
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
