import processing.net.*;
import java.util.*;

int poorSignalLevel;
EegPower eegPower; //delta, theta, lowAlpha, highAlpha, lowBeta, highBeta, lowGamma, highGamma;
ESense eSense; //attention, meditation;
int blinkStrength;
int rawEeg;

void setup()
{
  size(500, 500);
  
  init_ThinkGear(true);
}

void draw()
{
  background(255);
  
  fill(0);
  noStroke();
  text("poorSignalLevel: " + poorSignalLevel, 20, 20);
  
  // if eeg headset is active
  if (poorSignalLevel < 200)
  {
    if (eSense != null)
    {
      text("Attention: " + eSense.attention, 20, 40);
      text("Medidation: " + eSense.meditation, 20, 60);
    }
    
    text("rawEeg: " + rawEeg, 20, 80);
    text("blinkStrength: " + blinkStrength, 20, 100);
    blinkStrength = 0;
  }
  else
  {
    // wait
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

