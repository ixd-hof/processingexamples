import javax.sound.midi.*;

int channel = 1;
int pitch = 64;
int velocity = 127;

Synthesizer synth;
Receiver receiver;

void setup() {
  size(400, 400);
  background(0);

  try {
    // Get Java Synthesizer
    synth = javax.sound.midi.MidiSystem.getSynthesizer();
    synth.open();
    Instrument [] instrument = synth.getAvailableInstruments();
    // Print instruments
    for (int i=0; i<instrument.length; i++)
      println(i + " " + instrument[i]);
    receiver = synth.getReceiver();
  } 
  catch (MidiUnavailableException e) { 
    println(e);
  }
}

void draw()
{
  
}

void mousePressed()
{
  pitch = int(map(mouseX, 0, width, 0, 127));
  velocity = 127;

  try {
    receiver.send( new ShortMessage(ShortMessage.NOTE_ON, channel, pitch, velocity), millis() );
  } catch (Exception e) { println(e); }
}

void mouseReleased()
{
  try {
    receiver.send( new ShortMessage(ShortMessage.NOTE_OFF, channel, pitch, velocity), millis() );
  } catch (Exception e) { println(e); }
}

