int size = 800;

ChevronSlider a;
ChevronSliderCycle b;

void setup() {
  size(800, 800);
  frameRate(60);
  
  a = new ChevronSlider(size, 19, 6, 8, 8, 45);
  b = new ChevronSliderCycle(size, 19, 6, 8, 8, 45);
}

void draw() {
  //a.draw();
  b.draw();
}
