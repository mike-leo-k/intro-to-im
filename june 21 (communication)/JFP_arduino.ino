/*
  Mike, mlk525
  June 21, 2020
  
  Code for Arduino controls of
  Jet Fighter Portal.
  
  Controls include:
  1 Potentiometer
  2 Buttons (red and blue)
  
  Schematic and associated Processing code available at:
  https://github.com/mike-leo-k/intro-to-im/tree/master/june%2021%20(communication)
  
  Code directly adapted from the 'Serial Call and Response' 
  example provided with Arduino software:
  http://www.arduino.cc/en/Tutorial/SerialCallResponse
*/

int poten = A0;    // analog sensor (potentiometer)
int blue = 2;   // first digital sensor (blue button)
int red = 4;    // second digital sensor (red button)

int turning = 0;    //intializing variables that will store the readings from the above sensors
int portal = 0;     //variable names based on associated controls in the JFP Processing program
int bullet = 0;
int inByte = 0;         // incoming serial byte


void setup() {
  // start serial port at 9600 bps:
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  pinMode(blue, INPUT);   // blue button is on digital pin 2
  pinMode(red, INPUT);   // red button is on digital pin 4
  establishContact();  // send a byte to establish contact until receiver responds
}

void loop() {
  // if we get a valid byte, read analog ins:
  if (Serial.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();

    turning = analogRead(poten);  //read the value from potentiometer into 'turning'
    turning = map(turning, 0, 1023, 0, 255);  //mapping is required as a byte is only 8 bits and can only count up to 255
    // delay 10ms to let the ADC recover:
    delay(10);
 
    portal = digitalRead(blue);   //read value from blue button into 'portal'
    delay(50);
    
    bullet = digitalRead(red);    //read value from red button into 'bullet'
    delay(50);
    // the delay(50) is required in order to prevent multiple portals/bullets being fired with one button push

    Serial.write(turning);
    Serial.write(portal);
    Serial.write(bullet);     //writing the three required values into Serial
  }
}

void establishContact() {   //to establish contact for communication with the Processing program
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(300);
  }
}
