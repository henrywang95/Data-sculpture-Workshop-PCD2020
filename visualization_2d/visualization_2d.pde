/* 
Data sculpture Workshop at PCD 2020 by Henry Wang
load csv file and visualizing a list of value in 2d circles
*/

Table table;

void setup() {
  size(1000, 500);
}

void draw() {
  background(255);
  stroke(0);
  
  table = loadTable("Activities.csv", "header"); 
  
  for (TableRow row : table.rows()) {
    int id = row.getInt("id");
    int size = row.getInt("Walk");
    ellipse(80*id, height/2, size, size);
  }
}
