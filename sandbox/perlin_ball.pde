/* 
This program animates a white circle
moving between random points on the 
screen, using the noise() (Perlin noise)
function.
*/

float t1=0;    //initializing variables representing time to zero
float t2=0;

void setup() {
  background(0);
  size(350, 350);
}

void draw() {
  background(0);  //erasing the background after every iteration
  t1 += 0.005;    //incrementing the time variables by a small amount for the smoothest movement
  t2 += 0.005;
  fill(255);  //coloring the ball white
  //replace the perlin noise variables with the following two to illustrate the difference between "true" randomness and "controlled" randomness
  //float x = random(width);
  //float y = random(height);
  float x = noise(t2, t1);    //generates a value between 0 and 1 from a 2-dimensional Perlin noise grid
  float y = noise(t1);        //generates a value between 0 and 1 from a linear set of Perlin noise values
  //x and y use different dimensions of Perlin noise in order for them to have different randomly generated values
  x = map(x, 0, 1, 0, width);    //mapping the generated values to the dimensions of the screen
  y = map(y, 0, 1, 0, height);
  ellipse(x, y, 25, 25);        //finally drawing the circle
}
