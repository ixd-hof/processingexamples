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
