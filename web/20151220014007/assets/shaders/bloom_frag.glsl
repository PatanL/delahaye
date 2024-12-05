precision mediump float;  

uniform sampler2D tInput;
uniform vec2 vResolution;

void main() {
    vec4 sum = vec4(0);
    vec2 texcoord = gl_FragCoord.xy / vResolution.xy; // between 0 and 1

    for(int i= -4 ;i < 4; i++) {
        for (int j = -3; j < 3; j++) {
            sum += texture2D(tInput, texcoord + vec2(j, i) * 0.004) * 0.15;
        }
    }
    if (texture2D(tInput, texcoord).r < 0.3) {
        gl_FragColor = sum * sum * 0.012 + texture2D(tInput, texcoord);
    } else {
        if (texture2D(tInput, texcoord).r < 0.5) {
            gl_FragColor = sum * sum * 0.009 + texture2D(tInput, texcoord);
        } else {
            gl_FragColor = sum * sum * 0.0075 + texture2D(tInput, texcoord);
        }
    }
}


// Pixelate
// void main() {
//     vec2 vUv = gl_FragCoord.xy / vResolution.xy; // between 0 and 1

//     float d = 1.0 / 128.0;
//     float ar = 800.0 / 600.0;
//     float u = floor( vUv.x / d ) * d;
//     d = ar / 128.0;
//     float v = floor( vUv.y / d ) * d;
//     gl_FragColor = texture2D( tInput, vec2( u, v ) );
// }