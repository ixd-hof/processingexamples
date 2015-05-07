import processing.serial.*;

Serial myPort;
int val;

void setup() 
{
  size(255, 255);

  println(Serial.list());

  String portName = Serial.list()[7];
  myPort = new Serial(this, portName, 9600);
}

void draw()
{
  background(255);
  
  if (mousePressed == true)
  {
    background(mouseX);
    myPort.write(mouseX + "\n");
  }
  else
  {
    background(0);
    myPort.write(0 + "\n");
  }
}

