import ddf.minim.*;

Minim minim;
AudioPlayer player;
AudioPlayer gameMusic;
void setup()
{

  size(1360, 700, P3D);
  smooth(4);
  font = loadFont("Tahoma-72.vlw");
  minim = new Minim(this);
  gameMusic = minim.loadFile("DOTA2.mp3");
  player = minim.loadFile("steam_music.mp3");
  playerData = new ArrayList<Circle_Data>();
  readInCircleData();

  locationx = new float[linesGlobal];
  locationy = new float[linesGlobal];

  r = new float[linesGlobal];
  g = new float[linesGlobal];
  b = new float[linesGlobal];

  for (int i = 0; i<linesGlobal; i++)
  {
    locationx[i] = random(100, width-100);
    locationy[i] = random(100, height-50);
    r[i] = random(150, 255);
    g[i] = random(150, 255);
    b[i] = random(150, 255);
  }

  steam = loadImage("steam.jpg");
  h3 = loadImage("h3.jpg");
  circleColor = color(255);
  circleX = width*0.5;
  circleY = height*0.8;
  circleA = width*0.3;
  circleB = height*0.8;
  ellipseMode(CENTER);
}

PFont font;

ArrayList<Circle_Data> playerData;
int linesGlobal;
int screen = 0;
int game = 10;
float [] locationx;
float [] locationy;
float[] r;
float[] g;
float[] b;
float x, y, z;
PImage steam, h3;
PImage pic;
float screenSize;
float circleX, circleA;
float circleY, circleB;  // Position of circle button  
int circleSize = 93;   // Diameter of circle
int circleSize1 = 93;
color circleColor, circleColor1, circleColor2, circleOutline, circleOutline2;
boolean circleOver, circleOver1;
boolean[] onCircle = new boolean[10];
int info = 0;
int infoClose = 0;
boolean circleClicked;
color textcol, textcol1;
void draw()
{

  if (circleClicked)
  {
    screenSize = width*0.7;
    circleClicked = false;
  }

  if (screen == 0)
  {
    update(mouseX, mouseY);
    update2(mouseX, mouseY);
    stopMusic();
    game = 10;
    player.play();
    image(steam, 0, 0);
    steam.resize(width, height);
    textAlign(CENTER);
    textFont(font);
    fill(200, 230, 255);
    text("Main Menu", width/2, height/8);

    noStroke();
    if (circleOver) 
    {
      circleColor = color(0, 100, 230);
      circleOutline = color(200, 230, 255);
      textcol = color(215, 230, 240);
      if (mousePressed)
      {
        screen = 1;
      }
    }
    if (circleOver1)
    {
      circleColor2 = color(0, 100, 230);
      circleOutline2 = color(200, 230, 255);
      textcol1 = color(215, 230, 240);
      if (mousePressed)
      {
        screen = 2;
      }
    } 
    if (!circleOver)
    {
      circleColor = color(215, 230, 240);
      circleOutline = color(0, 100, 230);
      textcol = color(0, 100, 230);
    } 
    if (!circleOver1)
    {
      circleColor2 = color(215, 230, 240);
      circleOutline2 = color(0, 100, 230);
      textcol1 = color(0, 100, 230);
    }
    if (mouseX>width/2+40 && mouseX<width/2+90 && mouseY>height/5+40 && mouseY<height/5+90)//Easter Egg
    {
      image(h3, 0, 0);
      h3.resize(width, height);
    }
    stroke(circleOutline);
    fill(circleColor);
    ellipse(circleX, circleY, circleSize, circleSize);
    fill(textcol);
    textSize(20);
    text("Circle\nGraph", width*0.5, height*0.79);
    stroke(circleOutline2);
    fill(circleColor2);
    ellipse(circleA, circleB, circleSize1, circleSize1);
    fill(textcol1);
    text("Line\nGraph", width*0.3, height*0.79);
  }
  if (screen == 1)
  {
    background(100);
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text("Top Steam Games By Player Base - Circle Graph", width/2, height/25);
    textAlign(LEFT);
    textSize(20);
    text("[I] Info", width*0.01, height*0.03);
    text("[M] Main Menu", width*0.01, height*0.06);
    text("[C] Close Window", width*0.01, height*0.09);
    player.pause();
    player.rewind();
    update1(mouseX, mouseY);

    for (int i = 0; i<linesGlobal; i++)
    {

      if (onCircle[i] && game == 10) 
      {
        circleColor1 = color(0, 100, 230);
        if (mousePressed)
        {
          game = i;
        }
      } else 
      {
        circleColor1 = color(r[i], g[i], b[i]);
      }
      fill(circleColor1);
      noStroke();
      ellipse(locationx[i], locationy[i], playerData.get(i).players/10000, playerData.get(i).players/10000);
    }

    pushMatrix();
    translate(width-screenSize, 0);
    gameScreen();
    popMatrix();
  }

  if (screen == 2)
  {
    player.pause();
    player.rewind();
    background(100);
    textSize(30);
    fill(255);
    textAlign(CENTER);
    text("Top Steam Games By Player Base - Line Graph", width/2, height/25);
    textAlign(LEFT);
    textSize(20);
    text("[M] Main Menu", width*0.01, height*0.06);
  }

  if (info == 1)
  {
    pushMatrix();
    translate(-150, -200);
    infoScreen();
    popMatrix();
  }
}

void readInCircleData()
{
  String[] lines = loadStrings("steam_stats_.csv");

  for (int i = 0; i<lines.length; i++)
  {

    playerData.add(new Circle_Data(lines[i])); 
    println(playerData.get(i).titles + " " + playerData.get(i).players);
    linesGlobal++;
  }
}

void update(int x, int y) 
{

  if (overCircle(circleX, circleY, circleSize))
  {
    circleOver = true;
  } else
  {
    circleOver = false;
  }
}

void update2(int x, int y) 
{

  if (overCircle(circleA, circleB, circleSize1))
  {
    circleOver1 = true;
  } else
  {
    circleOver1 = false;
  }
} 

boolean overCircle(float x, float y, int diameter)
{
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) 
  {
    return true;
  } else
  {
    return false;
  }
} 

void update1(int x, int y) 
{
  boolean circleChecker = false;
  for (int i = 0; i<linesGlobal; i++)
  {
    circleChecker = overCircle1(locationx[i], locationy[i], playerData.get(i).players/10000);
    if (circleChecker)
    {
      onCircle[i] = true;
    } else
    {
      onCircle[i] = false;
    }
  }
}

boolean overCircle1(float x, float y, float diameter)
{
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) 
  {
    return true;
  } else
  {
    return false;
  }
} 

int soundStart = 0;
void startMusic()
{
  if (soundStart == 0)
  {
    gameMusic.play();
    soundStart = 1;
  }
}

void stopMusic()
{
  if (soundStart == 1)
  {
    gameMusic.pause();
    gameMusic.rewind();
    soundStart = 0;
  }
}
void infoScreen()
{
  fill(0);
  rect(width/2-10, height/2-10, 320, 220);
  fill(255); 
  rect(width/2, height/2, 300, 200);
  fill(0);
  textAlign(CENTER);
  text("Information", width/2+150, height/2+20);
  textSize(12);
  textAlign(LEFT);
  text("Welcome, each circle represents a different game, the\nbigger the circle, the bigger that game's player base", width/2+10, height/2+60);
  text("Click a circle to see what game it represents.\nPress 'C' to close the game's window.", width/2+10, height/2+90);
  infoClose = 1;
}
void gameScreen()
{


  if (game == 0)
  {
    circleClicked = true;
    if (soundStart == 0)
    {
      gameMusic = minim.loadFile("DOTA2.mp3");
    }
    startMusic();
    pic = loadImage("DOTA2.jpg");

    fill(50, 10, 0);
    rect(0, 0, width, height);
    image(pic, width/3-300, height/25);
    fill(255);
    textAlign(LEFT);
    text("Dota 2 is a free-to-play multiplayer online battle arena (MOBA) video game developed and published\nby Valve Corporation. Released for Microsoft Windows, OS X, and Linux in July 2013, following a\nWindows-only public beta testing phase that began in 2011, the game is the stand-alone sequel to Defense\nof the Ancients (DotA), a mod for Warcraft III: Reign of Chaos, and its expansion pack, The Frozen Throne.\nDota 2 is one of the most actively played games on Steam, with it having a peak of over a million concurrent\nplayers in February and March 2015.", width*0.01, height*0.6);
    text("Peak Players: " + playerData.get(0).players, width*0.01, height*0.9);
  }
  if (game == 1)
  {
    circleClicked = true;
    if (soundStart == 0)
    {
      gameMusic = minim.loadFile("CSGO.mp3");
    }
    startMusic();
    pic = loadImage("CSGO.jpg");


    fill(35, 30, 30);
    rect(0, 0, width, height);
    image(pic, width/3-300, height/25);
    fill(255);
    textAlign(LEFT);
    text("Counter-Strike: Global Offensive (CS:GO) is an online first-person shooter developed by Hidden Path\nEntertainment and Valve Corporation. It is the fourth game in the main Counter-Strike franchise.\nCounter-Strike: Global Offensive was released on August 21, 2012, and made available for Microsoft\nWindows and OS X on Steam, Xbox 360, and a United States-only version on PlayStation 3.The Linux version\nwas released in September 2014. It features classic content, such as revamped versions of classic maps, as\nwell as brand new maps, characters and game modes.", width*0.01, height*0.6);
    text("Peak Players: " + playerData.get(1).players, width*0.01, height*0.9);
  }
  if (game == 2)
  {
    circleClicked = true;
    if (soundStart == 0)
    {
      gameMusic = minim.loadFile("Fallout4.mp3");
    }
    startMusic();
    pic = loadImage("Fallout4.jpg");


    fill(0);
    rect(0, 0, width, height);
    image(pic, width/3-300, height/25);
    fill(255);
    textAlign(LEFT);
    text("Fallout 4 is an open world action role-playing video game developed by Bethesda Game Studios and\npublished by Bethesda Softworks. The fifth major installment in the Fallout series. Fallout 4\nis set in a post-apocalyptic Boston in the year 2287, 210 years after a devastating nuclear war, in which\nthe player character emerges from an underground bunker known as a Vault. The player completes various\nquests and acquires experience points to level up their character.", width*0.01, height*0.6);
    text("Peak Players: " + playerData.get(2).players, width*0.01, height*0.9);
  }
  if (game == 3)
  {
    circleClicked = true;
    if (soundStart == 0)
    {
      gameMusic = minim.loadFile("GTAV.mp3");
    }
    startMusic();
    pic = loadImage("GTAV.jpg");


    fill(0);
    rect(0, 0, width, height);
    image(pic, width/3-300, height/25);
    fill(255);
    textAlign(LEFT);
    text("Grand Theft Auto V is an open world, action-adventure video game developed by Rockstar North and\npublished by Rockstar Games. The game is the first main entry in the Grand Theft Auto series since\n2008's Grand Theft Auto IV. Set within the fictional state of San Andreas, based on Southern California,\nthe single-player story follows three criminals and their efforts to commit heists while under pressure\nfrom a government agency. The open world design lets players freely roam San Andreas's open countryside\nand fictional city of Los Santos, based on Los Angeles.", width*0.01, height*0.6);
    text("Peak Players: " + playerData.get(3).players, width*0.01, height*0.9);
  }
  if (game == 4)
  {

    circleClicked = true;
    if (soundStart == 0)
    {
      gameMusic = minim.loadFile("TF2.mp3");
    }
    startMusic();
    pic = loadImage("TF2.png");


    fill(255);
    rect(0, 0, width, height);
    image(pic, width/3-250, height/10);
    fill(0);
    textAlign(LEFT);
    text("Team Fortress 2 is a team-based first-person shooter multiplayer video game developed by Valve\nCorporation. It is the sequel to the 1996 mod Team Fortress for Quake and its 1999 remake. In Team\nFortress 2, players join one of two teams comprising nine character classes, battling in a variety of game\nmodes including capture the flag and king of the hill. The development is led by John Cook and Robin\nWalker, creators of the original Team Fortress. Announced in 1998, the game once had more realistic,\nmilitaristic visuals and gameplay, but this changed over the protracted nine-year development.", width*0.01, height*0.6);
    text("Peak Players: " + playerData.get(4).players, width*0.01, height*0.9);
  }
  if (game == 5)
  {
    circleClicked = true;
    if (soundStart == 0)
    {
      gameMusic = minim.loadFile("ARK.mp3");
    }
    startMusic();
    pic = loadImage("ARK.png");


    fill(230);
    rect(0, 0, width, height);
    image(pic, width/3-225, height/25);
    fill(0);
    textAlign(LEFT);
    text("Ark: Survival Evolved (stylized as ARK: Survival Evolved) is an action-adventure survival video game\ndeveloped by Studio Wildcard, Instinct Games, Efecto Studios and Virtual Basement. In the game,\nplayers must survive in a world filled with roaming dinosaurs, natural hazards, and potentially hostile\nhuman players. The game is played from either a third-person or first-person view and its world is\nnavigated on foot or by riding a dinosaur. Players use firearms and improvised weapons to defend against\nhostile humans and creatures, with the ability to build bases as defense.", width*0.01, height*0.6);
    text("Peak Players: " + playerData.get(5).players, width*0.01, height*0.9);
  }
  if (game == 6)
  {
    circleClicked = true;
    if (soundStart == 0)
    {
      gameMusic = minim.loadFile("FM.mp3");
    }
    startMusic();
    pic = loadImage("FM.jpg");


    fill(0, 40, 80);
    rect(0, 0, width, height);
    image(pic, width/3-300, height/25);
    fill(255);
    textAlign(LEFT);
    text("Football Manager 2016 (abbreviated to FM16) is a football management simulation video game developed\nby Sports Interactive and published by Sega. Football Manager 2016 is a sports simulation game.\nPlayers can now customize the appearances of their manager on the pitch. Two new modes are introduced in\nFM2016, including the Fantasy Draft mode, in which multiple players can play together, and draft players\nwith a fixed budget. The second mode is called Create-A-Club, originated from the Editor version of the game\nbut was now included in the final game.", width*0.01, height*0.6);
    text("Peak Players: " + playerData.get(6).players, width*0.01, height*0.9);
  }
  if (game == 7)
  {
    circleClicked = true;
    if (soundStart == 0)
    {
      gameMusic = minim.loadFile("CivV.mp3");
    }
    startMusic();
    pic = loadImage("CivV.jpg");


    fill(240);
    rect(0, 0, width, height);
    image(pic, width/3-240, height/25);
    fill(0);
    textAlign(LEFT);
    text("Sid Meier's Civilization V is a 4X video game in the Civilization series developed by Firaxis Games.\nIn Civilization V, the player leads a civilization from prehistoric times into the future on a procedurally\ngenerated map, achieving one of a number of different victory conditions through research, exploration,\n diplomacy, expansion, economic development, government and military conquest. The game is based\non an entirely new game engine with hexagonal tiles instead of the square tiles of earlier games in\nthe series.", width*0.01, height*0.6);
    text("Peak Players: " + playerData.get(7).players, width*0.01, height*0.9);
  }
  if (game == 8)
  {
    circleClicked = true;
    if (soundStart == 0)
    {
      gameMusic = minim.loadFile("CH.mp3");
    }
    startMusic();
    pic = loadImage("CH.png");


    fill(30, 170, 230);
    rect(0, 0, width, height);
    image(pic, width/3-250, height/25);
    fill(100);
    textAlign(LEFT);
    text("Clicker Heroes is an idle game developed by Playsaurus, originally released in July 2014. Clicker Heroes\nis a free-to-play video game with micro-transactions, but are not required to continue with the game.\nIn Clicker Heroes, the player must click on the enemy on the right of the screen to damage it and\neventually kill it. Once killed, it will drop gold (which can change depending on the level the player\nis at and if the enemy is a boss) which can be used to upgrade and purchase characters.", width*0.01, height*0.6);
    text("Peak Players: " + playerData.get(8).players, width*0.01, height*0.9);
  }
  if (game == 9)
  {
    circleClicked = true;
    if (soundStart == 0)
    {
      gameMusic = minim.loadFile("WarFrame.mp3");
    }
    startMusic();
    pic = loadImage("WarFrame.png");


    fill(240);
    rect(0, 0, width, height);
    image(pic, width/3-270, height/25);
    fill(0);
    textAlign(LEFT);
    text("Warframe is a free-to-play cooperative third-person shooter video game developed by Digital Extremes\nfor Microsoft Windows, PlayStation 4 and Xbox One. Equipment can be earned through gameplay or\nbought with premium currency called Platinum. Most cosmetics and boosts can only be purchased with\npremium currency. The game is free to download and play. In Warframe, players control members of the\nTenno, a race of ancient warriors who have awoken from centuries of cryosleep to find themselves at war\nwith the Grineer, a race of militarized humanoid clones.", width*0.01, height*0.6);
    text("Peak Players: " + playerData.get(9).players, width*0.01, height*0.9);
  } 
  if (game == 10)
  {
    stopMusic();
  }
}

void keyPressed()
{
  if ( screen == 1)
  {
    if (key == 'i' || key == 'I')
    {
      info = 1;
      if (infoClose == 1)
      {
        info = 0;
        infoClose = 0;
      }
    }
    if (game!=10)
    {
      if (key == 'c')
      {
        game = 10;
      }
    }
  }
  if (screen ==1 || screen == 2)
  {
    if (infoClose == 0)
    {
      if (key == 'm')
      {
        screen = 0;
      }
    }
  }
}

