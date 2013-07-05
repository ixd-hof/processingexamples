// http://wrongentertainment.github.io/MultitouchPadOsc/
// Enable OSC array active in Settings
// Currently download fixed version at: http://ixd-hof.de/wp-content/uploads/2013/07/MultitouchPadOscDebug.zip

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

PVector [] fingers = new PVector[0];

void setup() {
  size(500, 500);
  
  // Start listening for MultitouchPadOsc on port 12345
  oscP5 = new OscP5(this, 12345);
}

void draw()
{
  background(0);

  noFill();
  stroke(255);
  
  for (int i=0; i<fingers.length; i++)
  {
    ellipse(fingers[i].x*width, fingers[i].y*height, 20, 20);
  }
}


void oscEvent(OscMessage theOscMessage)
{
  //println(theOscMessage.addrPattern());
  if (theOscMessage.addrPattern().indexOf("mtpad") > -1)
  {
    String [] pattern = theOscMessage.addrPattern().split("/");
    //println(pattern[0] + " " + pattern[1] + " " + pattern[2] + " " + pattern[3]);

    int id = int(pattern[2]);
    String addr = pattern[3];
    
    if (addr.equals("xysa") == true)
    {
      float x = theOscMessage.get(0).floatValue();
      float y = theOscMessage.get(1).floatValue();
      float size = theOscMessage.get(2).floatValue();
      float angle = theOscMessage.get(3).floatValue();
      println(x + " " + y + " " + size);

      if (fingers.length < id + 1)
      {
        fingers = (PVector[])append(fingers, new PVector(x, y));
      }
      else
      {
        fingers[id].x = x;
        fingers[id].y = y;
      }
    }
    else if (addr.equals("removed") == true)
    {
      fingers = (PVector[])shorten(fingers);
    }
  }
}

