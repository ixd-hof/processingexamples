#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
varying vec4 vertTexCoord;
uniform float displayCenter;

void main(void) {
	vec2 p = vertTexCoord.x < displayCenter ? vertTexCoord.xy : vec2(vertTexCoord.x-displayCenter, vertTexCoord.y);
	gl_FragColor = texture2D(texture, p);
}