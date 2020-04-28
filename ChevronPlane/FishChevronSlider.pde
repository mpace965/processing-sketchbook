class FishChevronSlider extends ChevronSliderCycle2 {
  FishChevronSlider(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames) {
    super(size, numHeight, numWidth, numXSections, numYSections, transitionFrames, false);
  }

  FishChevronSlider(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames, boolean debug) {
    super(size, numHeight, numWidth, numXSections, numYSections, transitionFrames, debug);
  }

  @Override
  protected void getNextXOffsets(IntList next) {
    if (this.offsetGeneration >= 35) return;
    super.getNextXOffsets(next);
  }

  @Override
  protected void getNextYOffsets(IntList next) {
    if (this.offsetGeneration >= 35) return;
    super.getNextYOffsets(next);
  }
}
