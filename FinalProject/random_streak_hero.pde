import processing.serial.*;          // Importing Processing's Serial library to communicate with the Arduino
Serial myPort;                       // The serial port
int[] serialInArray = new int[5];    // Where we'll put the values we receive
int serialCount = 0;                 // A count of how many bytes we receive
boolean firstContact = false;        // Whether we've heard from the microcontroller

import processing.sound.*;
SoundFile track;

class Animation {
  PImage[] images;
  int imageCount;
  int frame;

  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + i + "_delay-0.08s.gif";
      images[i] = loadImage(filename);
    }
  }

  void display(float xpos, float ypos) {
    frame = (frame+1) % imageCount;
    push();
    translate(0, 0, z);
    rotateX(PI/6);
    imageMode(CENTER);
    image(images[frame], xpos, ypos, 150, 150);
    //delay(10);
    pop();
  }

  int getWidth() {
    return images[0].width;
  }
}

int aBall;
int sBall;
int dBall;
int fBall;
int LINEY;
int points;
boolean hitA;
boolean hitS;
boolean hitD;
boolean hitF;
int RADIUS;
int streak;
Animation fire;
float z = -110;

void setup () {
  size (500, 500, P3D);
  textAlign (CENTER, CENTER);
  LINEY = height-100;
  points = 0;
  streak = 0;
  aBall = int (random (-500, 0));
  hitA = false;
  sBall = int (random (-500, 0));
  hitS = false;
  dBall = int (random (-500, 0));
  hitD = false;
  fBall = int (random (-500, 0));
  hitF = false;
  RADIUS = 30;
  fire = new Animation("frame_", 8);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  track = new SoundFile(this, "test.aiff");
  track.play();
}

void draw () {
  background (0);
  fill (255);
  stroke(255);
  push();
  translate(0, 0, z);
  rotateX(PI/6);
  line (width/5, -100, width/5, height);
  line (2*width/5, -100, 2*width/5, height); 
  line (3*width/5, -100, 3*width/5, height);  
  line (4*width/5, -100, 4*width/5, height); 
  line (0, LINEY, width, LINEY);
  fill (255, 0, 0);
  ellipse (width/5, aBall, 2*RADIUS, 2*RADIUS);
  fill (0, 0, 255);
  ellipse (2*width/5, sBall, 2*RADIUS, 2*RADIUS);
  fill (0, 255, 0);
  ellipse (3*width/5, dBall, 2*RADIUS, 2*RADIUS);
  fill (255, 255, 0);
  ellipse (4*width/5, fBall, 2*RADIUS, 2*RADIUS);  
  fill (255);
  pop();
  text ("Score: "+points, width-70, 50);
  text ("Streak: "+streak, width-70, 75);
  //y++;
  //z++;
  aBall+=3;
  if (aBall >  height) {
    if (!hitA) {
      points = points-1;
      streak = 0;
    }
    aBall = int (random (-500, 0));
    hitA = false;
  }

  sBall+=3;
  if (sBall > height) {
    if (!hitS) {
      points = points-1;
      streak = 0;
    }
    sBall = int (random (-500, 0));
    hitS = false;
  }

  dBall+=3;
  if (dBall > height) {
    if (!hitD) {
      points = points-1;
      streak = 0;
    }
    dBall = int (random (-500, 0));
    hitD = false;
  }

  fBall+=3;
  if (fBall > height) {
    if (!hitF) {
      points = points-1;
      streak = 0;
    }
    fBall = int (random (-500, 0));
    hitF = false;
  }
}

void keyPressed () {
  if (key == '1') {
    if ((aBall > LINEY-RADIUS) && (aBall < LINEY+RADIUS) && !hitA) {
      points = points + 1;
      streak++;
      fire.display(width/5, height-100);
      aBall = int (random (-500, 0));
    } else {
      points = points - 1;
      streak = 0;
    }
    hitA = true;
  } else if (key == '2') {
    if ((sBall > LINEY-RADIUS) && (sBall < LINEY+RADIUS) && !hitS) {
      points = points + 1;
      streak++;
      fire.display(2*width/5, height-100);  
      sBall = int (random (-500, 0));
  } else {
      points = points - 1;
      streak = 0;
    }
    hitS = true;
  } else if (key == '3') {
    if ((dBall > LINEY-RADIUS) && (dBall < LINEY+RADIUS) && !hitD) {
      points = points + 1;
      streak++;
      fire.display(3*width/5, height-100);
      dBall = int (random (-500, 0));
    } else {
      points = points - 1;
      streak = 0;
    }
    hitD = true;
  } else if (key == '4') {
    if ((fBall > LINEY-RADIUS) && (fBall < LINEY+RADIUS) && !hitF) {
      points = points + 1;
      streak++;
      fire.display(4*width/5, height-100);
      fBall = int (random (-500, 0));
    } else {
      points = points - 1;
      streak = 0;
    }
    hitF = true;
  }
}

void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  int inByte = myPort.read();
  // if this is the first byte received, and it's an A, clear the serial
  // buffer and note that you've had first contact from the microcontroller.
  // Otherwise, add the incoming byte to the array:
  if (firstContact == false) {
    if (inByte == 'A') {
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    }
  } else {
    // Add the latest byte from the serial port to array:
    serialInArray[serialCount] = inByte;
    serialCount++;

    // If we have 4 bytes (the 4 values that are to be communicated):
    if (serialCount > 3 ) {

      if (serialInArray[0] == 1 && serialInArray[4] < 220) { 
        if ((aBall > LINEY-RADIUS) && (aBall < LINEY+RADIUS) && !hitA) {
          points = points + 1;
          streak++;
          fire.display(width/5, height-100);
        } else {
          points = points - 1;
          streak = 0;
        }
        hitA = true;
      }

      if (serialInArray[1] == 1 && serialInArray[4] < 220) {
        if ((sBall > LINEY-RADIUS) && (sBall < LINEY+RADIUS) && !hitS) {
          points = points + 1;
          streak++;
        } else {
          points = points - 1;
          streak = 0;
        }
        hitS = true;
      }

      if (serialInArray[2] == 1 && serialInArray[4] < 220) {
        if ((dBall > LINEY-RADIUS) && (dBall < LINEY+RADIUS) && !hitD) {
          points = points + 1;
          streak++;
        } else {
          points = points - 1;
          streak = 0;
        }
        hitD = true;
      }

      if (serialInArray[3] == 1 && serialInArray[4] < 220) {
        if ((fBall > LINEY-RADIUS) && (fBall < LINEY+RADIUS) && !hitF) {
          points = points + 1;
          streak++;
        } else {
          points = points - 1;
          streak = 0;
        }
        hitF = true;
      }
      // Send a capital A to request new sensor readings:
      myPort.write('A');
      // Reset serialCount:
      serialCount = 0;
    }
  }
}
