import SimpleOpenNI.*;
import fingertracker.*;

SimpleOpenNI kinect;

PVector currentHand;
String lastGesture = "";
PImage depth;

void setup() {
  size(640, 480);

  // Initialize Kinect
  kinect = new SimpleOpenNI(this);
  kinect.setMirror(true);
  kinect.enableDepth();
  
  // Enable Hands
  kinect.enableGesture();
  kinect.enableHands();
  // Set initialization gesture for finger tracking
  kinect.addGesture("RaiseHand");

  // Initialize hand position
  currentHand = null;
  
  // Initialize finger tracking.
  // init_fingers(boolean only_hand);
  // true: detect only rectangle around detected hand
  // false: detect hands in whole scene
  init_fingers(false);
}

void draw() {
  // Update Kinect and read depth image
  kinect.update();
  depth = kinect.depthImage();

  image(depth, 0, 0);

  // If a hand was detected
  if (currentHand != null)
  {
    // Draw ellipse at hand's position
    noFill();
    stroke(255, 0, 0);
    ellipse(currentHand.x, currentHand.y, 20, 20);
    
    // Detect and draw fingers
    fingers_update(kinect.depthMap());
    draw_fingers();
    draw_contour();
  }
}

// -----------------------------------------------------------------
// Events

// Hand detected
void onCreateHands(int handId, PVector position, float time) {
  println("Hand detected");
  kinect.convertRealWorldToProjective(position, position);
  currentHand = position;
}

// Hand position updated
void onUpdateHands(int handId, PVector position, float time) {
  println("Hand updated");
  kinect.convertRealWorldToProjective(position, position);
  currentHand = position;
}

// Hand lost
void onDestroyHands(int handId, float time) {
  println("Hand lost");
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

