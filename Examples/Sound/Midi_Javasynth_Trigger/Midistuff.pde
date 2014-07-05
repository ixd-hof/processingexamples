void init_java_synth()
{
  try {
    synth = javax.sound.midi.MidiSystem.getSynthesizer();
    synth.open();
    Instrument [] instrument = synth.getAvailableInstruments();
    for (int i=0; i<instrument.length; i++)
      println(i + " " + instrument[i]);
    receiver = synth.getReceiver();
    //println(instrument);
  } 
  catch (MidiUnavailableException e) { 
    println(e);
  }
}

void trigger_note(boolean on, int channel, int pitch, int velocity)
{
  int cmd;
  if (on == true)
    cmd = ShortMessage.NOTE_ON;
  else
    cmd = ShortMessage.NOTE_OFF;
  try {
    receiver.send( new ShortMessage(cmd, channel, pitch, velocity), millis() );
  } 
  catch (Exception e) { 
    println(e);
  }
}
