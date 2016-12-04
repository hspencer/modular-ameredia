// the chromatic main function
 
void chromatic(float x, float y, int steps, color a, color b) {

  float inc = TWO_PI / float(steps);
  float localProp, propA, propB;

  offscreen.pushMatrix();
  offscreen.translate(x, y);
  offscreen.rotate(rot);
  offscreen.noStroke();
  offscreen.beginShape(TRIANGLE_STRIP);

  for (float t = 0; t <= TWO_PI + inc; t+=inc) {
    localProp = map(t, 0, TWO_PI, 0, 1);

    if (localProp < interpolationProp) {
      propA = map(localProp, 0, interpolationProp, 0, 1);
      offscreen.fill(lerpColor(a, b, propA));
    } else {
      propB = map(localProp, interpolationProp, 1, 0, 1);
      offscreen.fill(lerpColor(b, a, propB));
    }
    offscreen.vertex(cos(t)*r2, sin(t)*r2);
    offscreen.vertex(cos(t)*r1, sin(t)*r1);
  }
  offscreen.endShape();
  offscreen.popMatrix();
  // offscreen.filter(BLUR, 30);
}

// color functions

color moveHue(color c, float val) {
  colorMode(HSB, 255);
  float h = hue(c) + val;
  h = constrain(h, 0, 255);
  color col = color(hue(c)+val, 250, brightness(c));
  colorMode(RGB, 255);
  return col;
  
}

color moveBrightness(color c, float val) {
  colorMode(HSB, 255);
  float b = brightness(c) + val;
  b = constrain(b, 0, 255);
  color col = color(hue(c), 250, b);
  colorMode(RGB, 255);
  return col;
  
}


void updateColors(int val) {
  if (switchHueBrightness == 0) {
    // print("moveBrightness\t");
    if (switchColor == 0) {
      col1 = moveBrightness(col1, val);
    } else if (switchColor == 1) {
      col2 = moveBrightness(col2, val);
    }
  } else if (switchHueBrightness == 1) {
    // print("moveHue\t");
    if (switchColor == 0) {
      col1 = moveHue(col1, val);
    } else if (switchColor == 1) {
      col2 = moveHue(col2, val);
    }
  }
  //printColors();
}


void updateDisk(){
 if (switchPotenciometer == 0) {
      r1 = prop * r2;
    } else {
      interpolationProp = prop;
    } 
}


// debug functions

void printColors() {
  print("col1 = ("+hue(col1)+", "+brightness(col1)+", "+saturation(col1)+")"); 
  println("\t col2 = ("+hue(col2)+", "+brightness(col2)+", "+saturation(col2)+")");
}

void printSerial() {
  for (int i = 0; i < 5; i++) {
    print("["+i+"] " + serialInArray[i]+"\t");
  }
  print("\n");
}