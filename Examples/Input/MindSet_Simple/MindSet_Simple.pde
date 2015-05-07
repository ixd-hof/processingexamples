import processing.serial.*;
import pt.citar.diablu.processing.mindset.*;
// http://jorgecardoso.eu/processing/MindSetProcessing/

MindSet mindset;
int attention;
int meditation;
int blinkstrength;
int strength;

void setup() {
  size(512, 512);
  mindset = new MindSet(this, "/dev/cu.MindWaveMobile-DevA");
}


void draw()
{
  background(0);
  
  text("Signal: " + strength, 20, 20);
  text("Attention Level: " + attention, 20, 40);
  text("Meditation Level: " + meditation, 20, 60);
  text("Blink: " + blinkstrength, 20, 80);
}

// Print signal level
public void poorSignalEvent(int sig)
{
  strength = sig;
  println(sig);
}

// Attention event
public void attentionEvent(int attentionLevel)
{
  println("Attention Level: " + attentionLevel);
  attention = attentionLevel;
}

public void meditationEvent(int meditationLevel)
{
  println("Meditation Level: " + meditationLevel);
  meditation = meditationLevel;
}

public void blinkEvent(int blinkStrength)
{
  println("Blinked: " + blinkStrength);
  blinkstrength = blinkStrength;
}

public void eegEvent(int delta, int theta, int low_alpha, int high_alpha, int low_beta, int high_beta, int low_gamma, int mid_gamma) 
{
  // To Do
}

/*
public void rawEvent(int [])
{
  // To Do
}
*/

   
