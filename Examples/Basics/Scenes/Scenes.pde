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
    background(0);
    text("Click to start", width/2, height/2);
  }
  else if (scene == 1)
  {
    background(75);
    text("Scene 1", width/2, height/2);
  }
  else if (scene == 2)
  {
    background(150);
    text("Scene 2", width/2, height/2);
  }
  else if (scene == 3)
  {
    background(225);
    text("Done!", width/2, height/2);
  }
}

void mousePressed()
{
 if (scene < scene_max)
   scene ++;
}
