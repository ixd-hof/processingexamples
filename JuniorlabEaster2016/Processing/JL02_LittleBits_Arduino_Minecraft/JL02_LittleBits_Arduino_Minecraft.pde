import pi.*;
import pi.Minecraft.*;
import pi.Vec;

import processing.serial.*;
import cc.arduino.*;

// Write Arduino firmata first on the board
Arduino arduino;

Minecraft mc;

int last_d0, last_a0, last_a1;

void setup()
{
  // Connect to Minecraft server (localhost)
  mc = Minecraft.connect();
  // Connect to Minecraft server ip
  // mc = Minecraft.connect("192.168.0.23");

  // Connect to Arduino
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[10], 57600);
  arduino.pinMode(0, Arduino.INPUT);
}

void draw()
{
  background(0);

  // Read inputs

  // button d0 (0 or 1)
  int d0 = arduino.digitalRead(0);
  // analog port 0 (dimmer 0-1024)
  int a0 = arduino.analogRead(0);
  // analog port 1 (dimmer 0-1024)
  int a1 = arduino.analogRead(1);

  // Teleport up if button (d0) is pressed
  if (d0 == 1 && last_d0 == 0)
  {
    // Get current position
    Vec position = mc.player.getPosition();
    // Set same position but higher (y=10)
    mc.player.setPosition(pi.Vec.xyz(position.x, 10, position.z));
  }

  // If knob was turned
  if (a0 != last_a0)
  {
    // Get current position
    Vec position = mc.player.getPosition();
    // Generate blocks above player
    mc.setBlock(position.x, position.y+a0, position.z, Block.TNT);
  }

  background(a0/4); // grey 0-255
  println("d0: " + arduino.digitalRead(0));
  println("a0: " + arduino.analogRead(0));
  println("a1: " + arduino.analogRead(1));

  // set last values in order to test in the next frame if changed
  last_d0 = d0;
  last_a0 = a0;
  last_a1 = a1;
}