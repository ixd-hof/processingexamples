import net.beadsproject.beads.core.*;
import net.beadsproject.beads.core.io.*;
import net.beadsproject.beads.ugens.*;
import net.beadsproject.beads.data.*;
import net.beadsproject.beads.analysis.segmenters.*;
import net.beadsproject.beads.events.*;
import net.beadsproject.beads.analysis.*;
import net.beadsproject.beads.data.audiofile.*;
import net.beadsproject.beads.data.buffers.*;
import net.beadsproject.beads.analysis.featureextractors.*;

AudioContext ac;
Glide rateValue;
SamplePlayer player;

void setup() {
  size(300, 300);

  // Sound player
  ac = new AudioContext();
  // Add your sound file as WAV or AIFF (not MP3)
  String audioFile = dataPath("01-Now_Get_Busy-02.wav"); // load audio file in data folder
  player = new SamplePlayer(ac, SampleManager.sample(audioFile));
  player.setToLoopStart();

  // Player speed
  rateValue = new Glide(ac, 0, 20);
  player.setRate(rateValue);
  rateValue.setValue(4);

  // Output volume
  Gain g = new Gain(ac, 2, 1);
  g.addInput(player);
  ac.out.addInput(g);
  ac.start();

  player.start();


  ShortFrameSegmenter sfs = new ShortFrameSegmenter(ac);
  // how large is each chunk?
  sfs.setChunkSize(2048);
  sfs.setHopSize(441);
  // connect the sfs to the AudioContext
  sfs.addInput(ac.out);
  FFT fft = new FFT();
  PowerSpectrum ps = new PowerSpectrum();
  sfs.addListener(fft);
  fft.addListener(ps);
  // The SpectralDifference unit generator does exactly what
  // it sounds like. It calculates the difference between two
  // consecutive spectrums returned by an FFT (through a
  // PowerSpectrum object).
  SpectralDifference sd = new
    SpectralDifference(ac.getSampleRate());
  ps.addListener(sd);
  // we will use the PeakDetector object to actually find our
  // beats
  PeakDetector beatDetector = new PeakDetector();
  sd.addListener(beatDetector);
  // the threshold is the gain level that will trigger the
  // beat detector - this will vary on each recording
  beatDetector.setThreshold(0.5f);
  beatDetector.setAlpha(.9f);
  // whenever our beat detector finds a beat, set a global
  // variable
  beatDetector.addMessageListener
    (
  new Bead() {
    protected void messageReceived(Bead b)
    {
      //brightness = 1.0;
      println("beat");
    }
  } 
  );
}
  
void draw()
{
  // map mouseX value(0-300) to 0-5
  float speed = map(mouseX, 0, width, 0, 2);
  println(speed);
  // set player speed to that value (left slow, right fast)
  rateValue.setValue(speed);

  //println(player.inLoop());
  //if (!player.inLoop())
  //  player.setToLoopStart();
}

