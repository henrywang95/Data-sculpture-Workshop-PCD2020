/* 
Data sculpture Workshop at PCD 2020 by Henry Wang
load csv file and visualizing a list of value in 2d circles
*/

import processing.pdf.*;

//---------------------------------------------------------------------------
//-- this is a flag. When you press the SPACE bar, it will set to TRUE
//-- then, in the draw() functon we will record 
boolean recordToPDF = false;

Table table;

void setup() {
  size(1000, 500);

}

void draw() {
  background(255);
    //-- respond to flag for recording
  if( recordToPDF )
    beginRecord(PDF, "data_output.pdf");
  stroke(0);
  
  table = loadTable("Activities.csv", "header"); 
  
  for (TableRow row : table.rows()) {
    int id = row.getInt("id");
    int size = row.getInt("Walk");
    ellipse(80*id, height/2, size, size); //drawing the data set as the ellipse depends on the size of the data
  }
  
    //-- done recording to PDF, set flag to false and flash white to indicate that we have recorded
  if( recordToPDF ) {
    endRecord();
    recordToPDF = false;
    background(0);    // flash to white
  } 
}

void keyPressed() {
  if( key == ' ' )
    recordToPDF = true;
}
