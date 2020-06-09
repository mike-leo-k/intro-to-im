/*
Code for 'Jet Fighter Portal'
 
 */

int jet_width = 20;
int jet_height = 30;

class Jet {      //defining the Ball class
  float xPos, yPos;
  float jet_speed;
  float jet_angle;
  float steer;
  int c;

  Jet(int colour) {    //Constructor declaration
    xPos = width/2;
    yPos = height/2;
    c = colour;
    jet_speed = 1;
    jet_angle = 0;
  }

  void maintainDirection() {
    xPos += (jet_speed * cos(jet_angle));
    yPos += (jet_speed * sin(jet_angle));
  }

  void stayInScreen() {
    if (xPos - jet_width/2 < 0) {
      xPos = 1;
    } else if (xPos + jet_width/2 > width) {
      xPos = width-1;
    }

    if (yPos - jet_height/2 < 0) {
      yPos = 1;
    } else if (yPos + jet_height/2 > height) {
      yPos = height-1;
    }
  }

  void move() {
    maintainDirection();
    stayInScreen();

    jet_angle += steer;
  }

  void display() {
    push();
    
    translate(xPos, yPos);
    rotate(jet_angle);
    rect(0, 0, 20, 30); 
    pop();
  }
}


Jet jet;      //defining the ball and paddle as global objects

void setup()
{
  rectMode(CENTER);
  size(500, 500);
  jet = new Jet(255);
}

void draw() {
  background(0);
  push();//clearing screen
  stroke(255);
  strokeWeight(10);
  noFill();
  rect(width/2, height/2, width, height);
  pop();
  jet.move();     //Calculate the location of the ball
  jet.display();  //Display the location
  jet. move();
  jet.display();
  println("x: " + jet.xPos + " y: " + jet.yPos);
  textSize(40);
  textAlign(CENTER);
  text("SCORE: ", width/2, 50);
}

//Now we put the commands given by pressing and releasing the up and down arrow keys
void keyPressed() {
  if (keyCode == LEFT) {
    jet.steer = -0.05;
  }
  if (keyCode == RIGHT) {
    jet.steer = 0.05;
  }
}

void keyReleased() {
  if ((keyCode == LEFT) || (keyCode == RIGHT)) {
    jet.steer = 0;
  }
}
