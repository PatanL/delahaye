precision mediump float;  

// uniform sampler2D tInput;

uniform vec2 vResolution;
uniform float fTime;
uniform sampler2D tSlow;
uniform sampler2D tNorm;
uniform sampler2D tFast;
uniform sampler2D tData;
// uniform sampler2D tUv;
// uniform sampler2D tTest;
// uniform sampler2D tMask;

uniform float fFadeLength; // 0.1

void addTransition(float i, vec2 vUv, float fLength, vec2 vPos) {

    float fRadius = texture2D(tData, vec2((i * 2.0 - 1.0) / (10.0 * 2.0), 0)).r * 1.5; // 0 to 1
    float fScene  = texture2D(tData, vec2((i * 2.0 - 1.0) / (10.0 * 2.0), 0)).g; // 0 to 1

    // Transition finished, no need to calculate, just show full result
    if (fRadius > 1.49) {
        if (fScene > 0.9) {
            gl_FragColor = texture2D(tFast, vUv);
        } else if (fScene < 0.1) {
            gl_FragColor = texture2D(tSlow, vUv);
        } else {
            gl_FragColor = texture2D(tNorm, vUv);
        }
        return;
    }

    float fTransition = (fLength - fRadius) / fFadeLength;
    fTransition = max(0.0, min(1.0, fTransition)); // Clamp between 0 and 1

    if (fScene > 0.9) {
        gl_FragColor = mix(texture2D(tFast, vUv), gl_FragColor, fTransition);
    } else if (fScene < 0.1) {
        gl_FragColor = mix(texture2D(tSlow, vUv), gl_FragColor, fTransition);
    } else {
        gl_FragColor = mix(texture2D(tNorm, vUv), gl_FragColor, fTransition);
    }
}

void main() {
    vec2 vUv = gl_FragCoord.xy / vResolution.xy; // between 0 and 1
    vec2 vPos = -1.0 + 2.0 * vUv; // between -1 and 1

    // add waviness to bulge
    vPos.y += sin(4.0 * vPos.x + 8.0 * fTime) * 0.1;
    vPos.x += cos(3.0 * vPos.y + 7.0 * fTime) * 0.1;

    float fLength = length(vPos);  

    // Default scene, only visible if more than 6 transitions on screen at the same time
    gl_FragColor = texture2D(tNorm, vUv);

    addTransition(1.0, vUv, fLength, vPos);
    addTransition(2.0, vUv, fLength, vPos);
    addTransition(3.0, vUv, fLength, vPos);
    addTransition(4.0, vUv, fLength, vPos);
    addTransition(5.0, vUv, fLength, vPos);
    addTransition(6.0, vUv, fLength, vPos);
    addTransition(7.0, vUv, fLength, vPos);
    addTransition(8.0, vUv, fLength, vPos);
    addTransition(9.0, vUv, fLength, vPos);
    addTransition(10.0, vUv, fLength, vPos);
}





