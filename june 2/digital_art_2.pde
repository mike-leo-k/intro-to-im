void setup()
{
  size(600, 600);
  background(255);
}

void draw()
{ 
  circles();
}

void circles()
{
  for(int i = 0; i <= height; i+=10){
    for(int j = 0; j <= width; j+=20){
      fill((int)random(255), (int)random(255), (int)random(255)); //truncating the randomly generated number to remove the decimal point
      ellipse(i, j, 25, 25);
    }
  }
}
