/*
  Data sculpture Workshop at PCD 2020 by Henry Wang

  Renders out a simple CSV file to (x,y) points on the screen
  Looks for 2 header columns: "X" and "Y"
  
  
  Output file is: data_output.pdf
  Input file is: data_input.csv
  
  Spacebar will save the file
  
*/

//-- this is a build in PDF library for Processing that allows for export 
import processing.pdf.*;

//---------------------------------------------------------------------------
//-- DEFAULT VARIABLES
final float defaultSize = 5;
final int defaultCategoryNum = 0;
final float  margin = 150;

float homeX;
float homeY;

//---------------------------------------------------------------------------
//-- this is a flag. When you press the SPACE bar, it will set to TRUE
//-- then, in the draw() functon we will record 
boolean recordToPDF = false;

//-- this is our table of data
Table table;

//---------------------------------------------------------------------------
//-- these are all variables for doing accurate mapping
float minX = 9999;
float maxX = -9999;
float minY = 9999;
float maxY = -9999;

float XRange;
float YRange;

float XAdjust;
float YAdjust;
//---------------------------------------------------------------------------


//
void setup() {
  //-- right now width and height have to be the same, otherwise it won't map properly
  //-- set to something like (2400,2400) for a large image
  size(800,800);
  rectMode(CENTER);
  loadData("Activities.csv");  
}

void draw() {
  //-- draw background elements
  background(255);
  
  
  //-- respond to flag for recording
  if( recordToPDF )
    beginRecord(PDF, "data_output.pdf");
  
  
  // use various strokes and weights to respond to size here
  noFill();
  stroke(0,0,0);
  strokeWeight(1);
  
  //-- draw data
  drawAllData();
  
  //-- done recording to PDF, set flag to false and flash white to indicate that we have recorded
  if( recordToPDF ) {
    endRecord();
    recordToPDF = false;
    background(0);    // flash to white
  } 
}

//-- loads the data into the table variable, does some testing for the output
void loadData(String filename) {
  //-- this loads the actual table into memory
  table = loadTable(filename, "header");

  println(table.getRowCount() + " total rows in table"); 

  
  //-- go though table and deterime min and max Y/X for mapping to the screen
  for (TableRow row : table.rows()) {
    
    float x = row.getFloat("Walk");
    float y = row.getFloat("Run");
    
     if( x < minX )
      minX = x;
    
    if( x > maxX )
      maxX = x;
    
    if( y < minY )
      minY = y;
    if( y > maxY )
      maxY = y;
  }  
  
  //-- determine various ranges and make simple math adjustments for plotting on the screen
  println("min X =" + minX );
  println("min Y =" + minY );
  println("max X =" + maxX );
  println("max Y =" + maxY );
  
  XRange = maxX-minX;
  YRange = maxY-minY;
  
  
  println("X range = " + XRange );
  println("Y range = " + YRange );
  
  //-- we do this so that we don't have skewed maps
  YAdjust = 0;
  XAdjust = 0;
  if( XRange > YRange )
    YAdjust = (XRange-YRange)/2;
  else if( YRange > XRange )
    XAdjust = (YRange-XRange)/2;
}


//-- draw each data
void drawAllData() {
  for (TableRow row : table.rows()) {
    
    float x = row.getFloat("Walk");
    float y = row.getFloat("Run");
    float s = getSizeData(row);       // size
    
   
    //-- draw data point here
    drawDatum(x,y, s);
  }
}

//-- read .size column, if there is none, then we use a default size variable (global)
float getSizeData(TableRow row) {
   float s = defaultSize;

   //-- Process size column
    try {
      //-- there IS size column
      s = row.getFloat("Size");
      s = s *3;
      
    } catch (Exception e) {
      //-- there is NO size column in this data set
      //-- no size coulumn, set s to plottable value
      
    }
    
    return s;
}

//-- read .category column, if there is none, then we use a default category


void drawDatum(float x, float y, float dataSize) {
  
  float drawX = map(x, (minX - XAdjust), (maxX + XAdjust), margin, width - margin);
  float drawY = map(y, (minY - YAdjust), (maxY + YAdjust), height - margin, margin) * 1.25 - 100;
  
  
  // large will be square
  rect(drawX, drawY, dataSize, dataSize);  
}

void keyPressed() {
  if( key == ' ' )
    recordToPDF = true;
}
