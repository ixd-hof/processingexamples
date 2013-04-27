void setup()
{
  size(500, 500);
  rectMode(CENTER);
}

void draw()
{

  rect(100, 100, 50, 50);

  translate(100, 100);
  rect(0, 0, 50, 50);
  
  translate(100, 100);
  rect(0, 0, 50, 50);
  
  translate(100, 100);
  rotate(0.78); //radians(45)
  rect(0, 0, 50, 50);
  
  translate(100, 100);
  rect(0, 0, 50, 50);
}

