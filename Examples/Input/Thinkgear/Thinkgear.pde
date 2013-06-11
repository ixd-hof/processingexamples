import processing.net.*;
import java.util.*;

int poorSignalLevel;
EegPower eegPower; //delta, theta, lowAlpha, highAlpha, lowBeta, highBeta, lowGamma, highGamma;
ESense eSense; //attention, meditation;
int blinkStrength;
int rawEeg;
int rawCounter = 0;

void setup()
{
  size(500, 500);
  init_ThinkGear(true);
}

void draw()
{
  noStroke();
  // fade out
  rectMode(CORNER);
  fill(255, 10);
  rect(0, 0, width, height);

  // if eeg headset is active
  if (poorSignalLevel < 200)
  {

    noStroke();
    fill(#FF088C);
    ellipse(width/2, height/2, blinkStrength, blinkStrength);
    blinkStrength = 0;

    if (eSense != null)
    {
      float attention = map(eSense.attention, 0, 100, 0, height/2);
      stroke(#0052F2);
      noFill();
      ellipse(width/2, height/2, attention, attention);
      fill(#0052F2);
      text("Attention: " + eSense.attention, 20, 20);
      
      float meditation = map(eSense.meditation, 0, 100, 0, height/2);
      stroke(#D400FF);
      noFill();
      ellipse(width/2, height/2, meditation, meditation);
      fill(#D400FF);
      text("Medidation: " + eSense.meditation, 20, 40);
    }
    
    // raw
    float raw_height = map(rawEeg, -2048, 2048, 0, height);
    int raw_x = rawCounter%width;
    stroke(50);
    noFill();
    rectMode(CENTER);
    ellipse(raw_x, raw_height, 10, 10);
    rawCounter ++;
  }
  else
  {
    // waiting for headset data
    rectMode(CENTER);
    noFill();
    stroke(100);
    translate(width/2, height/2);
    rotate(millis()/200.0);
    rect(0, 0, 100, 100);
  }
}

void poorSignalLevelEvent(int p)
{
  poorSignalLevel = p;
}

void eegPowerEvent(EegPower e)
{
  eegPower = e;
}

void eSenseEvent(ESense e)
{
  // 0-100
  eSense = e;
}

void blinkEvent(int b)
{
  // 0-255
  blinkStrength = b;
}

void rawEegEvent(int raw)
{
  rawEeg = raw;
}

