boolean p = false;

void setup()
{
  size(200, 200);
}

void draw()
{
  
}

void mousePressed()
{
  var script = document.createElement("script");
  if (p == false)
    script.src = "http://192.168.240.1/arduino/set_led/123/1000/0/0/100";
  else if (p == true)
    script.src = "http://192.168.240.1/arduino/set_led/10/1000/0/0/100";
  document.body.appendChild(script);
  
  p = !p;
}

void an()
{
  var script = document.createElement("script");
  script.src = "http://192.168.240.1/arduino/set_led/10/1000/0/0/100";
  document.body.appendChild(script);
}

void aus()
{
  var script = document.createElement("script");
  script.src = "http://192.168.240.1/arduino/set_led/123/1000/0/0/100";
  document.body.appendChild(script);
}

