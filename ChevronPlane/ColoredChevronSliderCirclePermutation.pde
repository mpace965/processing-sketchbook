
class ColoredChevronSliderCirclePermutation extends ChevronSliderCirclePermutation {
  ColoredChevronSliderCirclePermutation(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames) {
    super(size, numHeight, numWidth, numXSections, numYSections, transitionFrames, false);
  }

  ColoredChevronSliderCirclePermutation(int size, int numHeight, int numWidth, int numXSections, int numYSections, int transitionFrames, boolean debug) {
    super(size, numHeight, numWidth, numXSections, numYSections, transitionFrames, debug);
  }
  
  protected int getChevronStrokeWeight() {
    return 7;
  }
  
  protected int getHeightSpacingFactor() {
    return 2;
  }
  
  protected color getBackgroundColor() {
    return #f9ffff;
  }

  protected color getChevronColorForRow(int row) {
    if (row % 2 == 0) {
      return #d7a1f2; // line
    }
    return #7fffd4; // outline
  }
}
