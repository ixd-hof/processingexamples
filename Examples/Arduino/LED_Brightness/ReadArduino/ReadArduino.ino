void setup()
{
  Serial.begin(9600);
}

void loop()
{
  if (Serial.available() > 0) {
    Serial.println(123);
    delay(1000);
  }

}


