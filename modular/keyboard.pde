/*

 keyboard input
 
 
 mapping:
 
 c: calibrate mapping
 l: load layout
 S: save layout
 
 modular mod:
 a: number ++
 z: number --
 
 s: multiplier ++
 x: multiplier --
 
 1: increase number or multiplier by 1
 2: increase number or multiplier by 10
 3: increase number or multiplier by 100
 
 */

void checkKeyboard() {
  if (key == 'a') {
    num += numInc;
  }
  if (key == 'z') {
    num -= numInc;
  }
  num = constrain(num, 1, 15000);
}

void keyPressed() {
  switch(key) {
  case 'c':
    ks.toggleCalibration();
    break;

  case 'l':
    ks.load();
    break;

  case 'S':
    ks.save();
    break;

  case 's':
    mult += numInc;
    break;

  case 'x':
    mult -= numInc;
    break;

  case '1':
    numInc = 1;
    break;

  case '2':
    numInc = 10;
    break;

  case '3':
    numInc = 100;
    break;

  case '.':
    circle = !circle;
    break;

  case 'p':
    permutator ++;
    permutator %= 2;
    break;

  case 'o':
    multiplier ++;
    multiplier %= 2;
    break;

  case ' ':
    if (yellowDot == 1) yellowDot = 0;
    if (yellowDot == 0) yellowDot = 1;
    break;

  case 'r':
    num = 10;
    mult = 2;
    break;

  case 'i':
    saveFrame("img/########.png");
    break;

  case 'e':
    escena ++;
    escena %= 2;

    if (escena == 1) {
      num = 2;
      mult = 7;
      multiplierVal = 1;
    }
    break;
  }
  switch(multiplier) {
  case 0:
    multiplierVal = 1;
    break;
  case 1:
    multiplierVal = 10;
    break;
  }
}