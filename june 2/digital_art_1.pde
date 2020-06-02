float y;

void setup()
{
  size(600, 600);
  background(255);
}

void draw()
{ 
  for(int i = 0; i <= height; i+=10){
    for(int foo = 0; foo < 601; foo++){
      y = i + 10*sin(foo);
      point(foo, y);
    }
  }
  for(int j = 0; j < (600*sqrt(2)); j++){
   rotate(PI/8);
   rect(-j, -j, 50, 50);
  }
}
