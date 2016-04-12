/*

public variables

*/

PFont font;
PFont bold;
float prop;

int num, mult, numInc;
PVector surfaceMouse;
int currentNumber;
color orange, yellow, gray;

int escena;

int permutator, multiplier, multiplierVal; // button values
int yellowDot; // draw the yellow dot?

int pot;       // potenciómetro
int btn1;      // permutador
int btn2;      // incrementador
int btn3;      // yellowDots?
int encoder;   // well... the encoder

int val, valp; // encoder value and previous value

boolean circle;

void initVariables() {
  // initial situation
  num = 10;
  mult = 2;
  
  // mouse standing at 0
  prop = 0;
  
  // not showing the yellow dots
  yellowDot = 0;
  
  // build font
  font = createFont("HelveticaNeue-Thin", 222);
  bold = createFont("HelveticaNeue-Bold", 222);
  
  // init current number (for mouse over)
  currentNumber = -1;
  
  // increment for key toggle. speed up keys 1-3 (1, 10, 100);
  numInc = 1;
  
  // colors 
  orange = color(255, 60, 0);
  yellow = color(255, 222, 0);
  gray = color(255, 200);
  val = valp = 0; // init as 0 the values
  permutator = 0;
  multiplier = 0;
  multiplierVal = 1;
  
  // calibration circle
  circle = false;
  
  escena = 1;
}