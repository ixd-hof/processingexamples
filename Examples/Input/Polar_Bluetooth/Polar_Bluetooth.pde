// Simple implementation of Polar Wearlink Heart Rate Sensor with Bluetooth
// Thanks to Google mytracks for the protocol documentation
// https://code.google.com/p/mytracks/

// IxD Hof Creative Coding Class
// http://ixd-hof.de

import processing.serial.*;

Serial myPort;
PFont myFont;
int heartrate = 0;

void setup()
{
  size(100, 100);
  
  println(Serial.list());
  //[6] "/dev/tty.PolariWL-BluetoothSeria"
  String portName = Serial.list()[6];
  myPort = new Serial(this, portName, 115200);
  
  myFont = createFont("Helvetica", 32);
  textFont(myFont);
  textAlign(CENTER, CENTER);
}

void draw()
{
  background(255);
  fill(255, 0, 0);
  text(heartrate, width/2, height/2);
}

void serialEvent(Serial p)
{
  // Start / end of message
  int lf = 254;
  // Maximal length of buffer (varies)
  byte[] inBuffer = new byte[14];
  myPort.readBytesUntil(lf, inBuffer);
  if (inBuffer != null) {
    // Pulse value is at position 4 of the buffer
    if (inBuffer[4] > 0)
      heartrate = inBuffer[4];
  }
}

