int foo = 28;
int check = 0;

void setup() {
  background(0);
  size(300, 300);
}

void draw() {
  background(0);              //refreshes the background so past iterations of the circle don't remain
  ellipse(foo, foo, 40, 40);
  
  if ((foo < 274)&&(check == 0)){
  foo = foo + 1;}           //moves the circle diagonally downwards
  
  else if (foo > 273){
    foo = foo - 1;
    check = 1;}             //moves the circle one step back once it hits the bottom right corner of the screen
  
  else if ((foo < 274)&&(check == 1)){
    foo = foo - 1;}         //moves the circle so that it retraces its steps and moves off frame
  
 // background(0);
 // ellipse(foo, foo, 40, 40);
 // foo = foo - 1;
 
}
