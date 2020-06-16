/*
 In class exercise:
 Use one of the analog sensors to select which of two LEDs lights up.
 */
int sensorPin = A0;    // select the input pin for the potentiometer
int redLED = 7;
int bluLED = 10;  // select the pin for the LEDs
int sensorValue = 0;  // variable to store the value coming from the potentiometer

void setup() {
  // declare the ledPin as an OUTPUT:
  pinMode(bluLED, OUTPUT);
  pinMode(redLED, OUTPUT);
}

void loop() {
  // read the value from the potentiometer:
  sensorValue = analogRead(sensorPin);

  if (sensorValue <= 510) { //alternating which LED is lit based on which way the potentiometer dial is rotated
    // turn the ledPin on
    digitalWrite(redLED, HIGH);
    digitalWrite(bluLED, LOW);
  }

  else {
    digitalWrite(bluLED, HIGH);
    digitalWrite(redLED, LOW);
  }

}
