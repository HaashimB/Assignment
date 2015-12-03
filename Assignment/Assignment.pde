import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

/*Steam Statistics - Programming Assignment
*/
Minim minim;
AudioPlayer player;
void setup()
{
  size(1360,700,P3D);
  smooth(4);
  font = loadFont("Tahoma-72.vlw");
  minim = new Minim(this);
  musicFile = "steam_music.mp3";
  
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
  
  steam = loadImage("steam.jpg");
  
  circleColor = color(255);
  circleX = width/2;
  circleY = height/2+150;
  ellipseMode(CENTER);
  

}

PFont font;


ArrayList<Circle_Data> playerData;
int linesGlobal;
int screen = 1;
float [] locationx;
float [] locationy;
float[] r;
float[] g;
float[] b;
float x,y,z;
PImage steam;

int circleX, circleY;  // Position of circle button  
int circleSize = 93;   // Diameter of circle
color circleColor,circleOutline;
boolean circleOver = false;
boolean[] onCircle = new boolean[10];

String musicFile;
Music music = new Music();
void draw()
{
  update(mouseX, mouseY);
  
  background(255);
  if (screen == 1)
  {
    image(steam,0,0);
    steam.resize(width, height);
    musicPlay(musicFile);
    textAlign(CENTER);
    textFont(font);
    fill(200,230,255);
    text("Main Menu",width/2,height/8);
    
    noStroke();
    if (circleOver) 
    {
      circleColor = color(0,100,230);
      circleOutline = color(200,230,255);
      if(mousePressed)
      {
        screen = 0;
      }
    } 
    else 
    {
      circleColor = color(215,230,240);
      circleOutline = color(0,100,230);
    }
  
    stroke(circleOutline);
    fill(circleColor);
    ellipse(circleX, circleY, circleSize, circleSize);
  }
  if (screen == 0)
  {
    update1(mouseX, mouseY);
    translate(x,y,z);
    for(int i = 0;i<linesGlobal;i++)
    {
      fill(r[i],g[i],b[i]);
      noStroke();
      ellipse(locationx[i],locationy[i],playerData.get(i).players/10000,playerData.get(i).players/10000);

      
    }
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
      if(z<=-500)
      {
        z=-500;
      }
    }
    if(key == 'm')
    {
      screen = 1;
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

void update(int x, int y) 
{
  if( overCircle(circleX, circleY, circleSize) )
  {
    circleOver = true;
  }
  else
  {
    circleOver = false;
  }
 
}

boolean overCircle(int x, int y, int diameter)
{
  float disX = x - mouseX;
  float disY = y - mouseY;
  if(sqrt(sq(disX) + sq(disY)) < diameter/2 ) 
  {
    return true;
  } 
  else
  {
    return false;
  }
} 

void update1(int x, int y) 
{
 boolean circleChecker = false;
  for(int i = 0; i<linesGlobal; i++)
  {
    circleChecker = overCircle1(locationx[i],locationy[i],playerData.get(i).players/10000);
    if(circleChecker)
    {
      onCircle[i] = true;
    }
    else
    {
      onCircle[i] = false;
    }
  }
}

boolean overCircle1(float x, float y, float diameter)
{
  float disX = x - mouseX;
  float disY = y - mouseY;
  if(sqrt(sq(disX) + sq(disY)) < diameter/2 ) 
  {
    return true;
  } 
  else
  {
    return false;
  }
} 
void musicPlay(String musicAddress)
{
  
  player = minim.loadFile(musicAddress, 2048);
  player.play();
 
}
