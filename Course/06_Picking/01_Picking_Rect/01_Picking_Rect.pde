import picking.*;

Picker picker;
int picked_id = -1;

void setup() {
  size(400, 400, OPENGL);
  noStroke();
  picker = new Picker(this);
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

