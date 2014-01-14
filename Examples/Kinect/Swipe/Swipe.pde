void setup()
{
  size(500, 500);
}

void draw()
{
  check_swipe(mouseX, mouseY);
  /*
  if (swipe == "left")
  {
    println("swipe left");
  }
  else if (swipe == "right")
  {
    println("swipe right");
  }
  */
}

void swipe_event(String swipe)
{
  println(swipe);
  
  if (swipe == "left")
    println("do something left");
  else if (swipe == "right")
    println("do something right");
}
