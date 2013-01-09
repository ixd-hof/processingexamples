import picking.*;

Picker picker;
int picked_id = -1;
PVector last_pos = new PVector(100, 100);

void setup() {
  size(400, 400);
  noStroke();
  
  picker = new Picker(this);
}

void draw()
{
  background(255);

  picker.start(1); // Picking Raum für ID 1 definieren

  // Wenn etwas innerhalb geklickt wurde: Farbe ändern und verschieben
  if (picked_id == 1)
  {
    fill(255, 100, 0);
    translate(mouseX, mouseY);
    last_pos.x = mouseX;
    last_pos.y = mouseY;
  }
  else
  {
    fill(0, 0, 0);
    translate(last_pos.x, last_pos.y);
  }
  rect(-50, -50, 100, 100);

  picker.stop(); // Ende des Picking Raums für ID 1
}

void mousePressed()
{
  // Picking ID erfassen (1 wenn auf Rect, -1 wenn aussen herum
  picked_id = picker.get(mouseX, mouseY);
}

void mouseReleased()
{
  picked_id = -1;
}

