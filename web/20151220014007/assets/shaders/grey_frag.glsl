precision mediump float;

uniform sampler2D tInput;
uniform vec2 vResolution;
uniform float fAmount;

void main() {
    vec2 vUv = gl_FragCoord.xy / vResolution.xy;

    // If 0, skip
    if (fAmount == 0.0) {
        gl_FragColor = texture2D(tInput, vUv);
        return;
    }

    // vec3 luma = vec3(0.299, 0.587, 0.114);
    // vec4 color = texture2D(tInput, vUv);
    // vec4 sum = vec4(vec3(dot(color.rgb, luma)), color.a);

    vec4 sum = vec4(texture2D(tInput, vUv).b, texture2D(tInput, vUv).b, texture2D(tInput, vUv).b, 1.0);

    gl_FragColor = mix(texture2D(tInput, vUv), sum, fAmount);
}