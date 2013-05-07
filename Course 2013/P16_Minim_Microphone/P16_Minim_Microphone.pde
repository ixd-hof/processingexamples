import ddf.minim.*;

Minim minim;
AudioInput in;

void setup()
{
  size(512, 200, P3D);

  minim = new Minim(this);
  
  // Read the microphones sound
  in = minim.getLineIn();
}

void draw()
{
  background(0);
  stroke(255);
  noFill();
  
  rectMode(CENTER);
  
  // Display the waveform
  // bufferSize = 1024
  // values are about -10 - +10
  // Audioinput delivers mix, left, right
  for(int i = 0; i < in.bufferSize() - 1; i+=2)
  {
    float mix = in.mix.get(i);
    float mix_y = map(mix, -10, 10, -height/2, height/2);
    rect(i/2, height/2, 1, mix_y);
  }
  
  // Display the level
  float mix_level = map(in.mix.level(), 0, 0.25, 0, height/2);
  ellipse(width/2, height/2, mix_level, mix_level);
}
