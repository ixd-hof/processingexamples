import picking.*;
import TUIO.*;
import java.util.*;

TuioProcessing tuioClient;

Picker picker;
int picked_id = -1;

void setup() {
  size(displayWidth, displayHeight, P3D);
  noStroke();
  
  picker = new Picker(this);
  
  tuioClient  = new TuioProcessing(this);
  
  rectMode(CENTER);
}

void draw()
{
  background(255);

  picker.start(1); // Picking Raum für ID 1 definieren

  // Wenn etwas innerhalb geklickt wurde: Farbe ändern
  if (picked_id == 1)
  {
    fill(255, 100, 0);
  }
  else
  {
    fill(0, 0, 0);
  }
  rect(150, 150, 100, 100);
  
  picker.stop(); // Ende des Picking Raums für ID 1
  
  Vector tuioObjectList = tuioClient.getTuioObjects();

  if (tuioObjectList.size() > 0)
  {
    TuioObject tobj = (TuioObject)tuioObjectList.elementAt(0);
    pushMatrix();
    noFill();
    stroke(0);
    translate(tobj.getX()*width, tobj.getY()*height);
    rotate(-tobj.getAngle());
    rect(0, 0, 100, 100);
    popMatrix();
  }
}

void addTuioObject(TuioObject tobj) {
  picked_id = picker.get(int(tobj.getX()*width), int(tobj.getY()*height));
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  picked_id = -1;
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  picked_id = picker.get(int(tobj.getX()*width), int(tobj.getY()*height));
}

