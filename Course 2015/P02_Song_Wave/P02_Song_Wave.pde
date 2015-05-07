import ddf.minim.*;

Minim minim;
AudioPlayer player;


void setup()
{
  size(1000, 500, P3D);
  smooth();

  minim = new Minim(this);
  player = minim.loadFile("02-My_Fair_Lady-05.mp3");

  player.loop();
}

void draw()
{
  background(0);
  
  // Display the level
  float mix_level = map(player.mix.level(), 0, 0.25, 0, 200);
  
  pushMatrix();
  translate(width/2, height/2);
  noFill();
  stroke(255);
  ellipse(0, 0, mix_level, mix_level);
  popMatrix();
  
  stroke(255, 0, 255);
  float[] audiobuffer = player.mix.toArray();
  for(int i = 0; i < audiobuffer.length; i+=1)
  {
    float mix = audiobuffer[i];
    float mix_y = map(mix, -10, 10, -height/2, height/2);
    pushMatrix();
    //translate(width/2, height/2);
    //rotate(radians(i));
    line(i, height/2, i, height/2-mix_y);
    //line(0, 0, 0, mix_y*5);
    popMatrix();
  }
}

