void setup()
{
  size(400, 400);
}

void draw()
{
  background(200);
  
  for (int i=20; i<390; i+=20)
  {
    ellipse(i, height/2, 10, 10);
  }
}


