import processing.pdf.*;

void setup()
{
  size(400, 400, PDF, "filename.pdf");
}

void draw()
{
  background(200);
  
  for (int i=20; i<400; i+=20)
  {
    ellipse(i, height/2, 10, 10);
  }
  for (int j=20; j<400; j+=20)
  {
    ellipse(width/2, j, 10, 10);
  }
}

