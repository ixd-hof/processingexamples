import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

int last_value = 0;

void setup()
{ 
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[10], 57600);
  arduino.pinMode(0, Arduino.INPUT);
}

void draw()
{
  background(0);
  
  // button d0 (0 or 1)
  int d0 = arduino.digitalRead(0);
  // analog port 0 (dimmer 0-1024)
  int a0 = arduino.analogRead(0);
  // analog port 1 (dimmer 0-1024)
  int a1 = arduino.analogRead(1);
  
  background(a0/4); // grey 0-255
  println("d0: " + arduino.digitalRead(0));
  println("a0: " + arduino.analogRead(0));
  println("a1: " + arduino.analogRead(1));
}