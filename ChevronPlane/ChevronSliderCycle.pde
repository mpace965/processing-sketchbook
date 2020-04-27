class ChevronSliderCycle extends ChevronSlider {
  ChevronSliderCycle(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames) {
    super(size, numHeight, numWidth, numXSections, numYSections, transitionFrames, false);
  }

  ChevronSliderCycle(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames, boolean debug) {
    super(size, numHeight, numWidth, numXSections, numYSections, transitionFrames, debug);
  }

  @Override
  protected void getNextXOffsets(IntList next) {
    if (this.offsetGeneration % 4 == 2) {
      for (int i = 0; i < this.numXSections ; i++) {
        if (i % 2 == 0) next.add(i, 50);
      }
    }
  }

  @Override
  protected void getNextYOffsets(IntList next) {
    if (this.offsetGeneration % 4 == 0) {
      for (int i = 0; i < this.numYSections ; i++) {
        if (i % 2 == 0) next.add(i, 50);
      }
    }
  }
}
