precision mediump float;  

uniform samplerCube tCube;

varying vec3 vPosition;

void main() {
    gl_FragColor = textureCube(tCube, vPosition);
}
