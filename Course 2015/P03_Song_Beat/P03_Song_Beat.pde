import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;

FFT fft;

BeatDetect beat;

void setup()
{
  size(1000, 500, P3D);
  smooth();

  minim = new Minim(this);
  player = minim.loadFile("02-My_Fair_Lady-05.mp3");

  fft = new FFT(player.bufferSize(), player.sampleRate());

  beat = new BeatDetect();

  player.loop();
}

void draw()
{
  beat.detect(player.mix);
  if ( beat.isOnset() == true)
  {
    background(255);
  } else
  {
    background(0);
  }

  // Display the level
  float mix_level = map(player.mix.level(), 0, 0.25, 0, 200);

  pushMatrix();
  translate(width/2, height/2);
  stroke(255);
  noFill();
  ellipse(0, 0, mix_level, mix_level);
  popMatrix();
}

