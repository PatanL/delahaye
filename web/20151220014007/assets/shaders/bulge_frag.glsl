precision mediump float;  

uniform sampler2D tInput;

uniform vec2 vResolution;
uniform float fTime;

uniform sampler2D tData;
uniform float fBulgeFactor; //0.05
uniform float fBulgeLength; // 0.1
uniform bool fBulgeDirection;
uniform float fFadeLength; // 0.1

vec2 addBulge(float i, vec2 vUv, float fLength, vec2 vPos) {
    float fRadius = texture2D(tData, vec2((i * 2.0 - 1.0) / (10.0 * 2.0), 0)).r * 1.5; // 0 to 1
    float fScene  = texture2D(tData, vec2((i * 2.0 - 1.0) / (10.0 * 2.0), 0)).g; // 0 to 1

    // Transition finished, no need to calculate, just show full result
    if (fRadius > 1.49) {
        return vUv;
    }

    // double pi = 3.1415926535897932384626433832795;
    float pi = 3.14159;
    float fBulge = 0.0;
    float fDist = fLength - fRadius;

    if (fDist < fBulgeLength && fDist > -fBulgeLength) {
        float fSign = step(0.0, fDist) * 2.0 - 1.0;
        fBulge = fSign * (0.5 + 0.5 * cos((20.0 * fDist) / (1.0 * fBulgeLength * pi) - pi));
    
        if (fBulgeDirection) {
            vUv = vUv + (vPos / fLength) * fBulge * fBulgeFactor;
        } else {
            vUv = vUv - (vPos / fLength) * fBulge * fBulgeFactor;
        }
    }

    // gl_FragColor = texture2D(tInput, vUv);
    return vUv;
}

void main() {
    
    // BULGE
    vec2 vUv = gl_FragCoord.xy / vResolution.xy; // between 0 and 1
    vec2 vPos = -1.0 + 2.0 * vUv; // between -1 and 1

    // add waviness to bulge
    vPos.y += sin(4.0 * vPos.x + 8.0 * fTime) * 0.1;
    vPos.x += cos(3.0 * vPos.y + 7.0 * fTime) * 0.1;

    float fLength = length(vPos);  

    vUv = addBulge(1.0, vUv, fLength, vPos);
    vUv = addBulge(2.0, vUv, fLength, vPos);
    vUv = addBulge(3.0, vUv, fLength, vPos);
    vUv = addBulge(4.0, vUv, fLength, vPos);
    vUv = addBulge(5.0, vUv, fLength, vPos);
    vUv = addBulge(6.0, vUv, fLength, vPos);
    vUv = addBulge(7.0, vUv, fLength, vPos);
    vUv = addBulge(8.0, vUv, fLength, vPos);
    vUv = addBulge(9.0, vUv, fLength, vPos);
    vUv = addBulge(10.0, vUv, fLength, vPos);

    gl_FragColor = texture2D(tInput, vUv);
}





