/*
  Mike, mlk525
  June 17, 2020

  Program to play the opening riff
  from "Sweet Child O' Mine" by
  Guns N' Roses, using input from
  an ultrasonic sensor to determine
  tempo. A second mode is activated
  by pressing and holding a
  pushbutton, allowing the user to
  generate theremin-like sounds
  with the input from the ultrasonic
  sensor determining the frequency
  of the output tone.

  Circuit Schematic and Documentation available at:
  https://github.com/mike-leo-k/intro-to-im/tree/master/june%2017%20(musical_instrument)
*/

#include "pitches.h"  //including the library matching frequencies to musical notes
const int pingPin = 7; // Trigger Pin of Ultrasonic Sensor
const int echoPin = 6; // Echo Pin of Ultrasonic Sensor
const int button = 2; //  Pin that reads signal from button
const int speaker = 8;  // Pin connected to speaker

int var;  // mapped value of ultrasonic sensor stored in this variable
int melody[] = { NOTE_D4, NOTE_D5, NOTE_A4, NOTE_G4, NOTE_G5, NOTE_A4, NOTE_FS5, NOTE_A4};   //Array containing notes for "Sweet Child O' Mine"

int buttonState = 0;
//unsigned long previousMillis = 0;        //unused variables from attempt to replace the delay() function
//int currentMillis = 0;

void setup() {
  Serial.begin(9600); // Starting Serial Terminal
  //setting the pins to input or output
  pinMode(pingPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(button, INPUT);
  pinMode(speaker, OUTPUT);
}

void loop() {
  buttonState = digitalRead(button);  //checking if the button has been pushed
  if (buttonState == LOW) { //if the button isn't pushed, the circuit will remain in "Sweet Child O' Mine" mode

    for (int thisNote = 0; thisNote < sizeof(melody) / sizeof(melody[0]); thisNote++) {
      //without a .length() method, dividing the size of the array by the size of one element in the array gives the number of elements

      long duration;    //this block of code uses the ultrasonic sensor to send and receive sound pulses in order to gauge distance
      digitalWrite(pingPin, LOW);
      delayMicroseconds(2);
      digitalWrite(pingPin, HIGH);
      delayMicroseconds(10);
      digitalWrite(pingPin, LOW);
      duration = pulseIn(echoPin, HIGH);  //this variable is directly proportional to the distance of anything held in front of the ultrasonic sensor

      //Serial.println(duration);     //this line is present in case troubleshooting the position of the ultrasonic sensor is required

      var = (int)map(duration, 0, 140000, 100, 100000);   //mapping the duration from its expected range to the range of possible note durations
      tone(speaker, melody[thisNote], var);   //generating sounds based on the initialized array of notes for the riff
      buttonState = digitalRead(button);      //checking once again if the button has been pressed
      if (buttonState == HIGH) {
        break;                                //if the button HAS been pressed, the for loop will be exited, allowing the second mode to activate
      }
      // unsigned long currentMillis = millis();     //the commented out lines are a failed attempt to replace the delay for the pause between notes
      int pauseBetweenNotes = var * 1.30;
      // while (currentMillis - previousMillis > pauseBetweenNotes) {
      //   previousMillis = currentMillis;
      //   tone(speaker, 0);
      // }
      delay(pauseBetweenNotes);
      noTone(speaker);

    }
  }


  else {    //activates immediately (or as soon as the code allows, anyway) once the button is pressed and held

    long duration;
    digitalWrite(pingPin, LOW);
    delayMicroseconds(2);
    digitalWrite(pingPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(pingPin, LOW);

    duration = pulseIn(echoPin, HIGH);

    var = (int)map(duration, 100, 140000, 400, 12000);    //here the duration is mapped from its expected range to the desired range of frequencies we'd like produced
    tone(speaker, var);

  }
}
