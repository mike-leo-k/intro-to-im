/*
  Mike Leo, mlk525
  June 7, 2020.
  This program generates
  a colorful pattern using
  sine graphs and transformations
  as well as randomly generated
  color.
  All you need to do is run it. Enjoy!
*/

float y;    //declaring global variables for use in the trigonometric function
float foo = 0;

void setup()
{
  size(700, 700);
  background(255);   //white backgroung
  frameRate(240);    //increasing default frame rate by 4x for fastest generation of final image
}

void draw()
{ 

  //translate(0,100);
  for (int i = 0; i <= width; i += 15) {    //i sets the values for translation, spacing the designs with regular intervals
    stroke(random(255), random(255), random(255));  //randomly setting the color for each point on each sine graph
    strokeWeight(10);                               //increasing point size for thicker sine graphs
    pushMatrix();      //saving default coordinate system
    translate(0, i);   //translating the coordinate system i units downward
    scattergraph();    
    popMatrix();       //returning to default coordinate system position

    pushMatrix();
    translate(i, 0);   //translating coordinate system i units to the right
    rotate(PI/2);      //rotating the coordinate system by 90 degrees (or pi/2 radians)
    scattergraph();    //this will generate the same design as above, but vertically
    popMatrix();
  }
}

void scattergraph()
{    
  y = sin(foo);
  y = map(y, -1, 1, -10, 10);    //scaling the value of y by a multiplicative factor of 10
  float x = map(foo, 0, width, 0, width*10);  //scaling the value of foo by 10 as well
  point(x, y);    //this will generate a sin graph scaled up by a factor of 10
  foo+=0.001;    //incrementing foo by a small value for the smoothest possible graph
}
