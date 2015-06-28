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
}

void draw()
{
  // map mouseX value(0-300) to 0-5
  float speed = map(mouseX, 0, width, 0, 2);
  println(speed);
  // set player speed to that value (left slow, right fast)
  rateValue.setValue(speed);

  float out = ac.out.getValue()*100;
  ellipse(width/2, height/2, out, out);
  println(out);

  //println(player.inLoop());
  //if (!player.inLoop())
  //  player.setToLoopStart();
}

