/*
  Mike, mlk525
  June 16, 2020
  
  Using information received from an
  analog sensor (potentiometer) and
  a digital sensor (momentary switch)
  to control 4 red LEDs.

  Circuit schematic and documentation available at:
  https://github.com/mike-leo-k/intro-to-im/tree/master/june%2016%20(arduino%20io)
 */

//Using constants here to set pin numbers for the LEDs, button and potentiometer:
const int led1 =  7;
const int led2 =  8;
const int led3 =  9;
const int led4 =  10;

const int button =  2;
const int sensorPin = A0;

//initializing variables that will change:
int ledState = LOW;             // ledState used to set the LED to LOW or HIGH
int sensorValue = 0;            // reads the value from the potentiometer
int buttonState = 0;            //reads the state of the button

void setup() {
  // set the LED pins as output and button pin as input:
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);
  pinMode(led4, OUTPUT);
  pinMode(button, INPUT);
}

void loop() {
  //reading the inputs from the potentiometer and button into respective variables
  sensorValue = analogRead(sensorPin);
  buttonState = digitalRead(button);

  //this loop operates while the button is NOT being pressed
  while (buttonState == LOW) {
    //reading the values at the start of each iteration
    sensorValue = analogRead(sensorPin);
    buttonState = digitalRead(button);

    // if the LED is off turn it on and vice-versa (in order to create an alternating effect):
    ledState = !ledState;

    // set the LED with the ledState variable. here all LEDs are either HIGH or LOW together
    digitalWrite(led1, ledState);
    digitalWrite(led2, ledState);
    digitalWrite(led3, ledState);
    digitalWrite(led4, ledState);
    delay(sensorValue);       //delay period is based on the value read from the potentiometer, changing the speed of the LEDs blinking
  }

  //this loop operates while the button is being pressed continuously
  while (buttonState == HIGH) {
    //reading the inputs at the start of each iteration
    sensorValue = analogRead(sensorPin);
    buttonState = digitalRead(button);

    // if the LED is off turn it on and vice-versa:
    ledState = !ledState;

    // set the LED with the ledState variable, alternating the state of each LED:
    digitalWrite(led1, ledState);
    digitalWrite(led2, !ledState);
    digitalWrite(led3, ledState);
    digitalWrite(led4, !ledState);
    delay(sensorValue);     //alternating delay is once again based on the potentiometer input
  }
}
