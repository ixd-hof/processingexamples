// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

class Fingers
{
  FingerTracker fingertracker;

  PApplet parent;
  int threshold = 625;
  int melt = 100;
  int crop = 200;
  int [] crop_depth = new int[crop*crop];
  boolean detect_hand = false;
  HashMap fingermap = new HashMap();
  PVector current_hand;

  Fingers(PApplet p, boolean only_hand)
  {
    parent = p;
    // Initialize finger tracker
    if (only_hand == false)
    {
      // for the whole camera image
      fingertracker = new FingerTracker(parent, 640, 480);
    }
    else
    {
      // only for a rectangle around the tracked hand
      fingertracker = new FingerTracker(parent, crop, crop);
    }
    // Define detection quality
    fingertracker.setMeltFactor(melt);

    detect_hand = only_hand;
  }

  void update(int[] depthMap, PVector hand)
  {
    current_hand = hand;
    
    // Detect hands grey and set threshold. Everything in the background is ignored.
    threshold = (int)current_hand.z+100;
    fingertracker.setThreshold(threshold);

    if (detect_hand == true)
    {
      // Extract hands area from depth map
      PImage hand_img = createImage(crop, crop, RGB);

      for (int cy=0; cy<crop; cy++)
      {
        for (int cx=0; cx<crop; cx++)
        {
          int ocx = (int)current_hand.x+cx;
          int ocy = (int)current_hand.y+cy;

          //text((current_hand.x-crop/2) + " " + (current_hand.x+crop/2) + " " + (current_hand.y-crop/2) + " " + (current_hand.y+crop/2), 20, 200);
          if (current_hand.x-crop/2 > 0 && current_hand.x+crop/2 < 640 && current_hand.y-crop/2 > 0 && current_hand.y+crop/2 < 480)
          {
            crop_depth[cy*crop+cx] = depthMap[((int)current_hand.y-crop/2+cy) * 640 + (int)current_hand.x-crop/2+cx];
          }
          else
          {
            crop_depth[cy*crop+cx] = 0;
          }
          hand_img.set(cx, cy, color(2048-crop_depth[cy*crop+cx]/8));
        }
      }

      // Detect fingertracker in this area
      fingertracker.update(crop_depth);
    }
    else
    {
      //fingertracker.setThreshold(600);
      fingertracker.update(depthMap);
    }

    // Return amount of fingertracker
    //return fingertracker.getNumfingertracker();
  }

  PVector[] get_fingers()
  {
    PVector[] finger_positions = new PVector[fingertracker.getNumFingers()];

    for (int i = 0; i < fingertracker.getNumFingers(); i++)
    {  
      finger_positions[i] = fingertracker.getFinger(i);
    }
    return finger_positions;
  }

  int count_fingers()
  {
    return fingertracker.getNumFingers();
  }

  void draw_fingers()
  {
    noStroke();
    fill(255, 100, 0);
    
    pushMatrix();
    translate(current_hand.x, current_hand.y);
    
    for (int i = 0; i < fingertracker.getNumFingers(); i++) {
      PVector position = fingertracker.getFinger(i);
      if (detect_hand == true)
        ellipse(position.x - 5 + current_hand.x - crop/2, position.y -5 + current_hand.y - crop/2, 10, 10);
      else
        ellipse(position.x - 5, position.y - 5, 10, 10);
    }
    
    popMatrix();
  }

  void draw_contour()
  {
    stroke(255, 0, 100);
    noFill();
    
    pushMatrix();
    translate(current_hand.x, current_hand.y);
    
    for (int k = 0; k < fingertracker.getNumContours(); k++) {
      fingertracker.drawContour(k);
    }
    
    popMatrix();
  }
}

