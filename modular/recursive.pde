/*
 
 General Recursive Function
 
 x,y - pos
 
 (s)ize, (n)branch number, (l)evels

*/

void recursive(float x, float y, float s, int n, int l) {
  float ang = TWO_PI / float(n);
  offscreen.pushMatrix();
  offscreen.translate(x, y);
  if(multiplier != 0){
    offscreen.rotate(millis() / 19999.9);
  }
  color c = gray;
  for (int i = 0; i < n; i++) {
    offscreen.rotate(ang);
    offscreen.strokeWeight(.5 + s / 40);
    offscreen.stroke(c);
    offscreen.line(0, 0, s, 0);
    offscreen.noStroke();
    offscreen.fill(c);
    offscreen.ellipse(s, 0, s / 15, s / 15);
    if (l > 0) {
      offscreen.pushMatrix();
      offscreen.translate(s, 0);
      if (n % 2 == 0) {
        offscreen.rotate(ang / 2.0);
      } else {
        offscreen.rotate(ang);
      }
      recursive(0, 0, s * prop, n, l - 1);
      offscreen.popMatrix();
    }
  }
  offscreen.popMatrix();
}