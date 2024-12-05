precision mediump float;  

uniform sampler2D tDiffuse;

varying vec2 vUv;
varying float alpha;

void main() {

    gl_FragColor = texture2D(tDiffuse, vUv);
    gl_FragColor.a = alpha;
}
