// filtering factor (low = slow & smooth)
float filteringFactor = 0.1;

float filtered_x = 0;
float filtered_y = 0;

void setup()
{
  size(500, 500);
}

void draw()
{
  background(255);

  // low pass filter
  filtered_x = mouseX * filteringFactor + filtered_x * (1.0 - filteringFactor);
  filtered_y = mouseY * filteringFactor + filtered_y * (1.0 - filteringFactor);
  
  // filtered motion
  noFill();
  stroke(0);
  ellipse(filtered_x, filtered_y, 50, 50);
  
  // raw mouse position
  fill(0);
  ellipse(mouseX, mouseY, 45, 45);
}