class ChevronSliderNext extends ChevronSlider {
  ChevronSliderNext(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames) {
    super(size, numHeight, numWidth, numXSections, numYSections, transitionFrames, false);
  }

  ChevronSliderNext(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames, boolean debug) {
    super(size, numHeight, numWidth, numXSections, numYSections, transitionFrames, debug);
  }
  
  @Override
  protected void getNextXOffsets(IntList next) {
    //if (this.offsetGeneration % 4 == 0) {
    //  next.add(0, -50);
    //} else if (this.offsetGeneration % 4 == 2) {
    //  next.add(0, 50);
    //}
  }

  @Override
  protected void getNextYOffsets(IntList next) {
    if (this.offsetGeneration % 4 == 0) {
      next.add(0, -50);
    } else if (this.offsetGeneration % 4 == 2) {
      next.add(0, 50);
    }
  }
}
