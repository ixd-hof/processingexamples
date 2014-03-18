#pragma once

#include "ofMain.h"
#include "ofxOculusRift.h"
#include "ofxOsc.h"

class testApp : public ofBaseApp
{
	public:
		void setup();
		void update();
		void draw();
    
        ofxOscSender sender;
			
		ofxOculusRift		oculusRift;
	
		ofEasyCam			cam;
    
        void mouseMoved(int x, int y);
};
