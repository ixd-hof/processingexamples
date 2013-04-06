/**
 * ##library.name##
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

package org.ixdhof.speechrecognizer;


import processing.core.*;
import java.lang.reflect.Method;
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import org.json.simple.*;
import org.json.simple.parser.JSONParser;
import java.util.HashMap;

import ddf.minim.*;


public class Recognizer extends Thread {
	
	PApplet parent;
    private static final String GOOGLE_RECOGNIZER_URL_NO_LANG = "https://www.google.com/speech-api/v1/recognize?xjerr=1&client=chromium&lang=";
    
    private Method recognizerEvent;
    
    private String response;
    private int status;
    private String id;
    private String utterance;
    private float confidence;
    
    private String language;
    private String next_wave;
    private String next_language;
    
    private boolean recognizing;
    
    public boolean listening;
	
	public final static String VERSION = "##library.prettyVersion##";
	
	Minim minim;
	AudioInput in;
	AudioRecorder recorder;
	String record_file = "recognize.wav";
	

	/**
	 * a Constructor, usually called in the setup() method in your sketch to
	 * initialize and start the library.
	 * 
	 * @example Recognizer
	 * @param theParent
	 */
	public Recognizer(PApplet theParent) {
		parent = theParent;
		System.out.println("##library.name## ##library.prettyVersion## by ##author##");
		
		try {
			recognizerEvent = parent.getClass().getMethod("recognizerEvent", new Class[] { String.class });
		} catch (Exception e) {
			// no such method, or an error.. which is fine, just ignore
		}
		
		minim = new Minim(parent);
		in = minim.getLineIn(Minim.MONO, 1024, 8000, 16);
		recorder = minim.createRecorder(in, record_file, true);
		
		this.start();
		
	}
	
	public void start()
	{
		super.start();
	}
	
	public void run()
	{
		while (true) {
			if(recognizing == true)
			{
			try {
				do_recognize(next_wave, next_language);
				recognizing = false;
			}
			catch (Exception e) {
		      }
			}
			
		      try {
		        sleep((long)(100));
		      } 
		      catch (Exception e) {
		      }
		    }
	}
	
	
	/**
     * Returns the status code of the last recognition<br>
     * * @return int
     */
	public int get_status()
	{
		return status;
	}
	
	
	/**
     * Returns the id of the last recognition<br>
     * * @return String
     */
	public String get_id()
	{
		return id;
	}
	
	
	/**
     * Returns the recognized String<br>
     * * @return String
     */
	public String get_utterance()
	{
		return utterance;
	}
	
	
	/**
     * Returns the confidence of the last recognition from 0-1<br>
     * * @return float
     */
	public float get_confidence()
	{
		return confidence;
	}
	
	
	/**
     * Records a wave file in order to recognize with recognize()<br>
     *
     */
	public void listen()
	{
		listening = true;
		recorder = minim.createRecorder(in, record_file, true);
		recorder.beginRecord();
	}
	
	
	/**
     * Performs a request of the recorded audio to Google with a language string<br>
     *
     * @param language Language code (en-US, de, fr, es)
     */
	public void recognize(String lang)
	{
		listening = false;
		language = lang;
		if ( recorder.isRecording() ) 
	    {
			recorder.endRecord();
			recorder.save();
			recognize(record_file, language);
	    }
		else
		{
			parent.println("Please call listen() before starting recognition.");
		}
	}
	
	/**
     * Performs a request to Google with a wave file and a language string <br>
     *
     * @param waveString Input .wav file (recorded with i.e. Minim)
     * @param language Language code (en-US, de, fr, es)
     * @throws Exception Throws exception if something went wrong
     */
	public void recognize(String waveString, String language) {
		next_wave = waveString;
		next_language = language;
		recognizing = true;
	}
	
	private void do_recognize(String waveString, String language) throws Exception {
		//"en-US"
		
		URL url;
        URLConnection urlConn;
        OutputStream outputStream;
        BufferedReader br;
        
        File waveFile = new File(parent.sketchPath(waveString));
        
		FlacEncoder flacEncoder = new FlacEncoder();
        File flacFile = new File(waveFile + ".flac");

        flacEncoder.convertWaveToFlac(waveFile, flacFile);

        // URL of Remote Script.
        url = new URL(GOOGLE_RECOGNIZER_URL_NO_LANG + language);

        // Open New URL connection channel.
        urlConn = url.openConnection();

        // we want to do output.
        urlConn.setDoOutput(true);

        // No caching
        urlConn.setUseCaches(false);

        // Specify the header content type.
        urlConn.setRequestProperty("Content-Type", "audio/x-flac; rate=8000");

        // Send POST output.
        outputStream = urlConn.getOutputStream();

        FileInputStream fileInputStream = new FileInputStream(flacFile.getAbsolutePath());

        byte[] buffer = new byte[256];

        while ((fileInputStream.read(buffer, 0, 256)) != -1) {
            outputStream.write(buffer, 0, 256);
        }

        fileInputStream.close();
        outputStream.close();

        // Get response data.
        br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));

        response = br.readLine();

        br.close();
        
        flacFile.delete();
        waveFile.delete();
        
        try
        {
        JSONParser parser = new JSONParser();
        Object obj = parser.parse(response);
		JSONObject jsonObject = (JSONObject) obj;
		HashMap returnValues = new HashMap();
		
		if (response.contains("utterance"))
		{			
			status = (int)(long)(Long)jsonObject.get("status");
			id = (String)jsonObject.get("id");
			JSONArray hypotheses_array = (JSONArray)jsonObject.get("hypotheses");
			JSONObject hypotheses = (JSONObject)hypotheses_array.get(0);
			utterance = (String)hypotheses.get("utterance");
			confidence = (float)(double)(Double)hypotheses.get("confidence");
		}
		else
		{
			utterance = null;
		}
        
        if (recognizerEvent != null) {
			try {
				recognizerEvent.invoke(parent, new Object[] { utterance });
			} catch (Exception e) {
				System.err.println("Disabling recognizerEvent()");
				e.printStackTrace();
				recognizerEvent = null;
			}
		}
        }
        catch (Exception e) { parent.println(e); }
        
        recognizing = false;
	}
}

