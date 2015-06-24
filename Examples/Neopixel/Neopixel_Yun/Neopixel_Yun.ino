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
    int p = client.parseInt();
    client.read();
    int r = client.parseInt();
    client.read();
    int g = client.parseInt();
    client.read();
    int b = client.parseInt();
    
    pixels.setPixelColor(p, pixels.Color(r, g, b));
    pixels.show();

    client.print(p);
    client.print(r);
    client.print(g);
    client.println(b);
  }
}
