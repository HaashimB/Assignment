/*Steam Statistics - Programming Assignment
*/

void setup()
{
  size(1360,700);
  playerData = new ArrayList<Circle_Data>();
  readInCircleData();
  
}

ArrayList<Circle_Data> playerData;
void draw()
{
  background(255);
    
}

void readInCircleData()
{
 String[] lines = loadStrings("steam_stats_.csv");
 
 for(int i = 0;i<lines.length;i++)
 {
   playerData.add(new Circle_Data(lines[i])); 
   println(playerData.get(i).titles + " " + playerData.get(i).players);
 }
 
 
}
