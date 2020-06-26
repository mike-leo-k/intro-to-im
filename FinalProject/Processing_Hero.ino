
int red = 2, blue = 3, green = 4, yellow = 5; //Pin numbers of each of the digital sensors (4 buttons)
int strum;  //variable to store the reading of the analog sensor (photoresistor)

int b1, b2, b3, b4; //variables to store the readings of the digital sensors (buttons)
int inByte = 0;        // incoming serial byte


void setup() {
  // start serial port at 9600 bps:
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  pinMode(red, INPUT);
  pinMode(blue, INPUT);
  pinMode(green, INPUT);
  pinMode(yellow, INPUT);
  //establishContact();  // send a byte to establish contact until receiver responds
}

void loop() {
  
  //in case you need to see if the circuit is reading the buttons/photoresistor accurately
    //    strum = analogRead(A0);
    //    strum = map(strum, 0, 1023, 0, 255);
    //    b1 = digitalRead(red);
    //    delay(50);
    //    
    //    b2 = digitalRead(blue);
    //    delay(50);
    //    
    //    b3 = digitalRead(green);
    //    delay(50);
    //    
    //    b4 = digitalRead(yellow);
    //    delay(50);
    //  Serial.println(b1);
    //    Serial.println(b2);
    //    Serial.println(b3);
    //    Serial.println(b4);
    
  // if we get a valid byte, read analog ins:
  if (Serial.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();
    
    strum = analogRead(A0);
    strum = map(strum, 0, 1023, 0, 255);
    
    b1 = digitalRead(red);
    delay(50);
    
    b2 = digitalRead(blue);
    delay(50);
    
    b3 = digitalRead(green);
    delay(50);
    
    b4 = digitalRead(yellow);
    delay(50);
    // the delay(50) is required in order to prevent multiple button presses being detected with one button push

    Serial.write(b1);
    Serial.write(b2);
    Serial.write(b3);
    Serial.write(b4);
    Serial.write(strum);
    
    //writing the five required values into Serial
  }
}

void establishContact() {   //to establish contact for communication with the Processing program
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(300);
  }
}
