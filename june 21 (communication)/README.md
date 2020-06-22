# Production Assignment: Game with Arduino-Processing communication

## Description
Having worked on a prototype arcade game for my midterm project already, I decided to incorporate physical controls into the game using Arduino.  
<p align="center">
  <img width="500" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%2021%20(communication)/two-player.png">
</p>

I envisioned two buttons, one each for firing bullets and portals, and a 2-way joystick. Unfortunately, I had to settle for a slightly unwieldy potentiometer. Pong used potentiometers to control the two paddles, so I guess I was in good company.

Using an example of Arduino + Processing integration from [instructables](https://www.instructables.com/id/Pong-With-Processing/) (the game in the example was Pong), I was able to adapt the code to fit my purposes. Two buttons controlled the jet's shooting of portals and bullets (respectively), while the potentiometer controlled the jet's turning.

### Circuit Schematic:

<p align="center">
  <br>
  <img width="500" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%2021%20(communication)/JFP_schem.png">
</p>

### Project Photographs:

<p align="center">
  <br>
  <img width="500" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%2021%20(communication)/controls.jpg">
</p>

## Challenges & Discoveries
* The buttons worked, but were intially activating multiple bullets/portals after a single press. This was because there was no delay, and the high state of the button was being communicated to the processing program multiple times a second even after one press. This was easily remedied by adding a 50 millisecond delay to the Arduino program after each button's state was read.

* The potentiometer value was being read by the Arduino in the range of 0 to 1023, while in Processing, the value cycled from 0 to 255 four times. This made it really hard to accurately control the jet. THis issue was solved by mapping the values to the range 0 to 255 in the Arduino code before communicating it to Processing. As explained by Professor Shiloh, sending a byte from Arduino to Processing means you are only sending 8 bits and can only send values up to 255. So you can't send a number greater than 255 if you write bytes.
