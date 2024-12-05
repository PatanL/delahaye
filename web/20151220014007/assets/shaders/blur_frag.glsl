precision mediump float;

uniform sampler2D tInput;
uniform sampler2D tMask;
uniform vec2 vResolution;
uniform float fBlur;

void main() {

    vec2 vUv = gl_FragCoord.xy / vResolution.xy;

    vec4 sum = vec4(0.0);
    vec2 inc = fBlur * vec2(0.002); // Blur amount (lookup distance)

    sum += texture2D(tInput, (vUv - inc * 4.0)) * 0.051;
    sum += texture2D(tInput, (vUv - inc * 3.0)) * 0.0918;
    sum += texture2D(tInput, (vUv - inc * 2.0)) * 0.12245;
    sum += texture2D(tInput, (vUv - inc * 1.0)) * 0.1531;
    sum += texture2D(tInput, (vUv + inc * 0.0)) * 0.1633;
    sum += texture2D(tInput, (vUv + inc * 1.0)) * 0.1531;
    sum += texture2D(tInput, (vUv + inc * 2.0)) * 0.12245;
    sum += texture2D(tInput, (vUv + inc * 3.0)) * 0.0918;
    sum += texture2D(tInput, (vUv + inc * 4.0)) * 0.051;

    // gl_FragColor = sum;
    gl_FragColor = mix(texture2D(tInput, vUv), sum, texture2D(tMask, vUv).r);

}