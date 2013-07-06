import TUIO.*;
import java.util.*;

TuioProcessing tuioClient;

PImage img;
TouchImage ti, ti2;

HashMap TouchObjects = new HashMap();

void setup() {
  size(displayWidth, displayHeight, P3D);
  noStroke();

  picker = new Picker(this);

  tuioClient  = new TuioProcessing(this);

  img = loadImage("nasa_buzz.jpg");
  ti = new TouchImage(img, new PVector(width/4, height/2));
  ti2 = new TouchImage(img, new PVector(width-width/4, height/2));
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

  Vector tuioCursorList = tuioClient.getTuioCursors();

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
  float angle;
  PGraphics picker;

  TouchImage(PImage image, PVector init_position)
  {
    img = image;
    pos = init_position;
    picker = createGraphics(width, height);
  }

  void draw(Vector tuioCursorList)
  {
    rectMode(CENTER);
    imageMode(CENTER);
    picker.beginDraw();
    picker.rectMode(CENTER);
    //picker.imageMode(CENTER);
    picker.background(255);
    picker.pushMatrix();
    picker.translate(pos.x, pos.y);
    picker.rotate(angle);
    picker.fill(0);
    picker.rect(0, 0, img.width, img.height);
    picker.popMatrix();
    picker.endDraw();

    pushMatrix();
    //image(picker, 0, 0);
    translate(pos.x, pos.y);
    rotate(angle);
    image(img, 0, 0);
    popMatrix();

    Vector touch_cursors = (Vector)tuioCursorList.clone();

    for (int i=0; i<tuioCursorList.size(); i++)
    {
      TuioCursor tcur = (TuioCursor)tuioCursorList.elementAt(i);
      if (brightness(picker.get(int(tcur.getX()*width), int(tcur.getY()*height))) != 0)
      {
        println(touch_cursors.size());
        touch_cursors.remove(i);
      }
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
      println(angle + " " + pos.x + " " + pos.y);
      pos.x = center.x;
      pos.y = center.y;
    }
  }
}
