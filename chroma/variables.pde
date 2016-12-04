// Arduino stuff
boolean arduinoPresent = false;      // do we have Arduino?
Serial myPort;                       // The serial port
int[] serialInArray = new int[5];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive
boolean firstContact = false;        // Whether we've heard from the microcontroller

// Videomapping stuff
Keystone ks;
CornerPinSurface surface;
PGraphics offscreen;


// hardware
int pot;          // proportion within the disk
int switch1;      // toggle hue or brightness
int switch2;      // toggle col1 or col2 with disk
int switch3;      // toggle potenciometer action (lerp or disk width)
int encoder;      // well... the encoder
int encoderPrev;  // encoder previous value
int diff;         // encoder value and previous value

// soft values
float num;                      // number, obtained through the encoder
float prop;                     // potenciometer
int switchHueBrightness;        // switch1 for size or prop toggle of potenciometer
int switchColor;                // switch2 for color 1 or 2
int switchPotenciometer;        // switch3 for potenciometer
float rot;                      // accumulated rotations
float r1, r2;                   // disk radiuses
color col1, col2;               // two colors
int steps;                      // steps for the disk 
float interpolationProp;        // interpolation proportion
void initVariables() {

  r1 = height * .15;
  r2 = height * .4;

  col1 = #FA0871;
  col2 = #FAC70D;

  num = hue(col1);

  switchHueBrightness = 0;
  switchColor = 0;
  switchPotenciometer = 0;
  rot = 0;
  prop = interpolationProp = .5;

  diff = 0; // init as 0 the values
  steps = 512;
}