/*Steam Statistics - Programming Assignment
*/

void setup()
{
  size(1360,700);
  playerData = new ArrayList<Float>();
  String[] players = loadStrings("steam_stats_peak.prn");
  String[] titles = loadStrings("steam_stats_names.prn");
  ArrayList<Float> steam_stats_peakData = new ArrayList<Float>();
  
  
  for(int i=0;i<players.length;i++)
  {
    String data = players[i];
    
    for(String s:data.split(" "))
    {
  
      Float f = Float.parseFloat(s);
      playerData.add(f);
      
    //  steam_stats_peakData.add(f);
     }
    for( i =0;i<100;i++)
    {
       pointx = random(width);
       pointy = random(height);
    }  
  }
     
  
    //println( players[i]);
}

float pointx;
float pointy;
ArrayList<Float> playerData;
void draw()
{
  background(255);
for(int i = 0;i<100;i++)
  {
    float circle = ((playerData.get(i))/1000)-1;
    
    float r = random(255);
    float g = random(255);
    float b = random(255);
    println(circle);
    fill(r,g,b);
    stroke(r,g,b);
    ellipse(pointx,pointy,circle,circle);
  }
    
    
}
