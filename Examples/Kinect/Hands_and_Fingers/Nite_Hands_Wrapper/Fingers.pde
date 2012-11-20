FingerTracker fingers;

int threshold = 625;
int melt = 150;
int crop = 150;
int [] crop_depth = new int[crop*crop];
boolean detect_hand = false;

void init_fingers(boolean only_hand)
{
  // Initialize finger tracker
  if (only_hand == false)
  {
    // for the whole camera image
    fingers = new FingerTracker(this, 640, 480);
  }
  else
  {
    // only for a rectangle around the tracked hand
    fingers = new FingerTracker(this, crop, crop);
  }
  // Define detection quality
  fingers.setMeltFactor(melt);

  detect_hand = only_hand;
}

void fingers_update(int[] depthMap)
{
  // Detect hands grey and set threshold. Everything in the background is ignored.
  threshold = (int)currentHand.z+100;
  fingers.setThreshold(threshold);

  if (detect_hand == true)
  {
    // Extract hands area from depth map
    PImage hand_img = createImage(crop, crop, RGB);

    for (int cy=0; cy<crop; cy++)
    {
      for (int cx=0; cx<crop; cx++)
      {
        int ocx = (int)currentHand.x+cx;
        int ocy = (int)currentHand.y+cy;
        crop_depth[cy*crop+cx] = depthMap[((int)currentHand.y-crop/2+cy) * 640 + (int)currentHand.x-crop/2+cx];
        hand_img.set(cx, cy, color(2048-crop_depth[cy*crop+cx]/8));
      }
    }

    // Detect fingers in this area
    fingers.update(crop_depth);
  }
  else
  {
    //fingers.setThreshold(600);
    fingers.update(depthMap);
  }

  // Return amount of fingers
  //return fingers.getNumFingers();
}

void get_fingers()
{
}

void draw_fingers()
{
  noStroke();
  fill(255, 100, 0);

  for (int i = 0; i < fingers.getNumFingers(); i++) {
    PVector position = fingers.getFinger(i);
    if (detect_hand == true)
      ellipse(position.x - 5 + currentHand.x - crop/2, position.y -5 + currentHand.y - crop/2, 10, 10);
    else
      ellipse(position.x - 5, position.y - 5, 10, 10);
  }
}

void draw_contour()
{
  stroke(255, 0, 100);
  noFill();

  for (int k = 0; k < fingers.getNumContours(); k++) {
    fingers.drawContour(k);
  }
}
