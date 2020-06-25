import processing.serial.*;          // Importing Processing's Serial library to communicate with the Arduino
Serial myPort;                       // The serial port
int[] serialInArray = new int[5];    // Where we'll put the values we receive
int serialCount = 0;                 // A count of how many bytes we receive
boolean firstContact = false;        // Whether we've heard from the microcontroller

float rate, cell_w, cell_h;
int cells_per_screen, start, end;
color[] colors = { #E82A2A, #2AE8E6, #36E82A, #E8D52A, #2A32E8, #DB2AE8 };
int[][] song;
int[][] scoring_sheet;
boolean scored;
String final_score = "";
char[] key_bindings ={ '1', '2', '3', '4' };
boolean[] held;

import processing.sound.*;
SoundFile track;

void setup() {
  size(600, 600, P3D);

  String[] data = loadStrings( "seven.txt" );
  song = new int[ data.length ][ data[0].length() ];

  for ( int i = 0; i < data.length; ++i ) {
    for ( int j = 0; j < data[i].length(); ++j ) {
      if ( (data[i].charAt(j) == '-') || (data[i].charAt(j) == '—')) song[i][j] = -1;
      else song[i][j] = int( data[i].charAt(j) ) -48;
    }
  }
  scoring_sheet = new int[ song.length ][ song[0].length ];
  for ( int i = 0; i < song.length; ++i ) {
    for ( int j = 0; j < song[0].length; ++j ) {
      scoring_sheet[i][j] = -1;
    }
  }
  held = new boolean[key_bindings.length];
  rate = 400;
  cell_w = 500/ (float) song.length;
  cell_h = cell_w;
  cells_per_screen = ceil(height / cell_h) + 1;

  track = new SoundFile(this, "seven.aiff");

  stroke(#A4BFBC);
  textSize(72);
  textAlign( CENTER, CENTER );

  end = 0;//..................... time when the song will be over.
  scored = true;
  final_score = "Press any key to\nstart playing";
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(20);
  translate(0, 0, -210);
  rotateX(PI/6);
  int LINEY = height-100;
  if ( millis() < end ) {
    line (width/5, -100, width/5, height);
    line (2*width/5, -100, 2*width/5, height); 
    line (3*width/5, -100, 3*width/5, height);  
    line (4*width/5, -100, 4*width/5, height); 
    line (0, LINEY, width, LINEY);
    float current_cell = (millis()-start) / rate;
    int n = floor( current_cell );
    translate( 0, current_cell * cell_h ); 

    for ( int i = 0; i < song.length; ++i ) {
      float x = 1+i;
      for ( int j = n; j < n+cells_per_screen && j < song[0].length; ++j ) {
        if ( j == n && held[i] && song[i][j]>=0 ) {
          fill(255);
          ellipse( x*width/5, height - ((j+1)*cell_h), cell_w, cell_h );
        } else if ( song[i][j] >= 0 ) {
          fill( colors[i] );
          ellipse( x*width/5, height - ((j+1)*cell_h), cell_w, cell_h );
        }
      }
    }
  } else {
    if ( scored ) {
      text( final_score, width/2f, height/2f );
    } else {
      int max_score = 0, score = 0;
      for ( int i = 0; i < song.length; ++i ) {
        for ( int j = 0; j < song[0].length; ++j ) {
          if ( song[i][j] >= 0 ) {
            max_score += rate;
            if ( scoring_sheet[i][j] >= 0 ) score += rate - scoring_sheet[i][j];
            else score -= rate; //penalty for missing a note.
          } else {
            if ( scoring_sheet[i][j] >= 0 ) {
              if ( song[i][j+1] >= 0 );
              else score -= rate;
            }
          }
        }
      }
      float S = constrain(map( score, -max_score, max_score, 0, 100 ), 0, 100);
      final_score =  nf(S, 2, 1) + "%" ;
      fill( colors[ round( 0.05 * S ) ] );
      scored = true;
    }
  }
}

void keyPressed() {
  if ( millis() > end ) {
    end = ceil( millis()+(rate * song[0].length) );
    start = millis();
    scored = false;
    scoring_sheet = new int[ song.length ][ song[0].length ];
    for ( int i = 0; i < song.length; ++i ) {
      for ( int j = 0; j < song[0].length; ++j ) {
        scoring_sheet[i][j] = -1;
      }
    }
    track.play();
  }
  int n = floor( (millis()-start) / rate );
  for ( int i = 0; i < key_bindings.length; ++i ) {
    if ( key == key_bindings[i] ) {
      scoring_sheet[i][n] = round( (millis()-start) - (n*rate) );
      held[i] = true;
    }
  }
}
void keyReleased() {
  for ( int i = 0; i < key_bindings.length; ++i ) {
    if ( key == key_bindings[i] ) {
      held[i] = false;
    }
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
      myPort.clear();          
      firstContact = true;     
      myPort.write('A');       
    }
  } else {
    // Add the latest byte from the serial port to array:
    serialInArray[serialCount] = inByte;
    serialCount++;

    // If we have 4 bytes (the 4 values that are to be communicated):
    if (serialCount > 3 ) {
      int n = floor( (millis()-start) / rate );
      for ( int i = 0; i < key_bindings.length; ++i ) {
        if ( serialInArray[i] == 1 ) {
          scoring_sheet[i][n] = round( (millis()-start) - (n*rate) );
          held[i] = true;
        }
        //for( int j = 0; j < key_bindings.length; ++j ){
        //if( serialInArray[j] == 0 ){
        //  held[j] = false;
        //}
        //}
        // Send a capital A to request new sensor readings:
        myPort.write('A');
        // Reset serialCount:
        serialCount = 0;
      }
    }
  }
}
