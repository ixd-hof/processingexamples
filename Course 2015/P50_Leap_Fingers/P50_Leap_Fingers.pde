import com.leapmotion.leap.Controller;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Frame;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.processing.LeapMotion;

LeapMotion leapMotion;
Controller controller;

void setup()
{
  size(500, 500, P3D);

  leapMotion = new LeapMotion(this);
}

void draw()
{
  background(255);

  translate(width/2, height/2);

  controller = leapMotion.controller();
  Frame frame = controller.frame();
  if (frame.hands().count() > 0)
  {
    Hand hand = frame.hands().frontmost();

    for (int i=0; i<hand.fingers ().count(); i++)
    {
      Finger finger = hand.fingers().get(i);
      if (finger.isExtended())
      {
        float x = finger.tipPosition().getX();
        float y = -finger.tipPosition().getY();
        float z = finger.tipPosition().getZ();
        
        pushMatrix();
        fill(255);
        translate(x, y, z);
        ellipse(0, 0, 20, 20);
        popMatrix();
      }
    }
  }
}

