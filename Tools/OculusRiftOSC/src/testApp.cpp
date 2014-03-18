#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup()
{
	ofSetFrameRate(999);
	ofSetVerticalSync( false );
    
    sender.setup("127.0.0.1", 10000);
		
	oculusRift.init(0,0);
}

//--------------------------------------------------------------
void testApp::update()
{


}

//--------------------------------------------------------------
void testApp::draw()
{
	// as we are not drawing anything using the headset camera class, we need to tell it we wnt new sensor data this frame.
	oculusRift.setNeedSensorReadingThisFrame( true );
	
	glEnable( GL_DEPTH_TEST );
    
    ofMatrix4x4 m = oculusRift.getHeadsetOrientationMat();
    ofLog(OF_LOG_NOTICE, ofToString(m.getRowAsVec4f(0)));
    
    ofxOscMessage msg;
    msg.setAddress("/headsetorientation");
    msg.addFloatArg(m.getRowAsVec4f(0).x);
    msg.addFloatArg(m.getRowAsVec4f(0).y);
    msg.addFloatArg(m.getRowAsVec4f(0).z);
    msg.addFloatArg(m.getRowAsVec4f(0).w);
    msg.addFloatArg(m.getRowAsVec4f(1).x);
    msg.addFloatArg(m.getRowAsVec4f(1).y);
    msg.addFloatArg(m.getRowAsVec4f(1).z);
    msg.addFloatArg(m.getRowAsVec4f(1).w);
    msg.addFloatArg(m.getRowAsVec4f(2).x);
    msg.addFloatArg(m.getRowAsVec4f(2).y);
    msg.addFloatArg(m.getRowAsVec4f(2).z);
    msg.addFloatArg(m.getRowAsVec4f(2).w);
    msg.addFloatArg(m.getRowAsVec4f(3).x);
    msg.addFloatArg(m.getRowAsVec4f(3).y);
    msg.addFloatArg(m.getRowAsVec4f(3).z);
    msg.addFloatArg(m.getRowAsVec4f(3).w);
    sender.sendMessage(msg);
	
	cam.begin();
	
		ofPushMatrix();
		
			ofTranslate( 0.0f, 0.0f, 0.0f );

			ofPushMatrix();
				ofTranslate( 0.0f, 150.0f, 0.0f );
				ofSetColor( 0, 255, 0 );
				ofLine( ofVec3f(0,0,0), oculusRift.getAcceleration() * 100.0f );
			ofPopMatrix();
	
			ofPushMatrix();

				ofMultMatrix( oculusRift.getHeadsetOrientationMat() );

				ofSetColor( 255, 0, 0 );
				ofBox( 200 );
		
				ofTranslate( 0.0f, 0.0f, 100.0f );
				ofSetColor( 0, 0, 255 );
				ofBox( 100 );

			ofPopMatrix();
	
		ofPopMatrix();
	
	cam.end();
	
	glDisable( GL_DEPTH_TEST );	
}

void testApp::mouseMoved(int x, int y){
	ofxOscMessage m;
	m.setAddress("/mouse/position");
	m.addIntArg(x);
	m.addIntArg(y);
	sender.sendMessage(m);
}
