import ddf.minim.*;

Minim minim;
AudioPlayer player;

void setup()
{
  size(800, 500, P3D);
  smooth();

  minim = new Minim(this);
  player = minim.loadFile("02-My_Fair_Lady-05.mp3");

  // Plays the file on start once
  //player.play();

  // Enables looping (never ends)
  player.loop();
}

void draw()
{
  background(0);
  
  float mix_level = map(player.mix.level(), 0, 0.25, 0, 200);
  
  translate(width/2, height/2);
  ellipse(0, 0, mix_level, mix_level);
}

