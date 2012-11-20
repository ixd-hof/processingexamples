import denkgear.*;

DenkGear dg;

void setup()
{
  dg = new DenkGear(this);
}

void draw()
{
  //background(random(255));
}

public void signalEvent(int signal)
{
  println("Signal: " + signal);
}

public void eegPowerEvent(HashMap eeg)
{
  println("eegPower: " + eeg);
}

public void eSenseEvent(HashMap eSense)
{
  println("eSense: " + eSense);
}

public void blinkEvent(int blinkStrength)
{
  println("Blink: " + blinkStrength);
}
