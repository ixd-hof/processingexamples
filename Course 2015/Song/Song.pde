import ddf.minim.*;

Minim minim;
AudioPlayer player;

PShape hand;

void setup()
{
  size(800, 500, P3D);
  smooth();

  minim = new Minim(this);
  player = minim.loadFile("sonemusik.mp3");

  // Plays the file on start once
  player.play();

  // Enables looping (never ends)
  //player.loop();
  
  hand = loadShape("hand.svg");
}

void draw()
{
  background(200);
  
  // Displa0 the level
  float mix_level = map(player.mix.level(), 0, 0.25, 0, 2);
  
  translate(width/2, height/2);
  
  //rotateY(millis()/1000.0);
  
  pushMatrix();
  scale(mix_level);
  noFill();
  stroke(234, 33, 234);
  //triangle(-55, 50, 0, -50, 55, 50);
  
  /*
  beginShape(TRIANGLE_STRIP);
  vertex(50, 50, 50);
  vertex(-50, -50, 50);
  vertex(-50, 50, -50);
  vertex(50, -50, -50);
  vertex(50, 50, 50);
  vertex(-50, -50, 50);
  endShape(CLOSE);
  */
  
  shape(hand, 200, 0);
  scale(-1, 1);
  shape(hand, 200, 0);
  
  
  popMatrix();
}

void mousePressed()
{
}

