import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;

FFT fft;

void setup()
{
  size(1000, 500, P3D);
  smooth();

  minim = new Minim(this);
  player = minim.loadFile("02-My_Fair_Lady-05.mp3");

  fft = new FFT(player.bufferSize(), player.sampleRate());

  player.loop();
}

void draw()
{
  background(0);

  // Display the level
  float mix_level = map(player.mix.level(), 0, 0.25, 0, 200);

  pushMatrix();
  translate(width/2, height/2);
  stroke(255);
  noFill();
  ellipse(0, 0, mix_level, mix_level);
  popMatrix();

  fft.forward(player.mix);
  stroke(0, 100, 255);
  fill(255, 0, 0, 128);
  for (int i=0; i<fft.specSize(); i++)
  {
    float band = fft.getBand(i);
    line(i, height, i, height - band * 4);
  }
}
