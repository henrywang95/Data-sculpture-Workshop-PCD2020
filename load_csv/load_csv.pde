/* 
Data sculpture Workshop at PCD 2020 by Henry Wang
this is a example how can we load csv file and list the data set into console
*/

Table table;

void setup() {
  table = loadTable("Activities.csv", "header");
  for (TableRow row : table.rows()) {
    String month = row.getString("Month");
    float walk = row.getFloat("Walk");
    float run = row.getFloat("Run");
    float cycle = row.getFloat("Cycle");
    println(month + ": " + walk + ", " + run + ", "  + cycle);
  }
}
