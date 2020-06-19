# Production Assignment: Sweet Theremin O' Mine

## Description
<p align="center">
  <br>
  <img width="500" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%2017%20(musical_instrument)/pictures/final.jpg">
</p>

Initially intended to be simply mimic the frequency modulation of a theremin, I decided to incorporate two modes into the device, switching between them using a push button. The default mode would play the opening riff of Guns N' Roses' "Sweet Child O' Mine", while the second mode converts the device to a simple theremin.

<p align="center">
  <img width="400" src="https://img.discogs.com/rrd2FbYcZaVd5TlXZRZ3_haoLUU=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-1913754-1263136501.jpeg.jpg">
</p>

The tempo of the riff is controlled by input from the ultrasonic sensor.

<p align="center">
  <img width="500" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%2017%20(musical_instrument)/pictures/ultrasonic.jpg">
</p>

The method through which the ultrasonic sensor determines the distance between itself and whatever object is placed in front of it is explained in the [code comments](https://github.com/mike-leo-k/intro-to-im/blob/master/june%2017%20(musical_instrument)/sweet_theremin_o_mine.ino) and on [the Arduino reference website](https://www.tutorialspoint.com/arduino/arduino_ultrasonic_sensor.htm).

The map() function was the primary method to make the tempo of the riff (in the first mode) and the frequency of the tone (in the second mode) directly proportional to the distance measured by the ultrasonic sensor. The push button must be pressed and held to remain in Theremin mode.

<p align="center">
  <img width="500" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%2017%20(musical_instrument)/pictures/circuit.jpg">
</p>

## Circuit Schematic:
<p align="center">
  <br>
  <img width="700" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%2017%20(musical_instrument)/pictures/circuit_schem.png">
</p>

## ["Sweet Theremin O' Mine" in action](https://github.com/mike-leo-k/intro-to-im/blob/master/june%2017%20(musical_instrument)/pictures/Sweet%20Theremin%20O'%20Mine.mp4)


## Challenges & Discoveries
* The buzzer provided with the kit was adequate, but I wasn't happy with its volume capacity. Since I had an old pair of cheap headphones lying around, I decided to take it apart and use its inbuilt speakers.
<p align="center">
  <br>
  <img width="500" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%2017%20(musical_instrument)/pictures/speaker_.jpg">
</p>

Figuring out how to use it was fairly straightforward, but making a strong connection with its fibre-like wires was incredibly difficult. If I manage to get my hands on a soldering iron, making the connection will be much easier.

* Coding the notes for the opening riff was a little challenging, but once I found [sheet music](https://www.musicnotes.com/sheetmusic/mtd.asp?ppn=MN0087180) and made use of the note frequencies in the "pitches.h" library, it was much easier.

* Exiting the for() loop in the riff mode if the button was pressed required the use of the [break](https://www.arduino.cc/reference/en/language/structure/control-structure/break/) function, which I hadn't used in an Arduino program previously. Didn't prove to be too difficult though.

* I tried to switch out the delay() function in the section of code for pausing between notes, using the millis() function from the BlinkWithoutDelay code example. I was unable to functionally replace the delay() function, but I did leave the remnants of my attempt as comments within the final code for future reference.
