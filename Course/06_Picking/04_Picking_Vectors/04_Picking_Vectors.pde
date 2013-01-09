import picking.*;

Picker picker;
int picked_id = -1;
PShape s;

void setup() {
  size(400, 400, P3D);
  noStroke();
  
  picker = new Picker(this);
  
  s = loadShape("tomato.svg");
}

void draw()
{
  background(255);

  picker.start(1); // Picking Raum für ID 1 definieren
  shape(s, 10, 10, 80, 80);
  picker.stop(); // Ende des Picking Raums für ID 1
}

void mousePressed()
{
  // Picking ID erfassen (1 wenn auf Rect, -1 wenn aussen herum
  picked_id = picker.get(mouseX, mouseY);
  println(picked_id);
}

void mouseReleased()
{
  picked_id = -1;
}

