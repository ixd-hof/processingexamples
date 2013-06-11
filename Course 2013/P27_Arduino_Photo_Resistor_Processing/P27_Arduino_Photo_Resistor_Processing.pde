import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

void setup()
{
  size(500, 500);
  frameRate(30);
  
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(2, Arduino.INPUT);
  arduino.pinMode(13, Arduino.OUTPUT);
}

void draw()
{ 
  int light = arduino.analogRead(2);
  int bg = map(light, 0, 1024, 0, 255);
  background(bg);
}

void mousePressed()
{
  arduino.digitalWrite(13, Arduino.HIGH);
}

void mouseReleased()
{
  arduino.digitalWrite(13, Arduino.LOW);
}
