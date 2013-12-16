import themidibus.*;

MidiBus midibus;

int channel = 0;
int pitch = 64;
int velocity = 127;

void setup() {
  size(400, 400);
  background(0);

  MidiBus.list();
  midibus = new MidiBus(this, -1, "Bus 1");
}

void draw() {
  //myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  //delay(200);
  //myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff

  int number = 0;
  int value = 90;

  //myBus.sendControllerChange(channel, number, value); // Send a controllerChange
}

// Später: if fiducial visible
void mousePressed()
{
  pitch = int(map(mouseY, 0, height, 0, 127));
  velocity = int(map(mouseX, 0, width, 0, 127));
  midibus.sendNoteOn(channel, pitch, velocity);
  println("pressed");
}

void mouseMoved()
{
}

void mouseReleased()
{
  //midibus.sendNoteOff(channel, pitch, velocity);
}

