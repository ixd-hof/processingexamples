// STRETCH
// Based on "wowwow" https://www.shadertoy.com/view/4slGR8 by dawik

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

// Type of shader expected by Processing
#define PROCESSING_TEXTURE_SHADER

// Processing specific input
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;

// Layer between Processing and Shadertoy uniforms
uniform sampler2D texture;
uniform mat4 texMatrix;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 mousePressed; // (0.0,0.0) no click, (1.0,1.0) left mouse button pressed
vec4 iMouse = vec4(mouse.xy,mousePressed.xy);

uniform sampler2D colorMap;
uniform sampler2D noiseMap;

// ------- Below is the unmodified Shadertoy code ----------

const float pi  = 3.14159265359;
void main(void)
{
	vec3 noiseVec;
	vec2 displacement;
	float scaledTimer;

	displacement = vertTexCoord.st;

	scaledTimer = time *0.1;

	//displacement.x = 0.001; //+= scaledTimer;
	//displacement.y = 1.0; //mouse[1]*0.1; //-= scaledTimer;

	noiseVec = normalize(texture2D(noiseMap, displacement.xy).xyz);
	noiseVec = (noiseVec * 2.0 - 1.0) * 0.035;
	
	gl_FragColor = texture2D(colorMap, vertTexCoord.st + noiseVec.xy);
	
}