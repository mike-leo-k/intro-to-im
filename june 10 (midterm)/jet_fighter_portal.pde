/*
Code for 'Jet Fighter Portal'
 
 */

int foo = 0;
int fired = 0, ports = 0;
int textMove, textMoveTrue;

PImage jet_pic;
PImage menu_bg;
PImage game_bg;

Table table;
String[] random;

PFont font;
int gameScreen = 0;

int portal_height = 60;
int portal_width = 10;

Jet jet;
Bullet bullets[];
Bullet bullet;
Portal portals[];

import processing.sound.*;
SoundFile theme;
SoundFile shot;
SoundFile portal;
SoundFile end;

/**************************************************************************************************************/
/*                                            JET CLASS                                                       */
/**************************************************************************************************************/

class Jet {      //defining the Ball class
  float xPos, yPos;
  float jet_speed;
  float jet_angle;
  float steer;
  PImage jet_image;

  Jet(PImage image) {    //Constructor declaration
    xPos = random(width);
    yPos = random(height);
    jet_image = image;
    jet_speed = 1;
    jet_angle = 0;
  }

  void maintainDirection() {
    xPos += (jet_speed * cos(jet_angle));
    yPos += (jet_speed * sin(jet_angle));
  }

  void stayInScreen() {
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
    } else {
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


  void move() {
    maintainDirection();
    stayInScreen();

    jet_angle += steer;
  }

  void shoot() {
    bullet = new Bullet(xPos, yPos, jet_angle);
    if (foo <= bullets.length - 1) {
      bullets[(bullets.length - 1) - foo] = bullet;
    } else {
      foo = 0;
      bullets[(bullets.length - 1) - foo] = bullet;
    }
    foo++;
    fired++;
  }

  void displayBullets() {
    for (int i = bullets.length - 1; i >= 0; i--) {
      bullets[i].move();
      bullets[i].display();
      
      if(bullets[i].timeAlive > 200){
       bullets[i].xTemp = -10;
       bullets[i].yTemp = -10;
       bullets[i].bullet_speed = 0;
      }
    }
  }

  void shootPortals() {
    if (ports % 2 == 0) {
      portals[0] = new Portal(xPos, yPos, jet_angle, 0);
    } else {
      portals[1] = new Portal(xPos, yPos, jet_angle, 1);
    }
  }

  void displayPortals() {
    for (int i = 0; i < 2; i++) {
      portals[i].move();
    }
  }

  void display() {
    push();
    translate(xPos, yPos);
    rotate(jet_angle);
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
    diameter = 10;
    bullet_speed = 2;
    bullet_angle = jet_angle;
    timeAlive = 0;
  }

  void goThroughPortal() {
    //portal stuff
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
      if ((xTemp < - diameter) && (portals[0].xTemp == 0))  {
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

  void move() {
    xTemp += (bullet_speed * cos(bullet_angle));
    yTemp += (bullet_speed * sin(bullet_angle));

    goThroughPortal();
    timeAlive++;
  }

  void display() {
    push();
    noStroke();
    fill(255);
    ellipse(xTemp, yTemp, diameter, diameter);
    pop();
  }
}


/**************************************************************************************************************/
/*                                         BULLET CLASS                                                       */
/**************************************************************************************************************/

class Portal {      //defining the Bullet class
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
    xTemp += (bullet_speed * cos(bullet_angle));
    yTemp += (bullet_speed * sin(bullet_angle));

    hitWall();
  }

  void hitWall() {

    noStroke();
    if (isBlue == 0) { 
      fill(20, 235, 245);
    } else { 
      fill(245, 165, 20);
    }

    if (xTemp - diameter/2 <= 0) {
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
    } else {
      displayBullets();
    }
  }

  void displayBullets() {
    push();
    noStroke();
    if (isBlue == 0) { 
      fill(20, 235, 245);
    } else { 
      fill(245, 165, 20);
    }
    ellipse(xTemp, yTemp, diameter, diameter-5);
    pop();
  }

  //  void displayPortal(int num) {

  //    switch(num) {
  //    case 1:

  //    case 2:
  //      rect(xTemp, yTemp, portal_width, portal_height);
  //    case 3:

  //    case 4:
  //      rect(xTemp, yTemp, portal_height, portal_width);
  //    }

  //    pop();
  //  }
}

/**************************************************************************************************************/
/*                                              SETUP                                                         */
/**************************************************************************************************************/

void setup()
{
  rectMode(CENTER);
  imageMode(CENTER);

  size(900, 700);

  table = loadTable("random.csv", "header");
  random = new String[table.getRowCount()];
  for (int i = 0; i < table.getRowCount(); i++) { 
    random[i] = table.getString(i, "random");
  }

  jet_pic = loadImage("jet.png");
  menu_bg = loadImage("menu_bg.jpg");
  game_bg = loadImage("game_bg.jpg");

  font = createFont("PressStart2P.ttf", 32);
  textFont(font);

  bullets = new Bullet[10];
  for (int i = 0; i < bullets.length; i++) {
    bullets[i] = new Bullet(-10, -10, 0);
  }

  portals = new Portal[2];
  for (int i = 0; i < 2; i++) {
    portals[i] = new Portal(-100, -100, 0, 0);
  }

  theme = new SoundFile(this, "Mexican Hat Dance.aiff");
  shot = new SoundFile(this, "shot.aiff");
  portal = new SoundFile(this, "portal.aiff");
  end = new SoundFile(this, "Anthem.aiff");
  theme.play(1, 0.7);

  jet = new Jet(jet_pic);
}

/**************************************************************************************************************/
/*                                               DRAW                                                         */
/**************************************************************************************************************/

void draw() {
  if (gameScreen == 0) { 
    menuScreen();
  } else if (gameScreen == 1) { 
    playScreen();
  } else if (gameScreen == 2) {
    textMove = 200;
    textMoveTrue = 0;
    endScreen();
  }
  //println("angle: " + jet.jet_angle);
  //println("steer: " + jet.steer);
  //println("xPos: " + jet.xPos + "yPos: " + jet.yPos);
}

/**************************************************************************************************************/
/*                                             MENU SCREEN                                                    */
/**************************************************************************************************************/

void menuScreen() {
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

void playScreen() {
  image(game_bg, width/2, height/2);
  jet.move();     //Calculate the location of the ball
  jet.display();  //Display the location
  jet. move();
  jet.display();
  textSize(40);
  textAlign(CENTER);
  fill(255);
  text("BULLETS FIRED: " + fired, width/2, 80);
  textSize(20);
  text(random[fired], width/2 + 100, 130);
  if (fired == 43) {
    end.play();
    gameScreen = 2;
  }
}

/**************************************************************************************************************/
/*                                              END SCREEN                                                    */
/**************************************************************************************************************/

void endScreen() {
  //background(0);
  image(menu_bg, width/2, height/2);
  textAlign(CENTER);
  fill(255);
  textSize(35);
  text("Thank you for playing", width/2, height/2);
  textSize(15);
  text("We will treasure your aimless flying", width/2, height-270);
  text("and shooting and teleporting", width/2, height-250);
  text("forever.", width/2, height-230);
}

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
    gameScreen = 1;
    theme.pause();
  }

  if (key == ' ') {
    jet.shoot();
    shot.play(1, 0.4);
  }

  if (key == 'w') {
    jet.shootPortals();
    portal.play(2, 1);
    ports++;
  }

  if (keyCode == LEFT) {
    jet.steer = -0.05;
  } else if (keyCode == RIGHT) {
    jet.steer = 0.05;
  }
}

void keyReleased() {
  if ((keyCode == LEFT) || (keyCode == RIGHT)) {
    jet.steer = 0;
  }
}
