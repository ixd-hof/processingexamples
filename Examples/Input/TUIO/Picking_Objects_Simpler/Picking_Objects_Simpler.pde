import TUIO.*;
import java.util.*;

TuioProcessing tuioClient;

PImage img;
TouchImage ti, ti2;

PGraphics Picker;

void setup() {
  size(1000, 500, P3D);
  noStroke();

  tuioClient = new TuioProcessing(this);
  Picker = createGraphics(width, height);

  img = loadImage("nasa_buzz.jpg");
  ti = new TouchImage(img, Picker, 100, width/4, height/2);
  ti2 = new TouchImage(img, Picker, 200, width-width/4, height/2);
}

void draw()
{
  background(255);

  Vector tuioCursorList = tuioClient.getTuioCursors();

  // Reset Picker
  Picker.beginDraw();
  Picker.background(255);
  Picker.endDraw();

  imageMode(CORNER);
  image(Picker, 0, 0);

  ti.draw_picker();
  ti2.draw_picker();
  ti.draw(tuioClient.getTuioCursors());
  ti2.draw(tuioClient.getTuioCursors());

  if (tuioCursorList.size() > 0)
  {
    for (int i=0; i<tuioCursorList.size(); i++)
    {
      TuioCursor tcur = (TuioCursor)tuioCursorList.elementAt(i);
      pushMatrix();
      fill(0, 100, 255, 100);
      stroke(200);
      ellipse(tcur.getX()*width, tcur.getY()*height, 50, 50);
      popMatrix();
    }
  }
}

class TouchImage
{
  PImage img;
  PVector pos;
  PVector last_pos;
  float angle;
  PGraphics picker;
  int id;

  TouchImage(PImage image, PGraphics parent_picker, int picking_id, int x, int y)
  {
    img = image;
    pos = new PVector(x, y);
    picker = parent_picker;
    id = picking_id;
  }

  void draw_picker()
  {
    rectMode(CENTER);
    imageMode(CENTER);
    picker.beginDraw();
    picker.rectMode(CENTER);
    picker.noStroke();
    //picker.imageMode(CENTER);
    //picker.background(255);
    picker.pushMatrix();
    picker.translate(pos.x, pos.y);
    picker.rotate(angle);
    picker.fill(id);
    picker.rect(0, 0, img.width, img.height);
    picker.popMatrix();
    picker.endDraw();
  }

  void draw(Vector tuioCursorList)
  {
    pushMatrix();
    //image(picker, 0, 0);
    translate(pos.x, pos.y);
    rotate(angle);
    //image(img, 0, 0);
    popMatrix();

    Vector touch_cursors = new Vector(); //(Vector)tuioCursorList.clone();

    for (int i=0; i<tuioCursorList.size(); i++)
    {
      TuioCursor tcur = (TuioCursor)tuioCursorList.elementAt(i);
      int picked_color = int(brightness(picker.get(int(tcur.getX()*width), int(tcur.getY()*height))));
      //int last_color = int(brightness(get(int(last_pos.x), int(last_pos.y))));
      println(id + ": " + picked_color);
      if (picked_color == id)
      {
        touch_cursors.add(tcur);
      }
      //println(touch_cursors.size());
    }


    if (touch_cursors.size() == 1)
    {
      TuioCursor tcur = (TuioCursor)touch_cursors.elementAt(0);
      pos.x = tcur.getX()*width;
      pos.y = tcur.getY()*height;
    }
    else if (touch_cursors.size() >= 2)
    {
      TuioCursor tcur0 = (TuioCursor)touch_cursors.elementAt(0);
      TuioCursor tcur1 = (TuioCursor)touch_cursors.elementAt(1);
      PVector vcur0 = new PVector(tcur0.getX()*width, tcur0.getY()*height);
      PVector vcur1 = new PVector(tcur1.getX()*width, tcur1.getY()*height);
      PVector center = PVector.lerp(vcur0, vcur1, 0.5);
      angle = atan2(vcur0.y - vcur1.y, vcur0.x - vcur1.x);
      //println(angle + " " + pos.x + " " + pos.y);
      pos.x = center.x;
      pos.y = center.y;
    }

    //println(id + ": " + pos.x + " " + pos.y);
    //last_pos = pos;
  }
}

