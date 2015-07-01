#include <Bridge.h>
#include <YunServer.h>
#include <YunClient.h>

#include <Adafruit_NeoPixel.h>
#include <avr/power.h>
//pin
#define PIN            6

//howmany
#define NUMPIXELS      32

Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

int filling = -1;
int r = 50;
int g = 50;
int b = 50;
int duration = 0;
int p = 0;


// Listen on default port 5555, the webserver on the Yún
// will forward there all the HTTP requests for us.
YunServer server;

void setup() {
  // Bridge startup
  pinMode(13, OUTPUT);
  digitalWrite(13, LOW);
  Bridge.begin();
  digitalWrite(13, HIGH);

  // Listen for incoming connection only from localhost
  // (no one from the external network could connect)
  //server.listenOnLocalhost();
  server.begin();

#if defined(__AVR_ATtiny85__) && (F_CPU == 16000000L)
  clock_prescale_set(clock_div_1); // Enable 16 MHz on Trinket
#endif

  pixels.begin(); // This initializes the NeoPixel library.
}

void loop() {
  // Get clients coming from server
  YunClient client = server.accept();

  // There is a new client?
  if (client) {
    // Process request
    process(client);

    // Close connection and free resources.
    client.stop();
  }

  delay(50); // Poll every 50ms
}

void process(YunClient client) {
  // read the command
  String command = client.readStringUntil('/');

  // is "digital" command?
  if (command == "set_led") {
    p = client.parseInt();
    client.read();
    duration = client.parseInt();
    client.read();
    r = client.parseInt();
    client.read();
    g = client.parseInt();
    client.read();
    b = client.parseInt();

    // If 123 then turn all LEDs off
    if (p == 123)
    {
      pixels.clear();
      pixels.show();
      filling = -1;
    }
    else
    {
      for (int i = 0; i < p; i++)
      {
        pixels.setPixelColor(i, pixels.Color(r, g, b));
        pixels.show();
        delay(duration/p);
      }
      filling = 0; // Start filling
    }

    client.println(p);
    client.println(duration);
    client.print(r);
    client.print(g);
    client.println(b);
  }
}
