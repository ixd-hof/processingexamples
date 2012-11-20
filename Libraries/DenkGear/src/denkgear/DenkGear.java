/**
 * ##DenkGear##
 * ##library.sentence##
 * ##library.url##
 *
 * Copyright ##copyright## ##author##
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General
 * Public License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA  02111-1307  USA
 * 
 * @author      ##author##
 * @modified    ##date##
 * @version     ##library.prettyVersion## (##library.version##)
 */

package denkgear;


import processing.core.*;
import java.io.*;
import java.net.*;
import java.lang.reflect.*;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import java.util.HashMap;


public class DenkGear extends Thread {

	PApplet parent;

	private String url;
	private int port;
	private boolean raw;
	private String data;

	Socket echoSocket = null;
	PrintWriter out = null;
	BufferedReader in = null;

	JSONParser parser;

	private Long tg_signal;
	private Long tg_raw;
	private Long tg_blinkstrength;
	private Long tg_attention, tg_meditation;
	private Long tg_delta, tg_theta, tg_lowAlpha, tg_highAlpha, tg_lowBeta, tg_highBeta, tg_lowGamma, tg_highGamma;
	private boolean tg_ready = false;
	private HashMap eSenseTable = new HashMap();
	private HashMap eegPowerTable = new HashMap();

	public final static String VERSION = "##library.prettyVersion##";

	Method signalEvent, blinkEvent, eSenseEvent, eegPowerEvent;

	/**
	 * a Constructor, usually called in the setup() method in your sketch to
	 * initialize and start the library.
	 * 
	 * @example Hello
	 * @param theParent
	 */
	public DenkGear(PApplet p) {
		parent = p;
		this.url = "127.0.0.1";
		this.port = 13854;
		this.raw = false;

		this.start();
	}

	public DenkGear(PApplet p, String url, int port, boolean raw) {
		this.parent = p;
		this.url = url;
		this.port = port;
		this.raw = raw;

		this.start();
	}

	public void start()
	{
		System.out.println("Starting thread");
		parser = new JSONParser();

		try {
			eegPowerEvent =
					parent.getClass().getMethod("eegPowerEvent",
							new Class[] { HashMap.class });
		} catch (Exception e) {

			// no such method, or an error.. which is fine, just ignore
		}

		try {
			signalEvent =
					parent.getClass().getMethod("signalEvent", new Class[] { int.class });
		} catch (Exception e) {
			System.out.println(e);
			// no such method, or an error.. which is fine, just ignore
		}
		
		try {
			blinkEvent =
					parent.getClass().getMethod("blinkEvent", new Class[] { int.class });
		} catch (Exception e) {
			System.out.println(e);
			// no such method, or an error.. which is fine, just ignore
		}

		try {
			eSenseEvent =
					parent.getClass().getMethod("eSenseEvent", new Class[] { HashMap.class });
		} catch (Exception e) {
			System.out.println(e);
			// no such method, or an error.. which is fine, just ignore
		}

		initThinkgear();
		super.start();
	}

	public void run()
	{
		while ( true ) {
			try {
				data = in.readLine();
				parseJSON(data);
			}
			catch (IOException e)
			{
				System.out.println(e);
			}
		}
	}


	private void initThinkgear() {
		System.out.println("##library.name## ##library.prettyVersion## by ##author##");

		try {
			echoSocket = new Socket(url, port);
			out = new PrintWriter(echoSocket.getOutputStream(), true);
			in = new BufferedReader(new InputStreamReader(echoSocket.getInputStream()));
			System.out.println("connect");
			out.println("{\"enableRawOutput\": " + raw + ", \"format\": \"Json\"}\n");
		} 
		catch (UnknownHostException e) {
			System.out.println("Don't know about host: " + url);
			//System.exit(1);
		} 
		catch (IOException e) {
			System.out.println("Couldn't get I/O for "
					+ "the connection to:" + url);
			//System.exit(1);
		}
	}

	private void parseJSON(String d)
	{
		if (d != null)
		{
			//println(data);
			try {
				Object obj = parser.parse(d);
				JSONObject jsonObject = (JSONObject) obj;

				// {"eSense":{"attention":0,"meditation":0},"eegPower":{"delta":59283,"theta":8704,"lowAlpha":2683,"highAlpha":598,"lowBeta":1355,"highBeta":320,"lowGamma":117,"highGamma":5125},"poorSignalLevel":200}

				if (jsonObject.containsKey("poorSignalLevel") == true)
				{
					tg_signal = (Long) jsonObject.get("poorSignalLevel");

					if (signalEvent != null) {
						try {
							signalEvent.invoke(parent, new Object[] { (int)(long)tg_signal });
						} catch (Exception e) {
							System.err.println("Disabling fancyEvent()");
							e.printStackTrace();
							signalEvent = null;
						}
					}
				}

				if (jsonObject.containsKey("rawEeg") == true)
				{
					tg_raw = (Long) jsonObject.get("rawEeg");
				}

				if (jsonObject.containsKey("blinkStrength") == true)
				{
					tg_blinkstrength = (Long) jsonObject.get("blinkStrength");
					
					if (blinkEvent != null) {
						try {
							blinkEvent.invoke(parent, new Object[] { (int)(long)tg_blinkstrength });
						} catch (Exception e) {
							System.err.println("Disabling blinkEvent()");
							e.printStackTrace();
							blinkEvent = null;
						}
					}
				}

				if (jsonObject.containsKey("eSense") == true)
				{
					JSONObject eSense = (JSONObject)jsonObject.get("eSense");
					tg_attention = (Long) eSense.get("attention");
					eSenseTable.put("attention", (int)(long)tg_attention);
					tg_meditation = (Long) eSense.get("meditation");
					eSenseTable.put("tg_meditation", (int)(long)tg_meditation);

					if (eSenseEvent != null) {
						try {
							eSenseEvent.invoke(parent, new Object[] { eSenseTable });
						} catch (Exception e) {
							System.err.println("Disabling eSenseEvent()");
							e.printStackTrace();
							eSenseEvent = null;
						}
					}

					tg_ready = true;
				}
				else
				{
					//tg_ready = false;
				}

				if (jsonObject.containsKey("eegPower") == true)
				{
					//eegPowerTable.clear();
					JSONObject eegPower = (JSONObject)jsonObject.get("eegPower");
					tg_delta = (Long) eegPower.get("delta");
					eegPowerTable.put("delta", (int)(long)tg_delta);
					tg_theta = (Long) eegPower.get("theta");
					eegPowerTable.put("theta", (int)(long)tg_theta);
					tg_lowAlpha = (Long) eegPower.get("lowAlpha");
					eegPowerTable.put("lowAlpha", (int)(long)tg_lowAlpha);
					tg_highAlpha = (Long) eegPower.get("highAlpha");
					eegPowerTable.put("highAlpha", (int)(long)tg_highAlpha);
					tg_lowBeta = (Long) eegPower.get("lowBeta");
					eegPowerTable.put("lowBeta", (int)(long)tg_lowBeta);
					tg_highBeta = (Long) eegPower.get("highBeta");
					eegPowerTable.put("highBeta", (int)(long)tg_highBeta);
					tg_lowGamma = (Long) eegPower.get("lowGamma");
					eegPowerTable.put("lowGamma", (int)(long)tg_lowGamma);
					tg_highGamma = (Long) eegPower.get("highGamma");
					eegPowerTable.put("highGamma", (int)(long)tg_highGamma);

					if (eegPowerEvent != null) {
						try {
							eegPowerEvent.invoke(parent, new Object[] { eegPowerTable });
						} catch (Exception e) {
							System.err.println("Disabling eegPowerEvent()");
							e.printStackTrace();
							eegPowerEvent = null;
						}
					}
				}
			}
			catch (Exception e)
			{

			}
		}
	}


	public synchronized HashMap getEegPower() {
		return eegPowerTable;
	}


	public String sayHello() {
		return "hello library.";
	}
	/**
	 * return the version of the library.
	 * 
	 * @return String
	 */
	public static String version() {
		return VERSION;
	}

	/**
	 * 
	 * @param theA
	 *          the width of test
	 * @param theB
	 *          the height of test
	 */
	/*
	public void setVariable(int theA, int theB) {
		myVariable = theA + theB;
	}
	 */

	/**
	 * 
	 * @return int
	 */
	/*
	public int getVariable() {
		return 1;
	}
	 */
}

