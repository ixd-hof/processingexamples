#include <Adafruit_NeoPixel.h>
#include <avr/power.h>
//pin
#define PIN            6

//howmany
#define NUMPIXELS      32

Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

void setup() {
  Serial.begin(9600);
  pixels.begin(); // This initializes the NeoPixel library.
}

void loop() {

  while (Serial.available() > 0) {
    int p = Serial.parseInt();
    int r = Serial.parseInt();
    int g = Serial.parseInt();
    int b = Serial.parseInt();

    if (Serial.read() == '\n') {
      if (p == 123)
        pixels.clear();
      else
        pixels.setPixelColor(p, pixels.Color(r, g, b));
    }

  }

  pixels.show(); // This sends the updated pixel color to the hardware.

  delay(20); // Delay for a period of time (in milliseconds).
}
