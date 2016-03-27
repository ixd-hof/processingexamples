int last_a = 0;

void setup()
{
  Keyboard.begin();
  Mouse.begin();

  pinMode( 0, INPUT );
}

void loop()
{
  // Keyboard press Space
  if (digitalRead(0) == HIGH) {
    Keyboard.press(' ');
    delay(20);
  }
  else
  {
    Keyboard.release(' ');
  }

  // Keyboard walk
  if (analogRead(1) > 600) {
    Keyboard.press('w');
    delay(20);
  }
  else if (analogRead(1) < 400) {
    Keyboard.press('s');
    delay(20);
  }
  else
  {
    Keyboard.release('w');
    Keyboard.release('s');
  }

  // Mouse rotate
  int a = analogRead(0);
  Mouse.move(last_a - a, 0, 0);
  last_a = a;
}
