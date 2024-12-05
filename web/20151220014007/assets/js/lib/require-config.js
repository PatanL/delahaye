var require = {
    baseUrl: 'web', // Base directory relative to index.html
    paths: {
        "svg-path-properties": "20151220014007/assets/js/lib/svg-path-properties.js" // Path relative to baseUrl without 'web/'
    },
    shim: {
        "svg-path-properties": {
            exports: "svgPathProperties"
        }
    }
};
