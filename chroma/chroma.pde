/*

 Chroma Disk
 
 */

import processing.serial.*;
import deadpixel.keystone.*;

void setup() {
  fullScreen(P3D);
  // size(500, 500, P3D);
  // pixelDensity(2);
  colorMode(RGB, 255);
  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(width, height, 20);
  offscreen = createGraphics(width, height, P3D);
  initVariables();
  cursor(CROSS);
  if (arduinoPresent) {
    println(Serial.list());
    String portName = Serial.list()[1];
    myPort = new Serial(this, portName, 9600);
  }
}

void draw() {
  background(0);
  rot += 0.001;
  if (keyPressed) checkKeyboard();
  offscreen.beginDraw();
  offscreen.background(0);
  chromatic(width/2, height/2, steps, col1, col2);
  offscreen.endDraw();
  surface.render(offscreen);
}