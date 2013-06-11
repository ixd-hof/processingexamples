void setup()
{
  Serial.begin(9600);
  pinMode(2, INPUT);
  pinMode(13, OUTPUT);
}

void loop()
{
  int val = analogRead(0);
  float out = map(val, 0, 1024, 0, 255);
  analogWrite(9, val);
  
  Serial.println(val + " " + out); 
}
