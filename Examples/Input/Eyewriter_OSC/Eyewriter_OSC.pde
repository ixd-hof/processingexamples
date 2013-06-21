import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int eye_x = 0;
int eye_x_smooth = 0;
int eye_y = 0;
int eye_y_smooth = 0;

float smooth_strength = 0.52; // 0.51 - 0.55 are working values

void setup() {
  size(displayWidth, displayHeight);
  // Start listening for Eyewriter on port 7401
  oscP5 = new OscP5(this, 7401);
}

void draw()
{
  background(0);
  
  eye_x_smooth += (eye_x - eye_x_smooth) / smooth_strength;
  eye_y_smooth += (eye_y - eye_y_smooth) / smooth_strength;
  
  noFill();
  stroke(255);
  ellipse(eye_x, eye_y, 20, 20);
  
  fill(255);
  ellipse(eye_x_smooth, eye_y_smooth, 20, 20);
}


void oscEvent(OscMessage theOscMessage)
{
  if (theOscMessage.checkAddrPattern("/eye/pos/x")==true)
  {
    eye_x = theOscMessage.get(0).intValue();
  }
  else if (theOscMessage.checkAddrPattern("/eye/pos/y")==true)
  {
    eye_y = theOscMessage.get(0).intValue();
  }
  //println(eye_x + " : " + eye_y);
}
