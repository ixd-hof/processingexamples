void setup()
{
  size(500, 500);
  rectMode(CENTER);
  noFill();
  background(255);
}

void draw()
{
  //background(255);
  translate(250, 250);
  rotate(millis()/100.0);
  rect(0, 0, 250, 250);
}

