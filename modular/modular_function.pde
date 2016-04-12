/*

 the main function
 
 */

void modular(float x, float y, float r, int num, int mult) {

  offscreen.pushMatrix();
  offscreen.translate(x, y);

  float inc = TWO_PI / num;                  // distance between points
  float pr = map(inc, 0, QUARTER_PI, 2, 40); // point radius
  pr = constrain(pr, 1.5, 40);

  // lines
  float sw = map(num, 1, 500, 3, .25); // weight of the line
  sw = constrain(sw, .25, 3);

  for (int i = 0; i < num; i++) {
    int result = (i * mult) % num;

    // origin
    float x1 = cos(PI + i * inc) * r;
    float y1 = sin(PI + i * inc) * r;

    // result
    float x2 = cos(PI + result * inc) * r;
    float y2 = sin(PI + result * inc) * r;

    float d = dist(surfaceMouse.x - x, surfaceMouse.y - y, x1, y1);
    offscreen.strokeWeight(sw);
    if (d < (pr)) {
      offscreen.stroke(orange);
      offscreen.strokeWeight(sw * 1.26);
    } else {
      offscreen.stroke(gray);
      
    }
    // draw lines
    offscreen.line(x1, y1, x2, y2);

    // draw yellow dot
    if (yellowDot == 1) {

      float xm = lerp(x1, x2, prop);
      float ym = lerp(y1, y2, prop);

      offscreen.fill(yellow);
      offscreen.stroke(yellow);
      offscreen.ellipse(xm, ym, 1 + 2 * sw, 1 + 2 * sw);
    }
  }


  // cicle of points
  offscreen.noStroke();
  offscreen.fill(orange);
  for (float t = 0; t < TWO_PI; t += inc) {
    offscreen.ellipse(cos(PI + t) * r, sin(PI + t) * r, pr, pr);
  }

  // calc if mouseOver a circle
  for (int i = 0; i < num; i++) {

    //int result = (i * mult) % num;

    // origin
    float x1 = cos(PI + i * inc) * r;
    float y1 = sin(PI + i * inc) * r;

    float d = dist(surfaceMouse.x - x, surfaceMouse.y - y, x1, y1);
    if (d < (pr + 1)) {
      currentNumber = i;

      // bigger circle at hover
      offscreen.noStroke();
      offscreen.fill(orange);
      offscreen.ellipse(x1, y1, pr * 1.3, pr * 1.3);

      // render current number
      offscreen.fill(0);
      offscreen.textFont(bold);
      offscreen.textSize(inc * 40);
      offscreen.text(currentNumber, x1, y1 + offscreen.textAscent()/3, 1);
      break; // exit. stop calculating
    }
  }

  offscreen.popMatrix();
}