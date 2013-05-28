import ddf.minim.*;

Minim minim;
AudioInput in;

color bg;

void setup()
{
  size(512, 200, P3D);

  minim = new Minim(this);
  
  // Read the microphones sound
  in = minim.getLineIn();
}

void draw()
{
  background(bg);

  if (in.mix.level() > 0.1)
  {
    bg = color(random(255), random(255), random(255));
    println("snap");
  }
}
