/*

 type + circles
 
 */

void drawNumbers(float x, float y) {

  float h = 120; // horizontal unit
  float v = 72; // vertical unit

  offscreen.fill(255);
  offscreen.noStroke();
  offscreen.textFont(font);
  offscreen.textSize(v);
  offscreen.textAlign(CENTER);
  offscreen.text(num, x - h, y);
  offscreen.text('x', x, y);
  offscreen.text(mult, x + h, y);

  offscreen.stroke(orange);
  offscreen.strokeWeight(3);
  offscreen.textFont(bold);
  offscreen.textSize(24);

  switch(permutator) {

  case 0:
    offscreen.pushMatrix();
    offscreen.translate(x - h, v);
    // offscreen.line(-l, y - v/2, l, y - v/2);
    offscreen.text(multiplierVal, 0, y);
    offscreen.popMatrix();
    break;

  case 1:
    offscreen.pushMatrix();
    offscreen.translate(x + h, v);
    // offscreen.line(-l, y - v/2, l, y - v/2);
    offscreen.text(multiplierVal, 0, y);
    offscreen.popMatrix();
    break;
  }

  if (yellowDot == 1) {
    offscreen.textFont(bold);
    offscreen.textSize(24);
    offscreen.text(prop, x, y + 3*h);
  }
}