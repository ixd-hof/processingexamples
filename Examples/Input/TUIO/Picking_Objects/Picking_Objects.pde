import picking.*;
import TUIO.*;
import java.util.*;

TuioProcessing tuioClient;

Picker picker;
//int picked_id = -1;

HashMap TouchObjects = new HashMap();

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

  if (TouchObjects.size() > 0)
  {
    TuioCursor [] cursors = (TuioCursor[])TouchObjects.get(1);
    text(cursors.length, 20, 20);
    text(cursors[0].getX(), 20, 40);
  }

  // Picking Raum für ID 1 definieren

  // Wenn etwas innerhalb geklickt wurde: Farbe ändern
  /*
  if (TouchObjects.get(1) != null)
   {
   TuioCursor [] cursors = (TuioCursor[])TouchObjects.get(picked_id);
   */
  picker.start(1);
  fill(0);
  rect(width/2, height/2, 300, 300);

  picker.stop(); // Ende des Picking Raums für ID 1


  Vector tuioCursorList = tuioClient.getTuioCursors();
  if (tuioCursorList.size() > 0)
  {
    for (int i=0; i<tuioCursorList.size(); i++)
    {
      TuioCursor tcur = (TuioCursor)tuioCursorList.elementAt(i);
      pushMatrix();
      noFill();
      stroke(200);
      ellipse(tcur.getX()*width, tcur.getY()*height, 50, 50);
      popMatrix();
    }
  }
}

void addTuioCursor(TuioCursor tcur) {
  int picked_id = picker.get(int(tcur.getX()*width), int(tcur.getY()*height));
  if (picked_id != -1)
  {
    TuioCursor [] cursors = {
    };

    if (TouchObjects.get(picked_id) == null)
    {
      cursors = (TuioCursor[])append(cursors, tcur);
      TouchObjects.put(picked_id, cursors);
    }
    else if (TouchObjects.get(picked_id) != null)
    {
      cursors = (TuioCursor[])TouchObjects.get(picked_id);
      boolean new_cursor = true;

      for (int i=0; i<cursors.length; i++)
      {
        if (cursors[i].getCursorID() == tcur.getCursorID())
        {
          cursors[i] = tcur;
          println("update");
          new_cursor = false;
        }
      }
      if (new_cursor == true)
      {
        cursors = (TuioCursor[])append(cursors, tcur);
        println("add new");
      }
    }
    TouchObjects.put(picked_id, cursors);
  }
  //println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  int picked_id = picker.get(int(tcur.getX()*width), int(tcur.getY()*height));
  TuioCursor [] cursors = (TuioCursor[])TouchObjects.get(picked_id);
  if (picked_id != -1 && cursors.length > 0)
  {

    for (int i=0; i<cursors.length; i++)
    {
      if (cursors[i].getCursorID() == tcur.getCursorID())
      {
        cursors[i] = tcur;
        println("update");
      }
    }

    TouchObjects.put(picked_id, cursors);

    //println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()+" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
  }
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  //int picked_id = picker.get(int(tcur.getX()*width), int(tcur.getY()*height));
  Iterator keys = TouchObjects.keySet().iterator();

  while (keys.hasNext ())
  {
    int k = int(keys.next()+"");

    TuioCursor [] cursors = (TuioCursor[])TouchObjects.get(k);

    if (cursors.length > 1)
    {
      int cursor_index = 0;

      for (int i=0; i<cursors.length; i++)
      {
        if (cursors[i].getCursorID() == tcur.getCursorID())
        {
          cursor_index = i;
        }
      }
      if (cursor_index == 0)
      {
        cursors = (TuioCursor[])subset(cursors, 1, cursor_index-1);
      }
      else if (cursor_index == cursors.length-1)
      {
        cursors = (TuioCursor[])shorten(cursors);
      }
      else
      {
        println(cursor_index);
        TuioCursor[] cursors_left = (TuioCursor[])subset(cursors, 0, cursor_index);
        TuioCursor[] cursors_right = (TuioCursor[])subset(cursors, cursor_index+1);
        cursors = (TuioCursor[])concat(cursors_left, cursors_right);
      }
      TouchObjects.put(k, cursors);
    }
    else
    {
      TouchObjects.remove(k);
    }
  }


  println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

