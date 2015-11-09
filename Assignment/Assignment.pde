/*Steam Statistics - Programming Assignment
*/

void setup()
{
  size(1360,700,P3D);
  playerData = new ArrayList<Circle_Data>();
  readInCircleData();
  locationx = new float[linesGlobal];
  locationy = new float[linesGlobal];
  r = new float[linesGlobal];
  g = new float[linesGlobal];
  b = new float[linesGlobal];
  
  for(int i = 0;i<linesGlobal;i++)
  {
    locationx[i] = random(0,width);
    locationy[i] = random(0,height);
    r[i] = random(0,255);
    g[i] = random(0,255);
    b[i] = random(0,255);
  }
}

ArrayList<Circle_Data> playerData;
int linesGlobal;

float [] locationx;
float [] locationy;
float[] r;
float[] g;
float[] b;
float x,y,z;
void draw()
{
  background(255);
  translate(x,y,z);
  for(int i = 0;i<linesGlobal;i++)
  {
    fill(r[i],g[i],b[i]);
    stroke(r[i],g[i],b[i]);
    ellipse(locationx[i],locationy[i],playerData.get(i).players/1000,playerData.get(i).players/1000);
  }
  if (keyPressed)
  {
    if(key =='w')
    {
      y+=10;
    }
    if(key =='s')
    {
      y-=10;
    }
    if(key =='a')
    {
      x+=10;
    }
    if(key =='d')
    {
      x-=10;
    }
    if(key =='o')
    {
      z+=10;
      if(z>=500)
      {
        z=500;
      }
    }
    if(key =='l')
    {
      z-=10;
    }
    
  }
    
}

void readInCircleData()
{
 String[] lines = loadStrings("steam_stats_.csv");

 for(int i = 0;i<lines.length;i++)
 {
 
   playerData.add(new Circle_Data(lines[i])); 
   println(playerData.get(i).titles + " " + playerData.get(i).players);
   linesGlobal++;
 }
 
 
}
