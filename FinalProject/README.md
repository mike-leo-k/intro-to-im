# Final Project: Processing Hero

<p align="center">
  <img width="700" src="https://github.com/mike-leo-k/intro-to-im/blob/master/FinalProject/pictures/screencap.png">
</p>

## Description
Processing Hero is a clone of the popular music rhythm video game series [*Guitar Hero*](https://en.wikipedia.org/wiki/Guitar_Hero). It is designed to emulate as much of the gameplay and aesthetic of the original game through the Java-based software sketchbook [Processing](https://processing.org) combined with the open-source physical computing prototyping platform [Arduino](https://arduino.cc).

Two prototypes of the game were designed, in order to explore different priorities in gameplay. The shared characteristics included the visuals, which were 3-dimensional falling notes of four colors on four strings as pictured above. The 3D transformations were achieved by calling the [P3D render mode](https://processing.org/tutorials/p3d/) in setup.

<p align="center">
  <img width="600" src="https://ip.trueachievements.com/remote/download.xbox.com/content/images/66acd000-77fe-1000-9115-d802415607f7/1033/screenlg13.jpg">
</p>

The [first prototype](https://github.com/mike-leo-k/intro-to-im/blob/master/FinalProject/random_streak_hero.pde) adapted code from an [Open Processing project](https://www.openprocessing.org/sketch/218416/), which randomly generated notes across four strings. The primary functions taken from this were the scoring mechanism and the streak counter. The visuals were coded through trial-and-error within the P3D render mode, using the visuals from the original game (above) as reference.

The [second version](https://github.com/mike-leo-k/intro-to-im/blob/master/FinalProject/tab_reading_hero.pde) was created to be able to read text files containing bass guitar notes in [tablature](https://en.wikipedia.org/wiki/Tablature) form. The algorithm for generating a grid based on the tablature was adapted from [this GitHub repository](https://github.com/Introscopia/OurGuitarHero/tree/Introscopia's_take). The visuals were heavily modified, using those developed during the development of the first prototype.

The final iteration combined these two prototypes, while also adding a [video background](https://www.youtube.com/watch?v=DJ8wEDEYkZI), and a short animation of a flame each time a note was hit.

The controls of the game are fairly simple: on keyboard, you press the keys '1' through '4' corresponding to the string a note is sliding down. On the physical Arduino prototype controller, in addition to four buttons (colored according to each string's notes) I added a photoresistor that detects when the user's thumb is covering it. This is the emulate the strumming action from the original game. While the arcade game control used a physical strum bar, I decided to employ a photoresistor to emulate the action of [slapping](https://en.wikipedia.org/wiki/Slapping_(music)) the strings of a bass guitar. Much like an actual guitar, the buttons (or notes) must be pressed at the same time as the photoresistor is covered (or "slapped") in order for the note to be played. 

### Circuit Schematic:

<p align="center">
  <br>
  <img width="500" src="https://github.com/mike-leo-k/intro-to-im/blob/master/FinalProject/pictures/circuit_schem.png">
</p>

### Project Controls:

<p align="center">
  <br>
  <img width="500" src="https://github.com/mike-leo-k/intro-to-im/blob/master/FinalProject/pictures/controls.jpg">
</p>

## Challenges & Discoveries
* Figuring out how to render the game in 3D was quite difficult, but finding a [comprehensive tutorial](https://medium.com/@behreajj/3d-transformations-in-processing-de11acdd1fbc) along with the [P3D](https://processing.org/tutorials/p3d/) reference page was extremely useful. I able able to achieve the desired level of rotation around the X-axis and translation along the Z=axis through trial and error.
* Figuring out how to play videos or even short animations was very challenging. Experimenting with the [Animated Sprite](https://processing.org/examples/animatedsprite.html) class from Processing was largely unsuccessful. In fact, I wasn't able to find a solution to displaying video or animation until our final presentations, where my classmate Muhammad (whose repository is [here](https://github.com/MuhammadBinNauman/Intro-to-IM)) explained how he used the [Movie](https://processing.org/reference/libraries/video/Movie.html) class from the Processing Video library. The reference page made it even easier to implement.
* I used websites that converted sheet music to tablature for bass guitars, primarily using [Big Bass Tabs](https://www.bigbasstabs.com/) for its conveniently formatted tabs:

G|—————7———9—————————7———9———X—————|———-—7———9—————————7———9———X—————|
D|—————————————————————————————————|—————————————————————————————————|
A|—7———————————7———7———X———X———7———|—5———————————5———5———X———X———————|
E|—————————————————————————————————|—————————————————————————————5———|
