precision mediump float;  

attribute vec3 position;
attribute vec3 normal;
attribute vec2 uv;

// uniform mat4 modelMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
// uniform mat4 viewMatrix;
// uniform mat3 normalMatrix;
// uniform vec3 cameraPosition;

attribute float opacity;

varying float alpha;
varying vec2 vUv;

void main() {

    vUv = uv;
    alpha = opacity;
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}