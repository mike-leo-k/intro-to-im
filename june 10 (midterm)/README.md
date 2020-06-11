# Production Assignment: Jet Fighter Portal

## Description
Inspired by [Jet Fighter](https://en.wikipedia.org/wiki/Jet_Fighter_(video_game)), 2 player arcade game created by Atari, and [Portal](https://en.wikipedia.org/wiki/Portal_(video_game)), a puzzle-platform game created by valve, Jet Fighter Portal combines the dogfight mechanics of Jet Fighter with the teleportation mechanics of Portal. 

In Jet Fighter, the players fly in simulated jets around the screen, engaging in a dogfight and attempting to score hits on their opponent within a limited amount of time. Currently, Jet Fighter Portal only supports one "player", without a clear goal for the game.

<p align="center">
  <img width="500" src="https://upload.wikimedia.org/wikipedia/en/thumb/e/e5/Jet_Fighter_Flyer.png/220px-Jet_Fighter_Flyer.png">
</p>

Controlling the jet and shooting bullets is nearly identical to the style of Jet Fighter, with the addition of being able to speed up the jet as well.

Portal consists primarily of a series of puzzles that must be solved by teleporting the player's character and simple objects using "the Aperture Science Handheld Portal Device", a device that can create inter-spatial portals between two flat planes. 

<p align="center">
  <img width="500" src="https://addons-media.operacdn.com/media/CACHE/images/themes/35/55735/1.0-rev1/images/afa96d78-6c8a-42b6-ac30-6beeb5b81b32/5cfd51ce94227881c2b7a0ad769dfac5.jpg">
</p>

The mechanics of teleportation is emulated in 2D in Jet Fighter Portal, where the jet can both fire and teleport through portals. The bullet fired from the jet can also teleport through the portals. The color and limited number of portals generated is also designed to emulate the game.

The game consists of three screens: the initial screen, which is exited by pressing any keys; the game screen itself where the jet can be operated; and the end screen which displays a final message. The opening and end screen play two different pieces of 8-bit theme music, while the game screen plays sounds when bullets and portals are being fired.


## [Jet Fighter Portal Practice in action](https://github.com/mike-leo-k/intro-to-im/blob/master/june%2010%20(midterm)/pictures/jet%20fighter%20portal.mp4)

### Screen Captures of Game:

<p align="center">
  <br>
  <img width="700" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%2010%20(midterm)/pictures/menuScreen.jpg">
</p>

<p align="center">
  <br>
  <img width="700" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%2010%20(midterm)/pictures/gameScreen.jpg">
</p>

<p align="center">
  <br>
  <img width="700" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%2010%20(midterm)/pictures/endScreen.jpg">
</p>

## Challenges & Discoveries
* For the concept of class creation for objects in games, I built off my owkr on [Pong Practice](https://github.com/mike-leo-k/intro-to-im/tree/master/june%203), while also referring to the source code of a project called [Flappy Pong](https://gist.github.com/oguzgelal/a2a8db8b2da0e864d1d0#file-flappy_pong-pde) to better understand how to control different objects from different classes at once.
* I had a lot of problems getting the jet to turn in the way I wanted it to, with it rotating around an axis outside of itself and not adhering to the screen's edge rules. I remembered that an arcade game called Gran Trak used almost the same mechanics for movement, and I looked up if anyone had recreated it in Processing or Java. After referring to [this tutorial](https://codeheir.com/2019/02/17/how-to-code-gran-trak-10-1974-3/), I was able to make a [simple rectangle move and rotate in the intended style](https://github.com/mike-leo-k/intro-to-im/blob/master/june%2010%20(midterm)/jet_fighter%20v1.pde). I finally was able to use an image of the jet by cropping it to a square, and changing the coordinates it was positioned to post-transformation. The tutorials [on Processing.org](https://processing.org/tutorials/transform2d/) also helped understand the correct order of transformations immensely.
* I had issues with play the sound files for the menu screen and end screen, where the same sound file would overlap itself several times. I also thought the red text printed as a report ("INFO: JSyn: default output latency set to 80 msec for Windows 10") signified an error. After looking up the issue [here](https://discourse.processing.org/t/hello-all-i-have-problem-with-a-sound/3492) and [here](https://discourse.processing.org/t/processing-sound-library-doesnt-work/4928/10), I realized the red text was simply an information output, and the issue with the sound was caused by it being played on a loop. I moved the respective sound files into the setup() function qnd conditional if-else statements and the problem was fixed.
