// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

import SimpleOpenNI.*;
import fingertracker.*;

SimpleOpenNI kinect;

PVector currentHand;
String lastGesture = "";
PImage depth;
PImage rgb_img;

Fingers lefthand, righthand;

Colortracker colortracker_red;

void setup() {
  size(640, 480);

  // Initialize Kinect
  kinect = new SimpleOpenNI(this);
  kinect.setMirror(true);
  kinect.enableDepth();
  kinect.enableRGB(); // Kinect color image
  kinect.alternativeViewPointDepthToImage(); // align depth data to image data

  // Enable Hands
  kinect.enableGesture();
  kinect.enableHands();
  // Set initialization gesture for finger tracking
  kinect.addGesture("RaiseHand");

  // Initialize hand position
  currentHand = null;

  // Initialize finger tracking.
  // init_fingers(this, boolean only_hand);
  lefthand = new Fingers(this, true);

  righthand = new Fingers(this, true);
  
  // Color Tracker
  color finger_red = color(213.0, 223.0, 111.0);
  colortracker_red = new Colortracker(finger_red);
}

void draw() {
  // Update Kinect and read depth image
  kinect.update();
  depth = kinect.depthImage();
  rgb_img = kinect.rgbImage();

  image(depth, 0, 0);

  // If a hand was detected
  if (currentHand != null)
  {
    // Draw ellipse at hand's position
    noFill();
    stroke(255, 0, 0);
    ellipse(currentHand.x, currentHand.y, 20, 20);
    
    text("Hand: " + currentHand.x + " " + currentHand.y, 20, 20);
    
    // Detect and draw fingers of the left hand
    lefthand.update(kinect.depthMap(), currentHand);
    lefthand.draw_fingers();
    lefthand.draw_contour();

    int num_fingers_left = lefthand.count_fingers();
    text("Fingers left: " + num_fingers_left, 20, 40);

    if (num_fingers_left > 0)
    {
      PVector[] fingers = lefthand.get_fingers();

      for (int i=0; i<num_fingers_left; i++)
      {
        fill(0, 255, 255);
        pushMatrix();
        text(i, fingers[i].x, fingers[i].y);
        popMatrix();
        
        color f = rgb_img.get((int)fingers[i].x, (int)fingers[i].y);
        fill(f);
        rect(50*i, 0, 50, 50);
      }
    }
    
   // Color tracker
   boolean color_found = colortracker_red.update(rgb_img, currentHand); 
  }
}

// -----------------------------------------------------------------
// Events

// Hand detected
void onCreateHands(int handId, PVector position, float time) {
  //println("Hand detected");
  kinect.convertRealWorldToProjective(position, position);
  currentHand = position;
}

// Hand position updated
void onUpdateHands(int handId, PVector position, float time) {
  //println("Hand updated");
  kinect.convertRealWorldToProjective(position, position);
  currentHand = position;
}

// Hand lost
void onDestroyHands(int handId, float time) {
  //println("Hand lost");
  currentHand = null;
  kinect.addGesture("RaiseHand");
}


// -----------------------------------------------------------------
// Gesture events

void onRecognizeGesture(String strGesture, PVector idPosition, PVector endPosition)
{
  println("onRecognizeGesture - strGesture: " + strGesture + ", idPosition: " + idPosition + ", endPosition:" + endPosition);

  lastGesture = strGesture;
  kinect.removeGesture(strGesture); 
  kinect.startTrackingHands(endPosition);
}

void onProgressGesture(String strGesture, PVector position, float progress)
{
  //println("onProgressGesture - strGesture: " + strGesture + ", position: " + position + ", progress:" + progress);
}

