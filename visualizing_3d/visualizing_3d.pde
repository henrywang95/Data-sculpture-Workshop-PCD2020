/* 
Data sculpture Workshop at PCD 2020 by Henry Wang
load csv file and visualizing a list of value in 3d
*/

import peasy.*;
PeasyCam cam;

import nervoussystem.obj.*;
boolean record = false;

Table table;

void setup() {
  size(900, 500, P3D);
  
  cam = new PeasyCam(this, width/2, height/2, 0, 400);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(1000);
}

void draw() {
  background(255);
  stroke(0);
  
  table = loadTable("Activities.csv", "header"); 
  
  if (record) {
    beginRecord("nervoussystem.obj.OBJExport", "spheres.obj");
  }
  
  for (TableRow row : table.rows()) {
    int id = row.getInt("id");
    int size = row.getInt("Walk");
    
    pushMatrix();
    translate(80*id, height/2, 0);
    sphere(size);
    popMatrix();
  }
  
  if (record) {
    endRecord();
    record = false;
  }
}

void keyPressed()
{
  if (key == ' ') {
    record = true;
  }
}
