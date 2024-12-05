precision mediump float;  

uniform sampler2D tInput;

uniform vec2 vResolution;
uniform float fTime;

// uniform vec2 center;
uniform float fZoomBlur;


void main() {
    vec2 vUv = gl_FragCoord.xy / vResolution.xy; // between 0 and 1
    vec2 vPos = -1.0 + 2.0 * vUv; // between -1 and 1

    // gl_FragCoord = texture2D(tInput, vUv);

    vec4 sum = vec4(0.0);

    // vec2 toCenter = center - vUv * resolution;
    // vec2 inc = toCenter * strength / resolution;

    // inc = center / resolution - vUv;

    vec2 inc = vPos * fZoomBlur * 0.005;
    
    sum += texture2D(tInput, (vUv - inc * 4.0)) * 0.051;
    sum += texture2D(tInput, (vUv - inc * 3.0)) * 0.0918;
    sum += texture2D(tInput, (vUv - inc * 2.0)) * 0.12245;
    sum += texture2D(tInput, (vUv - inc * 1.0)) * 0.1531;
    sum += texture2D(tInput, (vUv + inc * 0.0)) * 0.1633;
    sum += texture2D(tInput, (vUv + inc * 1.0)) * 0.1531;
    sum += texture2D(tInput, (vUv + inc * 2.0)) * 0.12245;
    sum += texture2D(tInput, (vUv + inc * 3.0)) * 0.0918;
    sum += texture2D(tInput, (vUv + inc * 4.0)) * 0.051;

    gl_FragColor = sum;
}

