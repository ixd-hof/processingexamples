import processing.serial.*;
import pt.citar.diablu.processing.mindset.*;
// http://jorgecardoso.eu/processing/MindSetProcessing/

MindSet mindset;
int attention;
int meditation;
int blinkstrenght;
int strength;

int numSamples = 60;
ArrayList attSamples;

void setup() {
  size(512, 512);
  attSamples = new ArrayList();
  mindset = new MindSet(this, "/dev/cu.MindWaveMobile-DevA");
}


void draw()
{
  background(0);
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
  blinkstrenght = blinkStrength;
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

   
