int terrain_w = 50;
int terrain_h = 25;
int terrain_step = 10;

float[] el;

PImage tm;

void setup()
{
  size(1024, 576, P3D);
  
  tm = loadImage("terrain.png");

  // Map brightness of pixels to height
  el = new float[terrain_w*terrain_h];
  for (int y=0, i=0; y<terrain_h; y++)
  {
    for (int x=0; x<terrain_w; x++)
    {
      el[i++] = -brightness(tm.get(x, y));
    }
  }
}

void draw()
{
  background(0);

  fill(255);
  translate(width/2-(terrain_w*terrain_step)/2, height/2+100, 0);
  beginShape(QUADS);
  textureMode(NORMAL);
  texture(tm);
  for (int z=0; z<terrain_h-1; z+=1)
  {
    for (int x=0; x<terrain_w-1; x+=1)
    {
      vertex(x*terrain_step, el[x+z*terrain_w], z*terrain_step, 1.0/terrain_w*x, 1.0/terrain_h*z);
      vertex(x*terrain_step+terrain_step, el[x+1+z*terrain_w], z*terrain_step, 1.0/terrain_w*(x+1), 1.0/terrain_h*z);
      vertex(x*terrain_step+terrain_step, el[x+1+(z+1)*terrain_w], z*terrain_step+terrain_step, 1.0/terrain_w*(x+1), 1.0/terrain_h*(z+1));
      vertex(x*terrain_step, el[x+(z+1)*terrain_w], z*terrain_step+terrain_step, 1.0/terrain_w*x, 1.0/terrain_h*(z+1));
    }
  }
  endShape();
}

