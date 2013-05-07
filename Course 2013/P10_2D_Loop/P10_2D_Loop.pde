void setup()
{
  size(360, 360);
  colorMode(HSB, 360, 100, 100);
}

void draw()
{
  background(200);

  for (int i=20; i<=340; i+=20)
  {
    for (int j=20; j<=340; j+=20)
    {
      //fill(i, j, 100);
      ellipse(i, j, 10, 10);
    }
  }
}

