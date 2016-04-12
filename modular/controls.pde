/*

 Arduino controls
 
 */


void serialEvent(Serial myPort) {
  int inByte = myPort.read();
  if (firstContact == false) {
    if (inByte == 'A') {
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    }
  } else {
    // Add the latest byte from the serial port to array:
    serialInArray[serialCount] = inByte;
    serialCount++;

    // If we have 3 bytes:
    if (serialCount > 4 ) {
      pot = serialInArray[0];
      btn1 = serialInArray[1];
      btn2 = serialInArray[2];
      btn3 = serialInArray[3];
      encoder = serialInArray[4];

      // print the values (for debugging purposes only):
      println(pot + "\t" + btn1 + "\t" + btn2 + "\t" + btn3+ "\t" + encoder);

      // Send a capital A to request new sensor readings:
      myPort.write('A');
      // Reset serialCount:
      serialCount = 0;
    }
  }

  // encoder
  valp = encoder;
  int diff = val - valp;
  // println("diff = "+diff+"\tval = "+val+"\tvalp = "+valp);
  if (diff >= 1  || (diff <= 255 && diff > 0)) {
    switch(permutator) {
    case 0:
      num -= multiplierVal;
      break;
    case 1:
      mult -= multiplierVal;
      break;
    }
  } else if (diff <= -1 || diff >= 255) {
    switch(permutator) {
    case 0:
      num += multiplierVal;
      break;
    case 1:
      mult += multiplierVal;
      break;
    }
  }

  num = constrain(num, 1, 99999);
  val = encoder;

  // buttons
  permutator = btn1;
  multiplier = btn2;
  yellowDot = btn3;

  if (escena == 1) {
    switch(multiplier) {
    case 0:
      multiplierVal = 1;
      break;
    case 1:
      multiplierVal = 10;
      break;
    }
  }
  prop = map(pot, 0, 255, -.126, 1.126);
}