int size = 800;

ChevronSlider a;
ChevronSliderCycle b;
ChevronSliderCycle c;
ChevronSliderCycle2 d;
ChevronSliderCirclePermutation e;
FishChevronSlider f;
ColoredChevronSliderCirclePermutation g;

void setup() {
  size(800, 800);
  frameRate(60);

  a = new ChevronSlider(size, 19, 6, 8, 8, 45);
  b = new ChevronSliderCycle(size, 19, 6, 8, 8, 45);
  c = new ChevronSliderCycle(size, 19, 6, 8, 16, 45);
  //for (int i = 1; i < 24 * 45; i++) c.addSaveFrame(i);
  
  d = new ChevronSliderCycle2(size, 19, 6, 8, 16, 45);
  //for (int i = 1; i < 2 * 24 * 45; i++) d.addSaveFrame(i);
  
  e = new ChevronSliderCirclePermutation(size, 19, 6, 2, 2, 15);
  e.setInitialGeneration(8 * 350);
  //for (int i = 1; i < 480; i += 120) e.addSaveFrame(i);
  
  f = new FishChevronSlider(size, 19, 6, 8, 16, 2);
  g = new ColoredChevronSliderCirclePermutation(size, 38, 6, 2, 2, 15);
  g.setInitialGeneration(100000);
  g.addSaveFrame(2400);
  //for (int i = 1; i < 8 * 15 * 20; i ++) g.addSaveFrame(i);
}

void draw() {
  //a.draw(); // Static chevrons
  //b.draw(); // Simple cycle with 8
  //c.draw(); // Simple cycle with 16
  //d.draw(); // The cool one containing the fish
  //e.draw(); // The one that doesn't repeat for 285998 years
  //f.draw(); // Fast-forward to the fish
  g.draw(); // Same as e but with a different pallete
}
