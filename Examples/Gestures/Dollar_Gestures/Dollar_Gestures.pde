/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/600*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
// Dollar, from http://depts.washington.edu/aimgroup/proj/dollar/dollar.js
// http://depts.washington.edu/aimgroup/proj/dollar/
//

import java.util.Stack;

Recognizer recognizer;
Result result = null;
String gesture = "- none -";
PFont font;

PVector [] record = new PVector[0];

void setup() 
{
  size(500, 250);

  recognizer = new Recognizer();
  smooth();
  font = loadFont("OCR-A-48.vlw"); 
  textFont(font);
  textAlign(CENTER);
}

void draw() 
{
  background(204);

  if (mousePressed)
  {
    record = (PVector[])append(record, new PVector(mouseX, mouseY));
  }
  text(gesture, width/2, height/2);
}

void mouseReleased()
{
  if (record.length > 0)
  {
    result = recognizer.Recognize( record );
    gesture = result.Name;
    record = new PVector[0];
  }

  if (gesture == "circle")
  {
    println("Yeah! Circle...");
  }
  else if (gesture.indexOf("none") != -1)
  {
     println("What?"); 
  }
}

