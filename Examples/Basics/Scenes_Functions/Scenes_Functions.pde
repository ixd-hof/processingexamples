int scene = 0;
int scene_max = 3;

void setup()
{
  size(500, 500);
  textSize(75);
  textAlign(CENTER, CENTER);
}

void draw()
{
  if (scene == 0)
  {
    scenestart();
  }
  else if (scene == 1)
  {
    scene01();
  }
  else if (scene == 2)
  {
    scene02();
  }
  else if (scene == 3)
  {
    sceneend();
  }
}

void mousePressed()
{
 if (scene < scene_max)
   scene ++;
}
