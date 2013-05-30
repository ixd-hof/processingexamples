import ketai.camera.*;

KetaiCamera cam;

PVector touch = new PVector();

void setup()
{
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 320, 240, 24);
  
  noStroke();
}

void draw()
{
  background(0);
  
  if (millis() > 1000 && cam.isStarted() == false)
    cam.start();
  
  imageMode(CORNER);
  image(cam, 0, 0, width, height);
  
  int px = int(map(touch.x, 0, width, 0, cam.width));
  int py = int(map(touch.y, 0, height, 0, cam.height));
  
  PImage pxl = cam.get(px-2, py-2, 5, 5);
  imageMode(CENTER);
  image(pxl, touch.x, touch.y, 100, 100);
  
  //fill(cam.get((int)py, (int)py));
  //ellipse(touch.x, touch.y, 50, 50);
}

void mousePressed()
{
  touch.x = mouseX;
  touch.y = mouseY;
}

void onCameraPreviewEvent()
{
  cam.read();
}

