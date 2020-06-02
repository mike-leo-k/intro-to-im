# Production Assignment: Pong Practice

## Description
Inspired by [Pong](https://en.wikipedia.org/wiki/Pong), one of the earliest video games created, Pong Practice is a simple one person video game intended to allow the play to "practice" Pong. Instead of two paddles, there is only paddle to the right of the screen, and the objective is to prevent a bouncing ball from touching the right edge. Pong Practice emulates practicing tennis/table tennis/lacrosse shots against a wall.

The code that runs the game uses object-oriented programming to define the paddle and the ball as objects, as well as defining the various functions that can be applied to them.

## Screen Captures of Game:

### Pong Practice in action
![GIF of the game being played](h)

### Still of the Game Over screen.
![Screenshot of end screen](h)



## Challenges/Discoveries
* Figuring out how to navigate between three separate screens (I envisioned the game to have a start screen and a game over screen in addition to actual gameplay) was challenging, until I settled on checking a variable for one three values in an if-else chain in void main().
* Because I wanted to use the up and down arrow keys, the keyPressed() function wouldn't work. I learned you could use keyCode instead.
