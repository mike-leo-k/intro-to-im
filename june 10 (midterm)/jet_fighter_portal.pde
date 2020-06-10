/*
Mike, mlk525
June 10, 2020

Code for 'Jet Fighter Portal'

Inspired by the "Jet Fighter" arcade game
and the puzzle-platform game "Portal"

Rotation controls and movement adapted from:
https://codeheir.com/2019/02/17/how-to-code-gran-trak-10-1974-3/

Class and object creation adapted from:
https://www.openprocessing.org/sketch/48960

Game screen navigation and control style adapted from:
https://gist.github.com/oguzgelal/a2a8db8b2da0e864d1d0

Portal mechanics are entirely original code.
Yes, I'm very proud. Yes, you may compliment the portal mechanics.

CONTROLS:
  LEFT and RIGHT arrow keys for turning the jet left and right
  UP arrow key to speed up the jet
  SPACEBAR to fire bullets
  W to fire portals

This iteration has no specific objective.
The game ends after 42 bullets are fired.
You can fire bullets and fly through portals,
teleporting to the location of the second portal.
*/

int foo = 0;  //for lack of a better name, foo is the variable that controls how new bullets are added to the Bullet array
int fired = 0, ports = 0;  //fired counts the number of bullets fired, and ports counts the number of portals fired

PImage jet_pic;  //initializing the PImage variables for all the images to be used
PImage menu_bg;
PImage game_bg;

Table table;    //initializing the Table object and the String array into which the words from random.csv get loaded
String[] random;

PFont font;    //initializing the variable name for the font we will create
int gameScreen = 0;  //setting the gameScreen to 0, meaning the opening menu will display

int portal_height = 60;  //setting portal dimensions as global variables so they can be called anywhere
int portal_width = 10;

Jet jet;        //creating global objects of each class that will be used in the game
Bullet bullets[];
Bullet bullet;
Portal portals[];

import processing.sound.*;  //importing the processing Sound library and initializing the variables for required sound files
SoundFile theme;
SoundFile shot;
SoundFile portal;
SoundFile end;

/**************************************************************************************************************/
/*                                            JET CLASS                                                       */
/**************************************************************************************************************/

class Jet {      //defining the Jet class
  float xPos, yPos;
  float jet_speed;
  float jet_angle;
  float steer;      //this variable is controlled by the user
  PImage jet_image;

  Jet(PImage image) {    //Constructor declaration
    xPos = random(width);    //randomly generates the jet within the screen
    yPos = random(height);
    jet_image = image;
    jet_speed = 1;
    jet_angle = 0;
  }

  void maintainDirection() {    //ensures the jet travels in the direction it is facing using trigonometry
    xPos += (jet_speed * cos(jet_angle));
    yPos += (jet_speed * sin(jet_angle));
  }

  void stayInScreen() {    //this method polices the jet's movement near the screen's edge
  
  // first we check if the jet is within the x OR y coordinates of either portal (there are only two portals, portals[0] and portals[1])
  // then, we check if the jet is try to go beyond the bounds of the screen WHILE in the vicinity of either portal
  // then we ensure the portal is on the same side that the jet is trying to pass, in which case we "teleport" the jet
  // changing the value of the jet's coordinates to the value of the other portal's coordinates
  // also change the value of the angle of the jet, by calling the portals' num variable (see below for more details).
    if ((xPos > portals[0].xTemp - portal_height/2) && (xPos < portals[0].xTemp + portal_height/2)) {
      if ((yPos < - jet_image.width/2) && (portals[0].yTemp == 0)) {
        xPos = portals[1].xTemp;
        yPos = portals[1].yTemp;
        jet_angle = portals[1].num;
      } else if ((yPos > height) && (portals[0].yTemp == height)) {
        xPos = portals[1].xTemp;
        yPos = portals[1].yTemp;
        jet_angle = portals[1].num;
      }
    } else if ((xPos > portals[1].xTemp - portal_height/2) && (xPos < portals[1].xTemp + portal_height/2)) {
      if ((yPos < - jet_image.width/2) && (portals[1].yTemp == 0)) {
        xPos = portals[0].xTemp;
        yPos = portals[0].yTemp;
        jet_angle = portals[0].num;
      } else if ((yPos > height) && (portals[1].yTemp == height)) {
        xPos = portals[0].xTemp;
        yPos = portals[0].yTemp;
        jet_angle = portals[0].num;
      }
    } else if ((yPos > portals[0].yTemp - portal_height/2) && (yPos < portals[0].yTemp + portal_height/2)) {
      if ((xPos < - jet_image.height/2) && (portals[0].xTemp == 0)) {
        xPos = portals[1].xTemp;
        yPos = portals[1].yTemp;
        jet_angle = portals[1].num;
      } else if ((xPos > width) && (portals[0].xTemp == width)) {
        xPos = portals[1].xTemp;
        yPos = portals[1].yTemp;
        jet_angle = portals[1].num;
      }
    } else if ((yPos > portals[1].yTemp - portal_height/2) && (yPos < portals[1].yTemp + portal_height/2)) {
      if ((xPos < - jet_image.height/2) && (portals[1].xTemp == 0)) {
        xPos = portals[0].xTemp;
        yPos = portals[0].yTemp;
        jet_angle = portals[0].num;
      } else if ((xPos > width) && (portals[1].xTemp == width)) {
        xPos = portals[0].xTemp;
        yPos = portals[0].yTemp;
        jet_angle = portals[0].num;
      }
    } 
    
    //if the jet isn't near any portal, the following code blocks it from going off the screen
    else {
      if (xPos - jet_image.height/2 < 0) {
        xPos = jet_image.height/2;
      } else if (xPos + jet_image.height/2 > width) {
        xPos = width-jet_image.height/2;
      }

      if (yPos - jet_image.width/2 < 0) {
        yPos = jet_image.width/2;
      } else if (yPos + jet_image.width/2 > height) {
        yPos = height-jet_image.width/2;
      }
    }
  }


  void move() {  //in addition to calling the methods to move in the direction the jet is facing and follow the screen's edge rules, this method changes the direction of the jet
    maintainDirection();
    stayInScreen();

    jet_angle += steer;  //steer is controlled by the user with the arrow keys
  }

  void shoot() {  //this method is called when the user presses the SPACEBAR
    bullet = new Bullet(xPos, yPos, jet_angle);  //creating a new Bullet object with values from the CURRENT state of the jet
    if (foo <= bullets.length - 1) {  //this if-else chain ensures the bullets are added appropriately to the bullets[] array, essentially preventing a NullPointerException
      bullets[(bullets.length - 1) - foo] = bullet;
    } else {
      foo = 0;    //foo ensures the bullets occupy the bullet array starting from the last element
      bullets[(bullets.length - 1) - foo] = bullet;
    }
    foo++;
    fired++;  //the fired variable increments at every shot, giving us the total number of shots fired
  }

  void displayBullets() {  //this method draws the bullets by calling the methods from the Bullet class
    for (int i = bullets.length - 1; i >= 0; i--) {  //the bullets are called in backward order because they are added to the array in backward order
      bullets[i].move();
      bullets[i].display();

      if (bullets[i].timeAlive > 300) {  //this if statement makes "spent" bullets disappear, by checking the measure of how long they have been in motion
        bullets[i].xTemp = -10;
        bullets[i].yTemp = -10;
        bullets[i].bullet_speed = 0;
      }
    }
  }

  void shootPortals() {  //this method is called when the user presses 'W', to shoot portals
    if (ports % 2 == 0) {  //shoots blue and orange portals alternately, calling old portals as new ones to ensure only one blue and one orange portal exist at any given time after both are fired once
      portals[0] = new Portal(xPos, yPos, jet_angle, 1);  //in addition to current values concerning the jet's position, 0 or 1 indicates whether the portal is blue or not
    } else {
      portals[1] = new Portal(xPos, yPos, jet_angle, 0);
    }
  }

  void displayPortals() {  //calls the move() method from the Portal class for each of the two portals (see below)
    for (int i = 0; i < 2; i++) {
      portals[i].move();
    }
  }

  void display() {  //finally, this method draws the jet on screen
    push();  
    translate(xPos, yPos);  //transformations necessary to turn the jet without changing its position relative to itself
    rotate(jet_angle);      //see https://processing.org/tutorials/transform2d/
    image(jet_image, 0, 0, 30, 30); 
    pop();

    displayBullets();
    displayPortals();
  }
}

/**************************************************************************************************************/
/*                                         BULLET CLASS                                                       */
/**************************************************************************************************************/

class Bullet {      //defining the Bullet class
  float xTemp, yTemp;
  float bullet_speed;
  float bullet_angle;
  int diameter;
  int timeAlive;

  Bullet(float xPos, float yPos, float jet_angle) {    //Constructor declaration
    xTemp = xPos;
    yTemp = yPos;
    diameter = 8;
    bullet_speed = 2;
    bullet_angle = jet_angle;
    timeAlive = 0;    //intializing time alive to zero, to indicate the bullet has just come into existence
  }

  void goThroughPortal() {
    //portal stuff, almost identical to the portal rules for the jet
    //wont make sense if the jet can go through portals but the bullets can't right?
    if ((xTemp > portals[0].xTemp - portal_height/2) && (xTemp < portals[0].xTemp + portal_height/2)) {
      if ((yTemp < - diameter) && (portals[0].yTemp == 0)) {
        xTemp = portals[1].xTemp;
        yTemp = portals[1].yTemp;
        bullet_angle = portals[1].num;
      } else if ((yTemp > height) && (portals[0].yTemp == height)) {
        xTemp = portals[1].xTemp;
        yTemp = portals[1].yTemp;
        bullet_angle = portals[1].num;
      }
    } else if ((xTemp > portals[1].xTemp - portal_height/2) && (xTemp < portals[1].xTemp + portal_height/2)) {
      if ((yTemp < - diameter) && (portals[1].yTemp == 0)) {
        xTemp = portals[0].xTemp;
        yTemp = portals[0].yTemp;
        bullet_angle = portals[0].num;
      } else if ((yTemp > height) && (portals[1].yTemp == height)) {
        xTemp = portals[0].xTemp;
        yTemp = portals[0].yTemp;
        bullet_angle = portals[0].num;
      }
    } else if ((yTemp > portals[0].yTemp - portal_height/2) && (yTemp < portals[0].yTemp + portal_height/2)) {
      if ((xTemp < - diameter) && (portals[0].xTemp == 0)) {
        xTemp = portals[1].xTemp;
        yTemp = portals[1].yTemp;
        bullet_angle = portals[1].num;
      } else if ((xTemp > width) && (portals[0].xTemp == width)) {
        xTemp = portals[1].xTemp;
        yTemp = portals[1].yTemp;
        bullet_angle = portals[1].num;
      }
    } else if ((yTemp > portals[1].yTemp - portal_height/2) && (yTemp < portals[1].yTemp + portal_height/2)) {
      if ((xTemp < - diameter) && (portals[1].xTemp == 0)) {
        xTemp = portals[0].xTemp;
        yTemp = portals[0].yTemp;
        bullet_angle = portals[0].num;
      } else if ((xTemp > width) && (portals[1].xTemp == width)) {
        xTemp = portals[0].xTemp;
        yTemp = portals[0].yTemp;
        bullet_angle = portals[0].num;
      }
    }
  }

  void move() {    //makes sure the bullets are moving in the correct direction, while also calling the method to follow portal rules
    xTemp += (bullet_speed * cos(bullet_angle));
    yTemp += (bullet_speed * sin(bullet_angle));

    goThroughPortal();
    timeAlive++;    //incrementing time alive to "age" the bullet
  }

  void display() {  //drawing the bullets
    push();
    noStroke();
    fill(250);
    ellipse(xTemp, yTemp, diameter, diameter);
    pop();
  }
}


/**************************************************************************************************************/
/*                                         PORTAL CLASS                                                       */
/**************************************************************************************************************/

class Portal {      //defining the Portal class
  float xTemp, yTemp;
  float bullet_speed;
  float bullet_angle;
  int isBlue;
  int diameter;

  float num;

  Portal(float xPos, float yPos, float jet_angle, int IsBlue) {    //Constructor declaration
    xTemp = xPos;
    yTemp = yPos;
    diameter = 10;
    bullet_speed = 3;
    bullet_angle = jet_angle;
    isBlue = IsBlue;
  }

  void move() {
    xTemp += (bullet_speed * cos(bullet_angle));  //the movement mechanics are identical to the Bullet class, with the exception of when the portal hits a wall
    yTemp += (bullet_speed * sin(bullet_angle));

    hitWall();
  }

  void hitWall() {  //this function flattens the portal "bullet" into an appropriately dimensioned rectangle when it hits a wall

    noStroke();  //choosing the fill color based on whether the portal is blue
    if (isBlue == 1) { 
      fill(20, 235, 245);
    } else { 
      fill(245, 165, 20);
    }
    
    //this if-elif-else chain checks if the portal has hit a wall, and depending on which wall it hits, flattens it into a rectanlge onto the wall 
    if (xTemp - diameter/2 <= 0) {  //there are four possible walls it could hit, and the conditions are based accordingly
      bullet_speed = 0;
      xTemp = 0;
      rect(xTemp, yTemp, portal_width, portal_height);
      num = 0;
    } else if (xTemp + diameter/2 >= width) {
      bullet_speed = 0;
      xTemp = width;
      rect(xTemp, yTemp, portal_width, portal_height);
      num = -PI;
    } else if (yTemp - diameter/2 <= 0) {
      bullet_speed = 0;
      yTemp = 0;
      rect(xTemp, yTemp, portal_height, portal_width);
      num = PI/2;
    } else if (yTemp + diameter/2 >= height) {
      bullet_speed = 0;
      yTemp = height;
      rect(xTemp, yTemp, portal_height, portal_width);
      num = -PI/2;
    } else {  //if it hasn't hit a wall yet, it continues to display in bullet form
      displayBullets();
    }
  }

  void displayBullets() {  //this method displays the portals in bullet form, with the color dependent on whether they are supposed ot be blue
    push();
    noStroke();
    if (isBlue == 1) { 
      fill(20, 235, 245);
    } else { 
      fill(245, 165, 20);
    }
    ellipse(xTemp, yTemp, diameter, diameter-5);  //near identical to diplaying bullets
    pop();
  }
}

/**************************************************************************************************************/
/*                                              SETUP                                                         */
/**************************************************************************************************************/

void setup()
{
  rectMode(CENTER);
  imageMode(CENTER);

  size(900, 600);

  table = loadTable("random.csv", "header");    //loading the csv file of random words and reading them into the random array
  random = new String[table.getRowCount()];
  for (int i = 0; i < table.getRowCount(); i++) { 
    random[i] = table.getString(i, "random");
  }

  jet_pic = loadImage("jet.png");      //loading the image of the jet, the menu background and the game background respectively
  menu_bg = loadImage("menu_bg.jpg");
  game_bg = loadImage("game_bg.jpg");

  font = createFont("PressStart2P.ttf", 32);  //creating the font for all in-game text using the .ttf file in the program folder
  textFont(font);  //setting this as the font for all text

  bullets = new Bullet[10];    //initializing an array of Bullet objects, placing them off screen and out-of-commission until the player fires
  for (int i = 0; i < bullets.length; i++) {
    bullets[i] = new Bullet(-10, -10, 0);
  }

  portals = new Portal[2];    //initializing an array of 2 Portal objects, placing them off screen until the player fires portals
  for (int i = 0; i < 2; i++) {
    portals[i] = new Portal(-100, -100, 0, 0);
  }

  theme = new SoundFile(this, "Mexican Hat Dance.aiff");  //loading each of the sound files to be used in the game
  shot = new SoundFile(this, "shot.aiff");
  portal = new SoundFile(this, "portal.aiff");
  end = new SoundFile(this, "Anthem.aiff");
  theme.play(1, 0.7);  //playing the first sound file when the game loads into the menu screen

  jet = new Jet(jet_pic);  //creating a new Jet object, using the jet image loaded
}

/**************************************************************************************************************/
/*                                               DRAW                                                         */
/**************************************************************************************************************/

void draw() {  //pretty much only navigates between screens using the gameScreen variable
  if (gameScreen == 0) { 
    menuScreen();
  } else if (gameScreen == 1) { 
    playScreen();
  } else if (gameScreen == 2) {
    endScreen();
  }
  //the following comments are codes in case you need to check any of the values during the program execution
  //println("angle: " + jet.jet_angle);
  //println("steer: " + jet.steer);
  //println("xPos: " + jet.xPos + "yPos: " + jet.yPos);
}

/**************************************************************************************************************/
/*                                             MENU SCREEN                                                    */
/**************************************************************************************************************/

void menuScreen() {  //displaying background image and text at the start of the game
  //background(0);
  image(menu_bg, width/2, height/2);
  textAlign(CENTER);
  fill(255);
  textSize(45);
  text("Jet Fighter Portal", width/2, height/2);
  textSize(15); 
  text("Press any key to start", width/2, height-250);
}

/**************************************************************************************************************/
/*                                               PLAY SCREEN                                                  */
/**************************************************************************************************************/

void playScreen() {   //setting the background image and calling the relevant methods from the Jet class to display the jet
  image(game_bg, width/2, height/2);
  jet.move();     //Calculate the location of the jet
  jet.display();  //Display the location
  jet.move();    //calling it once more (for good luck)
  jet.display();
  textSize(35);    //displaying the number of bullets fired at the top of the screen
  textAlign(CENTER);
  fill(255);
  text("BULLETS FIRED: " + fired, width/2, 80);
  textSize(20);
  text(random[(fired)], width/2 + 100, 130);  //displaying a new word from the "random" array after each shot
  if (fired == 43) {  //playing the end music and moving into the end Screen once the 43rd bullet is fired
    end.play();
    gameScreen = 2;
  }
}

/**************************************************************************************************************/
/*                                              END SCREEN                                                    */
/**************************************************************************************************************/

void endScreen() {  //displaying background image and text at the end of the game
  //background(0);
  image(menu_bg, width/2, height/2);
  textAlign(CENTER);
  fill(255);
  textSize(35);
  text("Thank you for playing", width/2, height/2);
  textSize(20);
  text("We will treasure your aimless flying", width/2, height-275);
  text("and shooting and teleporting", width/2, height-250);
  text("forever.", width/2, height-225);
}

//didn't get this next part to work, so you can ignore it

/**************************************************************************************************************/
/*                                    MOVING BOTTOM TEXT ON END SCREEN                                        */
/**************************************************************************************************************/

//void textMove() {
//textSize(15);
//if ((textMove < 700) && (textMoveTrue == 0)) {
//  text("We will treasure your aimless flying", textMove, height-250);
//  text("and shooting and teleporting", textMove, height-230);
//  text("forever.", textMove, height-210);
//  textMove += 10;
//} else if (textMove == 700) {
//  text("We will treasure your aimless flying", textMove, height-250);
//  text("and shooting and teleporting", textMove, height-230);
//  text("forever.", textMove, height-210);
//  textMove -= 10;
//  textMoveTrue = 1;
//} else if ((textMove > 200) && (textMoveTrue == 1)) {
//  text("We will treasure your aimless flying", textMove, height-250);
//  text("and shooting and teleporting", textMove, height-230);
//  text("forever.", textMove, height-210);
//  textMove -= 10;
//} else if (textMove == 200) {
//  text("We will treasure your aimless flying", textMove, height-250);
//  text("and shooting and teleporting", textMove, height-230);
//  text("forever.", textMove, height-210);
//  textMove += 10;
//  textMoveTrue = 0;
//}
//}

/**************************************************************************************************************/
/*                                              KEY CONTROLS                                                  */
/**************************************************************************************************************/

void keyPressed() {
  if (gameScreen==0) { 
    gameScreen = 1;    //starting the game if any key is pressed when the menu screen is displayed
    theme.pause();     //stopping the opening music
  }

  if (key == ' ') {  //calls the Jet class' shoot() method, and plays the shot sound is the spacebar is pressed
    jet.shoot();
    shot.play(1, 0.4);
  }

  if ((key == 'w') || (key == 'W')) {  //calls the Jet class' shootPortals() method and plays the portal shooting sound if W is pressed
    jet.shootPortals();   
    portal.play(2, 1);
    ports++;
  }

  if (keyCode == LEFT) {  //turn the jet's image to the left if the left arrow is pressed
    jet.steer = -0.05;
  } else if (keyCode == RIGHT) {  //turn the jet's image to the right if the right arrow is pressed   
    jet.steer = 0.05;
  } else if (keyCode == UP) {  //boosts the jet's speed to 150% if the up arrow is pressed
    jet.jet_speed = 1.5;
  }
}

void keyReleased() {
  if ((keyCode == LEFT) || (keyCode == RIGHT)) {
    jet.steer = 0;  //stops turning the jet if the left or right arrow keys are released
  } else if (keyCode == UP) {
    jet.jet_speed = 1;  //returns the jet's speed to normal if the up key is released
  }
}
