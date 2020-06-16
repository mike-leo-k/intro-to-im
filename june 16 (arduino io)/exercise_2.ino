/*
 In class exercise:
 Use one of the analog sensor to control how fast two LEDs alternate.
 */
int sensorPin = A0;    // select the input pin for the potentiometer
int redLED = 7;
int bluLED = 10;  // select the pin for the LEDs
int sensorValue = 0;  // variable to store the value coming from the potentiometer

void setup() {
  // declare the LED pins as OUTPUTs:
  pinMode(bluLED, OUTPUT);
  pinMode(redLED, OUTPUT);
}

void loop() {
  // read the value from the sensor:
  sensorValue = analogRead(sensorPin);

    digitalWrite(redLED, HIGH);
    digitalWrite(bluLED, LOW);
    delay(sensorValue);         //change the time interval of the alternating lights based on the reading from the potentiometer
    digitalWrite(bluLED, HIGH);
    digitalWrite(redLED, LOW);
    delay(sensorValue);

}
