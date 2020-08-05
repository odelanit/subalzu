const mix = require('laravel-mix');

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel application. By default, we are compiling the Sass
 | file for the application as well as bundling up all the JS files.
 |
 */

// mix.js('src/js/order_create.js', '../dist/js')
//     .sass('src/sass/app.scss', '../dist/css');
mix.js('src/js/order_create.js', 'dist/js')
    .js('src/js/order_edit.js', 'dist/js');
