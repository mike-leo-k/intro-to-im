int foo = 225;        //variables for pupil movement
boolean check = true;

void setup()
{
  size(600, 600);
  background(255);
}

void draw()
{
  //hair
  noStroke();
  fill(0);
  rect(155, 70, 290, 200);
  
  //ears
  noStroke();
  fill(250, 140, 45);
  ellipse(152, 300, 60, 60);
  ellipse(448, 300, 60, 60);
  fill(20);
  ellipse(152, 300, 40, 40);
  ellipse(448, 300, 40, 40);

  //face
  noStroke();
  fill(250, 140, 45);
  ellipse(300, 290, 290, 400);


  //mouth
  strokeWeight(11);
  fill(250, 140, 45);
  line(260, 400, 280, 400);
  strokeWeight(10);
  stroke(0);
  noFill();
  arc(270, 370, 200, 70, 0, 1.8);

  //eyebrows
  stroke(0);
  line(200, 210, 250, 190);
  line(350, 190, 400, 210);

  //nose
  stroke(0);
  line(300, 280, 310, 340);
  line(285, 340, 310, 340);
  
  //glasses
  strokeWeight(4);
  noFill();
  rect(202, 235, 75, 50);
  rect(322, 235, 75, 50);
  line(280, 260, 322, 260);
  
  //eyes
  strokeWeight(2);
  fill(255);
  ellipse(240, 260, 60, 35);
  ellipse(360, 260, 60, 35);
  eyes();         //pupil movement function
  
}

void eyes() {
  fill(0);
  ellipse(foo, 260, 27, 27);
  ellipse(foo+120, 260, 27, 27);
  
  if ((foo <= 255)&&(check == true)){         //if-else check to see what stage of movement the pupils are in
  foo = foo + 1;}
  else if ((foo >= 225)&&(check == false)){
    foo = foo - 1;}
  else{check = !check;}
 
}
