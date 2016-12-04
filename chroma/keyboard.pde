/*

 keyboard input
 
 mapping:
 
 c: calibrate mapping
 l: load layout
 S: save layout
 
 modular mod:
 a: number ++
 z: number --
 
 s: prop ++
 x: prop --
 
 */

void checkKeyboard() {
  if (key == 'a') {
    diff = 1;
    updateColors(diff);
  }
  if (key == 'z') {
    diff = -1;
    updateColors(diff);
  }
  if (key == 's') {
    prop += .025;
    updateDisk();
  }
  if (key == 'x') {
    prop -= .025;
    updateDisk();
  }

  prop = constrain(prop, 0, 1);
}

void keyPressed() {
  switch(key) {
  case '1':
    switchHueBrightness++;
    switchHueBrightness%=2;
    println("switchHueBrightness = " + switchHueBrightness);
    break;

  case '2':
    switchColor++;
    switchColor%=2;
    println("switchColor = " + switchColor);
    break;

  case '3':
    switchPotenciometer++;
    switchPotenciometer%=2;
    println("switchPotenciometer = " + switchPotenciometer);
    break;

  case 'c':
    ks.toggleCalibration();
    break;

  case 'l':
    ks.load();
    break;

  case 'S':
    ks.save();
    break;

  case 'i':
    saveFrame("img/########.png");
    break;
  }
}