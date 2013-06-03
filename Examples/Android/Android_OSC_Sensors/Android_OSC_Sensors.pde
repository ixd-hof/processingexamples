import ketai.sensors.*;

import oscP5.*;
import netP5.*;

KetaiSensor sensor;

PFont font;

OscP5 oscP5;
NetAddress myRemoteLocation;

PVector orientation = new PVector();
PVector acceleration = new PVector();
PVector gyroscope = new PVector();
PVector magneticfield = new PVector();
float light = 0.0;
float proximity = 0.0;

void setup()
{
  
  //frameRate(30);
  sensor = new KetaiSensor(this);
  sensor.enableAllSensors();
  //sensor.setDelayInterval(33);
  sensor.start();
  orientation(PORTRAIT);
  //textAlign(CENTER, CENTER);
  
  font = loadFont("Helvetica-32.vlw");
  textSize(32);

  oscP5 = new OscP5(this, 22000);
  myRemoteLocation = new NetAddress("192.168.0.255", 12000);
}

void draw()
{
  background(0);
  
  fill(255);
  String output = "Orientation: " + orientation.x + " " + orientation.y + " " + orientation.z + "\n";
  output += "Gyroscope: " + gyroscope.x + " " + gyroscope.y + " " + gyroscope.z + "\n";
  output += "Acceleration: " + acceleration.x + " " + acceleration.y + " " + acceleration.z + "\n";
  output += "Magnetic Field: " + magneticfield.x + " " + magneticfield.y + " " + magneticfield.z + "\n";
  output += "Light: " + light + "\n";
  output += "Proximity: " + proximity + "\n";
  
  text(output, 20, 40);
    
  sendSensorValues();
}


void sendSensorValues()
{
  OscBundle oscBundle = new OscBundle();
  
  OscMessage m = new OscMessage("/orientation");
  m.add(orientation.x);
  m.add(orientation.y);
  m.add(orientation.z);
  oscBundle.add(m);
  
  m.clear();
  
  m.setAddrPattern("/gyroscope");
  m.add(gyroscope.x);
  m.add(gyroscope.y);
  m.add(gyroscope.z);
  oscBundle.add(m);
  
  m.clear();
  
  m.setAddrPattern("/acceleration");
  m.add(gyroscope.x);
  m.add(gyroscope.y);
  m.add(gyroscope.z);
  oscBundle.add(m);
  
  m.clear();
  
  m.setAddrPattern("/magneticfield");
  m.add(gyroscope.x);
  m.add(gyroscope.y);
  m.add(gyroscope.z);
  oscBundle.add(m);
  
  m.clear();
  
  m.setAddrPattern("/light");
  m.add(light);
  oscBundle.add(m);
  
  m.clear();
  
  m.setAddrPattern("/proximity");
  m.add(proximity);
  oscBundle.add(m);
  
  m.clear();
  
  oscBundle.setTimetag(oscBundle.now() + 10000);

  oscP5.send(oscBundle, myRemoteLocation);
}

void mousePressed()
{
  OscMessage m = new OscMessage("/remoteCursor");
  m.add(pmouseX);
  m.add(pmouseY);

  oscP5.send(m, myRemoteLocation);
}

void onOrientationEvent(float x, float y, float z)
{
  orientation.x = x;
  orientation.y = y;
  orientation.z = z;
}

void onGyroscopeEvent(float x, float y, float z)
{
  gyroscope.x = x;
  gyroscope.y = y;
  gyroscope.z = z;
}

void onAccelerometerEvent(float x, float y, float z, long time, int accuracy)
{
  acceleration.x = x;
  acceleration.y = y;
  acceleration.z = z;
}

void onMagneticFieldEvent(float x, float y, float z, long time, int accuracy)
{
  magneticfield.x = x;
  magneticfield.y = y;
  magneticfield.z = z;
}

void onLightEvent(float v)
{
  light = v;
}

void onProximityEvent(float v)
{
  proximity = v;
}
