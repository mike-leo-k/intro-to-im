/*
Code for 'Pong Practice'

Controls and score based on 
https://gist.github.com/oguzgelal/a2a8db8b2da0e864d1d0

Class creation based on
http://www.openprocessing.org/sketch/48960

Simple one player derivative of arcade class 'Pong'.
Controls are simply the UP and DOWN arrow keys
*/

int ballSize = 40;    //defining the diameter of the ball
int score = 0;        //defining the initial score as zero

class Ball{      //defining the Ball class
  float xPos, yPos, xSpeed, ySpeed;
  
  Ball(float xTemp, float yTemp){    //Constructor declaration
   xPos = xTemp;
   yPos = yTemp;
   xSpeed = 5;    //"serving" the ball towards the player
   ySpeed = random(-5, 5);  //randomly selecting the vertical direction of the ball
  }
 
  void move(){
   //adding the speed to the coordinates
   xPos += xSpeed;
   yPos += ySpeed;
  }
  
  void bounce(){
    //this function bounces the ball off of the top, right, and bottom walls
    if (xPos < ballSize/2) {
      xSpeed = -xSpeed;
    }
    if ( (yPos < ballSize/2) || (yPos > height-(ballSize/2))) {
      ySpeed = -ySpeed;
    }
  }
  void display(){
   //displaying the ball
   fill(255); //setting color to white
   ellipse(xPos, yPos, ballSize, ballSize);
  } 
}

class Paddle{
 float xPos, yPos, w, h, ySpeed;
 
 Paddle(float xTemp, float yTemp){
  xPos = xTemp;
  yPos = yTemp;
  w = 20;
  h = 200;
  ySpeed = 0;
 }
 
 void move(){
   yPos += ySpeed; 
 }

 void reset(){
   //this function returns the paddle to the playable screen if it goes too high or low
   if (yPos + (h/2) > height) {
     yPos = height - (h/2);
   }
   if (yPos -(h/2) < 0) {
     yPos = h/2;
   } 
 }
 void display(){
  fill (255);    //setting fill color to white
  rectMode(CENTER);    //changing the parameter input for the rect() function, so we 0can directly input the center coordinates
  rect(xPos, yPos, w, h);
 }
  
}

Ball ball;      //defining the ball and paddle as global objects
Paddle paddle;

void setup()
{
  size(800, 600);

  ball = new Ball(width/2, height/2);      //create a new ball at the center of the screen
  paddle = new Paddle(width-15, height/2);  //creating a paddle at the right of the screen
}

void draw() {
  background(0);  //clearing screen
  ball.move();     //Calculate the location of the ball
  ball.bounce();   //Check for collisions against any of the walls
  ball.display();  //Display the location
  
  paddle.move();  //Calculate the location of the paddle
  paddle.reset();  //make sure the paddle remains on screen
  paddle.display();  //Display the paddle
  
  if (ball.xPos > width - (ballSize/2)){   //resets the position of the ball and the score if the paddle misses it
    ball.xPos = width/2;
    ball.yPos = height/2;
    score = 0;
  }
  
  //to check if the paddle bounces the ball, we have to see
  //if the ball hits the x coordinate of the left of the paddle
  //AND if it's between the y coordinates of the top and bottom of the paddle
  if ((ball.xPos + (ballSize/2)) > (paddle.xPos - (paddle.w/2)) && (ball.yPos > paddle.yPos - (paddle.h/2)) && (ball.yPos < paddle.yPos + (paddle.h/2))){
    ball.xSpeed = -ball.xSpeed;
    //for the speed along the y axis, we will assign a range of speeds to be imparted along the paddle
    //the edges of the paddle will have the max speeds of -10 and +10
    ball.ySpeed = map(ball.yPos - paddle.yPos, -paddle.h/2, paddle.h/2, -10, 10); 
    score += 1; //adds one point to the score every time the player hits the ball with the paddle
  }
  
  textSize(40);
  textAlign(CENTER);
  text("SCORE: " + score, width/2, 50);
}

//Now we put the commands given by pressing and releasing the up and down arrow keys
void keyPressed(){
  if(keyCode == UP){
    paddle.ySpeed = -3;
  }
  if(keyCode == DOWN){
    paddle.ySpeed = 3;
  }
}

void keyReleased(){
  if(keyCode == UP){
    paddle.ySpeed = 0;
  }
  if(keyCode == DOWN){
    paddle.ySpeed = 0;
  }
}
