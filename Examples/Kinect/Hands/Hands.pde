/* --------------------------------------------------------------------------
 * SimpleOpenNI Hands3d Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * ----------------------------------------------------------------------------
 * This demos shows how to use the gesture/hand generator.
 * It's not the most reliable yet, a two hands example will follow
 * ----------------------------------------------------------------------------
 */

import java.util.Map;
import java.util.Iterator;

import SimpleOpenNI.*;

SimpleOpenNI context;

PVector hand;

void setup()
{
  //  frameRate(200);
  size(640, 480);

  context = new SimpleOpenNI(this);
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }   

  // enable depthMap generation 
  context.enableDepth();

  // disable mirror
  context.setMirror(true);

  // enable hands + gesture generation
  //context.enableGesture();
  context.enableHand();
  context.startGesture(SimpleOpenNI.GESTURE_WAVE);

  // set how smooth the hand capturing should be
  //context.setSmoothingHands(.5);
}

void draw()
{
  background(0);
  
  // update the cam
  context.update();

  // draw the depth image
  image(context.depthImage(), 0, 0);

  // draw the tracked hand (only one hand, the last one recognized)
  // if there's a hand
  if (hand != null)
  {
    PVector p2d = new PVector();
    context.convertRealWorldToProjective(hand, p2d);
    ellipse(p2d.x, p2d.y, 20, 20);
  }
}


// -----------------------------------------------------------------
// hand events

void onNewHand(SimpleOpenNI curContext, int handId, PVector pos)
{
  println("onNewHand - handId: " + handId + ", pos: " + pos);
  hand = pos;
}

void onTrackedHand(SimpleOpenNI curContext, int handId, PVector pos)
{
  //println("onTrackedHand - handId: " + handId + ", pos: " + pos );
  hand = pos;
}

void onLostHand(SimpleOpenNI curContext, int handId)
{
  println("onLostHand - handId: " + handId);
  hand = null;
}

// -----------------------------------------------------------------
// gesture events

void onCompletedGesture(SimpleOpenNI curContext, int gestureType, PVector pos)
{
  println("onCompletedGesture - gestureType: " + gestureType + ", pos: " + pos);

  int handId = context.startTrackingHand(pos);
  println("hand stracked: " + handId);
}

// -----------------------------------------------------------------
// Keyboard event
void keyPressed()
{

  switch(key)
  {
  case ' ':
    context.setMirror(!context.mirror());
    break;
  case '1':
    context.setMirror(true);
    break;
  case '2':
    context.setMirror(false);
    break;
  }
}

