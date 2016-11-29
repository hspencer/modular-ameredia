// http://www.arduino.cc/en/Tutorial/SerialCallResponse
// http://bildr.org/2012/08/rotary-encoder-arduino/
// Amereida Modular
// Taller de Diseño de Interacción e[ad] 2016 - Spencer + Garretón


#include <SoftwareSerial.h>

int perilla1 = 0;       // first analog sensor
int boton1 = 0;         // second analog sensor
int boton2 = 0;
int boton3 = 0;         // digital sensor
int inByte = 0;         // incoming serial byte

//Encoder//
int encoderPin1 = 2;
int encoderPin2 = 3;
int encoderVal = 0;
volatile int lastEncoded = 0;
volatile long encoderValue = 0;
long lastencoderValue = 0;
int lastMSB = 0;
int lastLSB = 0;

//Bluetooth//
int bluetoothTx = 0;  // TX-O pin of bluetooth mate, Arduino D2
int bluetoothRx = 1;  // RX-I pin of bluetooth mate, Arduino D3
boolean sendData = true;
SoftwareSerial bluetooth(bluetoothTx, bluetoothRx);


void setup() {
  // start serial port at 9600 bps:
  Serial.begin(9600);

  //Bluetooth//
  bluetooth.begin(115200);  // The Bluetooth Mate defaults to 115200bps
  bluetooth.print("$$$");  // Enter command mode
  delay(100);  // Short delay, wait for the Mate to send back CMD
  bluetooth.println("U,9600,N");  // Temporarily Change the baudrate to 9600, no parity
  // 115200 can be too fast at times for NewSoftSerial to relay the data reliably
  bluetooth.begin(9600);  // Start bluetooth serial at 9600


  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  pinMode(5, INPUT);        //Botones con su pull up set
  digitalWrite(5, HIGH);
  pinMode(6, INPUT);
  digitalWrite(6, HIGH);
  pinMode(9, INPUT);
  digitalWrite(9, HIGH);    //Botones con su pull up set

  establishContact();  // send a byte to establish contact until receiver responds

  //Encoder//
  pinMode(encoderPin1, INPUT);
  pinMode(encoderPin2, INPUT);
  digitalWrite(encoderPin1, HIGH); //turn pullup resistor on
  digitalWrite(encoderPin2, HIGH); //turn pullup resistor on
  attachInterrupt(0, updateEncoder, CHANGE);
  attachInterrupt(1, updateEncoder, CHANGE);
}

void loop() {


  // if we get a valid byte, read analog ins:
  if (bluetooth.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();

    perilla1 = analogRead(A0) / 4;

    delay(10);

    boton1 = round(map(digitalRead(5), 0, 1, 0, 1));
    boton2 = round(map(digitalRead(6), 0, 1, 0, 1));
    boton3 = round(map(digitalRead(9), 0, 1, 0, 1));

    // send sensor values:
    Serial.write(perilla1);
    Serial.write(boton1);
    Serial.write(boton2);
    Serial.write(boton3);
    Serial.write(lastEncoded); // Serial.write(encoderValue);
    delay(10);
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(300);
  }
}

//Encoder//
void updateEncoder() {
  int MSB = digitalRead(encoderPin1); // MSB = most significant bit
  int LSB = digitalRead(encoderPin2); // LSB = least significant bit

  int encoded = (MSB << 1) | LSB; // converting the 2 pin value to single number
  int sum  = (lastEncoded << 2) | encoded; // adding it to the previous encoded value

  if (sum == 0b1101 || sum == 0b0100 || sum == 0b0010 || sum == 0b1011) {
    encoderValue ++;
    encoderVal = 1;
  }
  else if (sum == 0b1110 || sum == 0b0111 || sum == 0b0001 || sum == 0b1000) {
    encoderValue --;
    encoderVal = -1;
  } else {
    encoderVal = 0;
  }
  lastEncoded = encoded; //store this value for next time
}


/*

  //Processing sketch to run with this example:

  // This example code is in the public domain.

  import processing.serial.*;

  int bgcolor;                 // Background color
  int fgcolor;
  int fgcolor2;
  int fgcolor3;
  Serial myPort;                       // The serial port
  int[] serialInArray = new int[5];    // Where we'll put what we receive
  int serialCount = 0;                 // A count of how many bytes we receive
  int xpos, ypos;                  // Starting position of the ball
  boolean firstContact = false;        // Whether we've heard from the microcontroller

  void setup() {
  size(256, 256);  // Stage size
  noStroke();      // No border on the next thing drawn

  // Set the starting position of the ball (middle of the stage)
  xpos = width/2;
  ypos = height/2;

  // Print a list of the serial ports for debugging purposes
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);
  }

  void draw() {
  background(bgcolor);
  fill(fgcolor);
  // Draw the shape
  ellipse(xpos, ypos, 20, 20);
  }

  void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  int inByte = myPort.read();
  // if this is the first byte received, and it's an A,
  // clear the serial buffer and note that you've
  // had first contact from the microcontroller.
  // Otherwise, add the incoming byte to the array:
  if (firstContact == false) {
    if (inByte == 'A') {
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    }
  }
  else {
    // Add the latest byte from the serial port to array:
    serialInArray[serialCount] = inByte;
    serialCount++;

    // If we have 3 bytes:
    if (serialCount > 4 ) {
      xpos = serialInArray[0]; //Potenciometro 1
      ypos = serialInArray[1]; // Boton 1
      fgcolor = serialInArray[2]; // Boton 2
      fgcolor2 = serialInArray[3]; // Boton 3
      fgcolor3 = serialInArray[4]; // Encoder hasta 255

      // print the values (for debugging purposes only):
      println(xpos + "\t" + ypos + "\t" + fgcolor + "\t" + fgcolor2+ "\t" + fgcolor3);

      // Send a capital A to request new sensor readings:
      myPort.write('A');
      // Reset serialCount:
      serialCount = 0;
    }
  }
  }
*/



