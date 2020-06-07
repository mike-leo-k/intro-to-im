/*
  Mike Leo, mlk525
  June 7, 2020.
  This program reads data
  from "1988_Medal.csv" to
  analyze and compare the
  number of communist states
  participating in the 
  1988 Seoul Olympics to 
  the number of medals they
  won. The sources for this data
  can be found in the README file
  here: https://github.com/mike-leo-k/intro-to-im/edit/master/june%207/
  
  As long as you have the file
  in the same folder as this program,
  all you need to do is run it. Enjoy!
*/

Table table;  //creating a Table object
float comm_participants = 0, total_participants = 0;  //initializing the variables that are going to be calculated from the file
float comm_medals = 0, total_medals = 0;

void setup() {
  table = loadTable("1988_Medals.csv", "header");    //loading the table, while reading the top row as headers
  size(800, 450);
  for (TableRow row : table.rows()) {  //creates a TableRow object from each row of the table until the end of the file

    int medals = row.getInt("Total Medals");  //temporarily inputting the value under the Total Medals column into the variable medals
    int comm = row.getInt("Communism");      //temporarily inputting the value under the Communism column into the variable comm

    total_medals += medals;  //this expression will calculate the total number of medals by the end of the for() loop
    total_participants += 1; //for symmetry, this does the same for number of participants (although using .getRowCount() would also serve this purpose
    if (comm == 1) {  //if the country is a communist state, it is added to communist participants, and it's medals are included under comm_medals
      comm_participants += 1; 
      comm_medals += medals;
    }
  }
}

void draw() {
  stroke(0);    //setting all shapes to have thing black outlines
  fill(255);    //setting the fill to be white
  rect(0, 50, width, 150);  //drawing a white rectangle to represent all participants in the Olympics, that's as big as the width of the screen
  fill(255, 0, 0);    //setting the fill to be red (to represent communist states)
  float x1 = map(comm_participants, 0, total_participants, 0, width);  //creating a new variable, by mapping the number of communist state participants to the length of the previous rectangle
  rect(0, 50, x1, 150);  //drawing a red rectangle over the previous white rectangle to represent the proportion of participants that were communist states

  //we repeat this process with the medals, using total_medals and comm_medals to map the new variable
  fill(255);
  rect(0, 250, width, 150);
  fill(255, 0, 0);
  float x2 = map(comm_medals, 0, total_medals, 0, width);
  rect(0, 250, x2, 150);  //this red rectangle will represent the proportion of medals won by communist states out of all medals
  
  println(100*(x1/width) + "% of the participants were communist states.");  //printing the numerical percentage using the mapped variables and width
  println(100*(x2/width) + "% of the medals were won by communist states.");
  println();
}
