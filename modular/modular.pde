/*

 Modular Math
 
 */

import processing.serial.*;
import deadpixel.keystone.*;

// Arduino stuff
boolean arduinoPresent = false;      // do we have Arduino?
Serial myPort;                       // The serial port
int[] serialInArray = new int[5];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive
boolean firstContact = false;        // Whether we've heard from the microcontroller

// Videmapping stuff
Keystone ks;
CornerPinSurface surface;
PGraphics offscreen;

void setup() {
  fullScreen(P3D);
  // size(1920, 1080, P3D);
  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(displayWidth, displayHeight, 20);
  offscreen = createGraphics(displayWidth, displayHeight, P3D);
  initVariables();
  cursor(CROSS);
  // pixelDensity(2);

  if (arduinoPresent) {
    println(Serial.list());
    String portName = Serial.list()[1];
    myPort = new Serial(this, portName, 9600);
  }
}

void draw() {


  float m = width / 24; // margen horizontal

  float r = height * .47;
  float x = m + r;
  float y = height * .5;


  surfaceMouse = surface.getTransformedMouse();
  if (!arduinoPresent) prop = surfaceMouse.x/(offscreen.width/2);
  offscreen.beginDraw();
  {
    offscreen.background(0);

    if (keyPressed) checkKeyboard();

    if (circle) {
      offscreen.noFill();
      offscreen.stroke(255);
      offscreen.strokeWeight(3);
      offscreen.ellipse(x, y, 2*r, 2*r);
    }

    switch(escena) {
    case 0:
      // (s)ize, (n)branch number, (l)evels

      recursive(x, y, r * (PI/10), constrain(num, 1, 10), constrain(mult, 0, 10));
      offscreen.textFont(bold);
      offscreen.textSize(72);
      offscreen.text("§", PI * m + 2.2 * r, height/2);
      offscreen.textFont(font);
      offscreen.textSize(48);
      offscreen.text(num + " ~ " + mult+"n", PI * m + 2.2 * r, height/2 + 72);


      offscreen.textFont(bold);
      offscreen.textSize(24);
      offscreen.fill(orange);
      
      switch(permutator) {

      case 0:
        offscreen.pushMatrix();
        offscreen.translate(PI * m + 2.2 * r - 100, height/2 + 55);
        // offscreen.line(-l, y - v/2, l, y - v/2);
        offscreen.ellipse(0, 0, 15, 15);
        offscreen.popMatrix();
        break;

      case 1:
        offscreen.pushMatrix();
        offscreen.translate(PI * m + 2.2 * r + 100, height/2 + 55);
        // offscreen.line(-l, y - v/2, l, y - v/2);
        offscreen.ellipse(0, 0, 15, 15);
        offscreen.popMatrix();
        break;
      }
      break;

    case 1:
      modular(x, y, r, num, mult);
      drawNumbers(PI * m + 2.2 * r, height/2);
      break;
    }
  }
  offscreen.endDraw();
  background(0);
  surface.render(offscreen);
}