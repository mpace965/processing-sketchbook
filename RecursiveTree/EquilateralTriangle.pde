
PShape equilateralTriangle(float triangleHeight) {
  float sideLength = triangleHeight * 2 / sqrt(3);
  float halfSideLength = sideLength / 2;
  float centroidHeight = triangleHeight / 3;
  PShape equi = createShape();
  
  equi.beginShape();
  equi.strokeWeight(8);
  equi.fill(#ff0000);
  equi.translate(0, centroidHeight);
  equi.vertex(0, -triangleHeight);
  equi.vertex(-halfSideLength, 0);
  equi.vertex(halfSideLength, 0);
  equi.endShape(CLOSE);
  
  return equi;
}
