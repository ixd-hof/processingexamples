int last_time;
int interval = 1000;

void setup()
{
  
}

void draw()
{
  if (millis() - last_time >= interval)
  {
    println("interval");
    last_time = millis();
  }
}
