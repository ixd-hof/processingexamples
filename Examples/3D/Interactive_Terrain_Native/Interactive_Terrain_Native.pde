int terrain_w = 51;
int terrain_h = 25;
int terrain_step = 10;

float[] el;

PGraphics tm;

void setup()
{
  size(1024, 576, P3D);

  el = new float[terrain_w*terrain_h];
}

void draw()
{
  background(0);

  fill(255, 100, 255);
  rect(0, 0, terrain_w, terrain_h);

  if (mousePressed)
  {
    if (mouseX < terrain_w && mouseY < terrain_h)
    {
      el[mouseX+mouseY*terrain_w] -=1;
    }
  }

  fill(255);
  translate(width/2-(terrain_w*terrain_step)/2, height/2+100, 0);
  beginShape(QUADS);
  for (int z=0; z<terrain_h-1; z+=1)
  {
    for (int x=0; x<terrain_w-1; x+=1)
    {
      vertex(x*terrain_step, el[x+z*terrain_w], z*terrain_step);
      vertex(x*terrain_step+terrain_step, el[x+1+z*terrain_w], z*terrain_step);
      vertex(x*terrain_step+terrain_step, el[x+1+(z+1)*terrain_w], z*terrain_step+terrain_step);
      vertex(x*terrain_step, el[x+(z+1)*terrain_w], z*terrain_step+terrain_step);
    }
  }
  endShape();
}

