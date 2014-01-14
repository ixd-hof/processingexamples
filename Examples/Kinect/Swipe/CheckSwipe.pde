int px, py;

int min_dist_x = 80;
int max_dist_y = 30;
int min_duration = 250;
int max_duration = 1000;

boolean swiping;
String swipe;
int swipe_start;

void check_swipe(int x, int y)
{
  String swipe_return = null;
  int dist_x = abs(x - px);
  int dist_y = abs(y - py);
  
  if (dist_x > min_dist_x && dist_y < max_dist_y)
  {
    if (swiping == false)
    {
      swiping = true;
      swipe_start = millis();
    }
    
    if (x > px)
      swipe = "right";
    else
      swipe = "left";
  }
  else
  {
    if (swiping == true)
    {
      swiping = false;
      swipe_event(swipe);
    }
  }
  
  px = x;
  py = y;
}
