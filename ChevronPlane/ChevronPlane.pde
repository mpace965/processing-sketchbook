int size = 800;

ChevronSlider a;
ChevronSliderCycle b;
ChevronSliderCycle c;
ChevronSliderCycle2 d;
ChevronSliderCirclePermutation e;
FishChevronSlider f;

void setup() {
  size(800, 800);
  frameRate(60);

  a = new ChevronSlider(size, 19, 6, 8, 8, 45);
  b = new ChevronSliderCycle(size, 19, 6, 8, 8, 45);
  c = new ChevronSliderCycle(size, 19, 6, 8, 16, 45);
  d = new ChevronSliderCycle2(size, 19, 6, 8, 16, 45);
  e = new ChevronSliderCirclePermutation(size, 19, 6, 2, 2, 15);
  //e.setInitialGeneration(8 * 500);
  f = new FishChevronSlider(size, 19, 6, 8, 16, 2);
}

void draw() {
  //a.draw(); // Static chevrons
  //b.draw(); // Simple cycle with 8
  //c.draw(); // Simple cycle with 16
  //d.draw(); // The cool one containing the fish
  e.draw(); // The one that doesn't repeat for 285998 years
  //f.draw(); // Fast-forward to the fish
}
