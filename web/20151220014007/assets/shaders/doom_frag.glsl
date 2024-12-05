precision mediump float;  

uniform sampler2D tInput;

uniform vec2 vResolution;
uniform float fTime;
uniform float fBulgeFactor;
uniform float fBulgeLength;
uniform bool fBulgeDirection;
uniform float fDoom;

vec2 addDoom(vec2 vUv, float fLength, vec2 vPos) {

    // Transition finished, no need to calculate, just show full result
    // if (fDoom > 1.49) {
        // return vUv;
    // }

    // double pi = 3.1415926535897932384626433832795;
    float pi = 3.14159;
    float fBulge = 0.0;
    float fDist = max(0.0, fLength - fDoom);

    fBulge = 1.0 * (0.5 + 0.5 * cos((20.0 * fLength) / (1.0 * fBulgeLength * pi) - 2.0 * fTime * pi));
    fBulge *= fDist;

    if (fBulgeDirection) {
        vUv = vUv + (vPos / fLength) * fBulge * fBulgeFactor;
    } else {
        vUv = vUv - (vPos / fLength) * fBulge * fBulgeFactor;
    }

    return vUv;
}

void main() {
    vec2 vUv = gl_FragCoord.xy / vResolution.xy; // between 0 and 1
    vec2 vPos = -1.0 + 2.0 * vUv; // between -1 and 1

    // add waviness to bulge
    vPos.y += sin(4.0 * vPos.x + 1.0 * fTime) * 0.1;
    vPos.x += cos(3.0 * vPos.y + 0.7 * fTime) * 0.1;

    float fLength = length(vPos);  

    vUv = addDoom(vUv, fLength, vPos);


    gl_FragColor = texture2D(tInput, vUv);

    float fDist = min(1.0, 1.2 * max(0.0, fLength - fDoom));
    gl_FragColor.rgb *= (1.0 - fDist);
    gl_FragColor.r = mix(gl_FragColor.r, gl_FragColor.g, fDist);
    gl_FragColor.b = mix(gl_FragColor.b, gl_FragColor.g, fDist);

}





