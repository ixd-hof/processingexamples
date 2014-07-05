import javax.sound.midi.*;

int channel = 0;
int pitch = 64;
int velocity = 127;
int beat = 1000;
int last_beat = 0;

Synthesizer synth;
Receiver receiver;

void setup() {
  size(400, 400);
  background(0);

  // Activate Java Synth
  init_java_synth();
}

void draw()
{
  if (millis()-last_beat > beat)
  {
    // Note off
    trigger_note(false, channel, pitch, velocity);
    
    pitch = int(random(127));
    velocity = 127;

    // Note on
    trigger_note(true, channel, pitch, velocity);

    last_beat = millis();
  }
}

// Später: if fiducial visible
void mousePressed()
{
  pitch = int(map(mouseX, 0, width, 0, 127));
  velocity = int(map(mouseX, 0, width, 0, 127));

  trigger_note(true, channel, pitch, velocity);

  println("pressed");
}

void mouseReleased()
{
  trigger_note(false, 0, pitch, velocity);
}

