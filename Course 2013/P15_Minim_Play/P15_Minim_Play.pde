import ddf.minim.*;

Minim minim;
AudioPlayer player;

void setup()
{
  size(512, 200, P3D);
  
  minim = new Minim(this);
  player = minim.loadFile("kick.mp3");
  
  // Plays the file on start once
  //player.play();
  
  // Enables looping (never ends)
  //player.loop();
}

void draw()
{
  for (int i=0; i<player.length(); i+=100)
  {
    
  }
  if (player.isPlaying() == true)
  {
    background(255, 100, 0);
  }
  else
  {
   background(0); 
  }
}

void mousePressed()
{
  // Rewinds player
  player.rewind();
  // Plays sample again
  player.play();
}
