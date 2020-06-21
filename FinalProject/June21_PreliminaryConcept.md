# Preliminary Concept: Guitar Hero with Processing + Arduino

## Description
<p align="center">
  <br>
  <img width="600" src="https://ip.trueachievements.com/remote/download.xbox.com/content/images/66acd000-77fe-1000-9115-d802415607f7/1033/screenlg13.jpg">
</p>

My final project will mimic the classic arcade game Guitar Hero's interface using Processing, while incorporating a mini guitar-shaped controller using Arduino. I'll probably settle for four buttons rather than five, and limit the playing modes to 'Easy' and 'Medium' (harder modes require five buttons).

The general idea is to press the buttons correlated to the notes as they reach the bottom of the screen. In the original game, there is a strumming bar which needs to be used in tandem with the buttons. I'll do my best to figure it out but I might settle for coordinating the buttons alone.
<p align="center">
  <img width="700" src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Guitar-hero-controller-horiz.jpg/1200px-Guitar-hero-controller-horiz.jpg">
</p>

I'm thinking I'll be able to chart songs (code the falling notes) by entering data into a CSV file, with four columns for each button.

If I'm not able to figure out how to make this work, I'll just develop my midterm project (Jet Fighter Portal) further, which I've already incorporated Arduino controls into. I'm thinking of maybe coding an enemy jet for a single-player mode, and building a second set of controls for two-player mode. 
<p align="center">
  <img width="700" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%2010%20(midterm)/pictures/two-player.png">
</p>

Since the jets in the game are defined as objects in the Jet class, I was able to create a simple two-player mode already.
