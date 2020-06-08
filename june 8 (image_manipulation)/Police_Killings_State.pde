/*
  Mike Leo, mlk525
  June 8, 2020.
  This program reads data
  from "Police_Killings_State.csv" to
  analyze and visually represent the
  number of black people killed by
  police in each state of the USA
  from January 2013 to December 2019.
  The incidents are limited to those
  where the officers responsible
  were not charged.The sources for 
  this data can be found in the 
  README file here:
  https://github.com/mike-leo-k/intro-to-im/tree/master/june%208%20(image_manipulation)/
  
  As long as you have the csv file and
  the image file (available in the linked
  repository) in the same folder as this program,
  all you need to do is run it. Enjoy!
*/

Table table;  //creating a Table object
float csvdata[][];  //creating a float array to store the information from the table
PImage baseMap;    //creating an image object to load the base map

void setup() {
  size(1300, 730);
  baseMap = loadImage("state_map.jpg");    //loading the map of the US states
  table = loadTable("Police_Killings_State.csv", "header");    //loading the table, while reading the top row as headers
  csvdata = new float[table.getRowCount()][3];    //setting the dimensions for the 2D float array
  for(int i = 0; i < table.getRowCount(); i++){    //loading the data from the table into the 2D array
    csvdata[i][0] =  table.getFloat(i, "Occurrences");
    csvdata[i][1] =  map(table.getFloat(i, "Lon"), -177.85592, -33.10697, 0, width);  //these map() functions converts the longditude and latitude values to fit onto the state map
    csvdata[i][2] =  map(table.getFloat(i, "Lat"), 68.305198, 13.218802, 0, height);
  }
}

void draw() {
  image(baseMap, 0, 0, width, height);  //placing the image to fill the screen
  noStroke();  //removing the outline from any shapes drawn

  for(int i = 0; i < table.getRowCount(); i++){    //this for() loop draws circles over every state, with the size and opactiy of the circle based on the number of killings
    float alpha = map(csvdata[i][0], 0, 200, 40, 90);  //basing the alpha value of the circle fill on the number of killings
    fill(255, 0, 0, alpha);
    float radius = map(csvdata[i][0], 0, 200, 40, 200);
    ellipse(csvdata[i][1], csvdata[i][2] + 78, radius, radius);    //the 80 added to the latitude values was calculated through trial and error to correctly place the circles over states
  }
}
