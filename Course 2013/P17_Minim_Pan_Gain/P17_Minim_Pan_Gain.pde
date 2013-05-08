import ddf.minim.*;

Minim minim;
AudioPlayer player;

void setup()
{
  size(512, 200, P3D);
  
  minim = new Minim(this);
  player = minim.loadFile("02-My_Fair_Lady-05.mp3");
  
  // Plays the file on start once
  player.play();
  
  // Enables looping (never ends)
  player.loop();
}

void draw()
{
  background(0);
  
  // Map mouse X to pan (left, right -> -1, 1)
  float pan = map(mouseX, 0, width, -1, 1);
  player.setPan(pan);
  
  // Map mouseY to gain / level
  // gain 0 is the regular level of the sound file
  // Setting gain is relative to the regular level
  float gain = map(mouseY, 0, height, -20, 10);
  player.setGain(gain);
  
  // Display the sound level
  stroke(255);
  noFill();
  float mix_level = map(player.mix.level(), 0, 0.4, 0, height/2);
  ellipse(mouseX, mouseY, mix_level, mix_level);
}
