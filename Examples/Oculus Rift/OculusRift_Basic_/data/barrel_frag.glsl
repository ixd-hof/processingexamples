#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform mat4 texMatrix;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 LensCenter;
uniform vec2 ScreenCenter;
uniform vec2 Scale;
uniform vec2 ScaleIn;
uniform vec4 HmdWarpParam;

vec2 HmdWarp(vec2 texIn)
{
   vec2 theta = (texIn - LensCenter) * ScaleIn;
   float rSq = theta.x * theta.x + theta.y * theta.y;
   vec2 theta1 = theta * (HmdWarpParam.x + HmdWarpParam.y * rSq + HmdWarpParam.z * rSq * rSq + HmdWarpParam.w * rSq * rSq * rSq);
   return LensCenter + Scale * theta1;
}

void main()
{
   vec2 tc = HmdWarp(vertTexCoord.xy); //gl_TexCoord[0].xy);
   if (any(notEqual(clamp(tc, ScreenCenter-vec2(0.25,0.5), ScreenCenter+vec2(0.25, 0.5)) - tc, vec2(0.0, 0.0))))
       gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
   else
       gl_FragColor = texture2D(texture, tc);
}