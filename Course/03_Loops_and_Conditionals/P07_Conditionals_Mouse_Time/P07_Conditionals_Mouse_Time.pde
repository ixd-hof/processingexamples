// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// Reading states and values

void setup()
{
  size(400, 400);
}

void draw()
{
  // if the mouse is pressed (true)
  if (mousePressed == true)
  {
    println("mouse pressed");
  }
  
  // if current time's seconds value (0-59) is smaller than 30
  if (second() < 30)
  {
    println(second() + " smaller than 30");
  }
  // if it's larger or equal 30
  else if (second() >= 30)
  {
    println(second() + " larger than or equal 30");
  }

}
