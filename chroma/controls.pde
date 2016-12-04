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
      switch1 = serialInArray[1];
      switch2 = serialInArray[2];
      switch3 = serialInArray[3];
      encoder = serialInArray[4];
      
      // printSerial();

      // Send a capital A to request new sensor readings:
      myPort.write('A');
      // Reset serialCount:
      serialCount = 0;
    }
  }
  
  // update values
  switchHueBrightness = switch1;
  switchColor = switch2;
  switchPotenciometer = switch3;
  prop = map(pot, 0, 255, 0, 1);

  diff = (encoder - encoderPrev) * 3;
  // println(diff);
  // girando 
  if(diff > 200){
  encoder = encoderPrev;
  diff = - 5;
  }
  
  if(diff < -200){
  encoder = encoderPrev;
  diff = 5;
  }

  updateColors(diff);
  updateDisk();
  encoderPrev = encoder;
}