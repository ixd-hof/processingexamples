import themidibus.*;

MidiBus midibus;

int channel = 1;
int pitch = 64;
int velocity = 127;
int takt = 1000;
int last_takt = 0;

void setup() {
  size(400, 400);
  background(0);

  MidiBus.list();
  
  println(MidiBus.unavailableDevices() );
  midibus = new MidiBus(this, "Bus 1");
  //midibus.sendTimestamp(false);
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
  pitch = int(map(mouseX, 0, width, 0, 127));
  velocity = int(map(mouseX, 0, width, 0, 127));
  //midibus.sendNoteOn(channel, pitch, velocity);
  midibus.sendNoteOn(1, pitch, velocity);
  println("pressed");
}

void mouseMoved()
{
}

void mouseReleased()
{
  midibus.sendNoteOff(channel, pitch, velocity);
}

