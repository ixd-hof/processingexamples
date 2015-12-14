import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

// Depth image
PImage depthImg;

PVector t0, t1;
int time0, time1;
boolean bool0, bool1;

void setup() {
  size(640, 480);

  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.initVideo();

  t0 = new PVector(150, height/2);
  t1 = new PVector(width-150, height/2);
}

void draw() {
  // Draw the raw image
  image(kinect.getVideoImage(), 0, 0);

  noFill();
  stroke(255, 0, 0);
  ellipse(t0.x, t0.y, 20, 20);
  ellipse(t1.x, t1.y, 20, 20);

  float d0 = brightness(kinect.getDepthImage().get(int(t0.x), int(t0.y)));
  float d1 = brightness(kinect.getDepthImage().get(int(t1.x), int(t1.y)));

  text(d0, t0.x, t0.y);
  text(d1, t1.x, t1.y);

  // closest point
  /*
  PVector dmax = new PVector(-1, -1);
  float max = 0;
  for (int y=0; y<480; y++)
  {
    for (int x=0; x<640; x++)
    {
      float d = brightness(kinect.getDepthImage().get(x, y));
      if (d > max)
      {
        max = d;
        dmax = new PVector(x, y);
      }
    }
  }
  ellipse(dmax.x, dmax.y, 10, 10);
  */

  //println(max + " " + dmax);

  int tres = 150;

  if (d0 > tres)
  {
    time0 = millis();
    bool0 = true;
    bool1 = false;
  }
  
  if (d1 > tres)
  {
    if (bool0 == true)
    {
      time1 = millis();
      bool0 = false;
      bool1 = true;
      println(time1-time0);
    }
  }
}

/*
void mousePressed()
 {
 t0.x = mouseX;
 t0.y = mouseY;
 }
 */