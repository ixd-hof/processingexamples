Client think_client;

void init_ThinkGear(boolean raw)
{
  think_client = new Client(this, "127.0.0.1", 13854);
  String init_command = "{\"enableRawOutput\": " + raw + ", \"format\": \"Json\"}\n";
  think_client.write(init_command);
}

void parseJSON(String in)
{
  //{"eSense":{"attention":0,"meditation":0},"eegPower":{"delta":59283,"theta":8704,"lowAlpha":2683,"highAlpha":598,"lowBeta":1355,"highBeta":320,"lowGamma":117,"highGamma":5125},"poorSignalLevel":200}

  JSON thinkJSON = JSON.parse(in);
  //println(thinkJSON.length());
  //println(thinkJSON);

  Iterator itr = thinkJSON.keys();

  while (itr.hasNext ()) {
    String element = (String)itr.next();
    //println(element);
    if (element.equals("poorSignalLevel"))
    {
      int poorSignalLevel = thinkJSON.getInt("poorSignalLevel");
      try {
        poorSignalLevelEvent(poorSignalLevel);
      } catch (Exception e) {}
    }
    else if (element.equals("eegPower"))
    {
      JSON eegPowerJSON = thinkJSON.getObject("eegPower");
      EegPower eegPower = new EegPower();
      eegPower.delta = eegPowerJSON.getInt("delta");
      eegPower.theta = eegPowerJSON.getInt("theta");
      eegPower.lowAlpha = eegPowerJSON.getInt("lowAlpha");
      eegPower.highAlpha = eegPowerJSON.getInt("highAlpha");
      eegPower.lowBeta = eegPowerJSON.getInt("lowBeta");
      eegPower.highBeta = eegPowerJSON.getInt("highBeta");
      eegPower.lowGamma = eegPowerJSON.getInt("lowGamma");
      eegPower.highGamma = eegPowerJSON.getInt("highGamma");
      try {
        eegPowerEvent(eegPower);
      } catch (Exception e) {}
    }
    else if (element.equals("eSense"))
    {
      JSON eSenseJSON = thinkJSON.getObject("eSense");
      ESense eSense = new ESense();
      eSense.attention = eSenseJSON.getInt("attention");
      eSense.meditation = eSenseJSON.getInt("meditation");
      try {
        eSenseEvent(eSense);
      } catch (Exception e) {}
    }
    else if (element.equals("blinkStrength"))
    {
      int blinkStrength = thinkJSON.getInt("blinkStrength");
      try {
        blinkEvent(blinkStrength);
      } catch (Exception e) {}
    }
    else if (element.equals("rawEeg"))
    {
      int rawEeg = thinkJSON.getInt("rawEeg");
      try {
        rawEegEvent(rawEeg);
      } catch (Exception e) {}
    }
  }
}

void clientEvent(Client someClient)
{
  String in = think_client.readStringUntil(13);
  if (in != null)
    parseJSON(in);
}

class EegPower { 
  int delta, theta, lowAlpha, highAlpha, lowBeta, highBeta, lowGamma, highGamma;
  EegPower ()
  {
  }
}

class ESense { 
  public int attention, meditation;
  ESense ()
  {
  }
}
