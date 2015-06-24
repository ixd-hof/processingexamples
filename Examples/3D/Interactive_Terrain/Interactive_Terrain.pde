import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.math.*;
import toxi.processing.*;

int terrain_w = 51;
int terrain_h = 25;

Terrain terrain;
ToxiclibsSupport gfx;
Mesh3D mesh;
float[] el;

PGraphics tm;

void setup()
{
  size(1024, 576, P3D);

  // Initialize terrain map
  tm = createGraphics(terrain_w, terrain_h);
  tm.beginDraw();
  tm.background(0);
  tm.noStroke();
  tm.fill(100);
  tm.ellipse(terrain_w/2, terrain_h/2, 20, 20);
  tm.endDraw();

  // create terrain & generate elevation data
  terrain = new Terrain(terrain_w, terrain_h, 50);
  el = new float[terrain_w*terrain_h];
  for (int y=0, i=0; y<terrain_h; y++)
  {
    for (int x=0; x<terrain_w; x++)
    {
      el[i++] = -brightness(tm.get(x, y));
    }
  }
  terrain.setElevation(el);
  // create mesh
  mesh = terrain.toMesh();
  // attach drawing utils
  gfx = new ToxiclibsSupport(this);
}

void draw()
{
  background(0);

  fill(100);
  rect(0, 0, terrain_w, terrain_h);

  if (mousePressed)
  {
    if (mouseX < terrain_w && mouseY < terrain_h)
    {
      el[mouseX+mouseY*terrain_w] -=1;
      terrain.setElevation(el);
      mesh = terrain.toMesh();
    }
  }

  translate(200, 800, -800);
  fill(255);
  gfx.mesh(mesh, false);
}

