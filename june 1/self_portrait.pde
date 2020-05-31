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
  
  //eyes
  strokeWeight(1);
  fill(255);
  ellipse(240, 260, 60, 35);
  ellipse(360, 260, 60, 35);
  fill(0);
  ellipse(240, 260, 27, 27);
  ellipse(360, 260, 27, 27);
}
