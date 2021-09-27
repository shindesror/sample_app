/* globals require, process, __dirname */
'use strict';

const gulp = require('gulp');
const sass = require('gulp-sass');

const babel = require('gulp-babel');
const concat = require('gulp-concat');

let browserSync = require('browser-sync').create();
let notify = require('gulp-notify');
let sourcemaps = require('gulp-sourcemaps');

// Compile sass into CSS & auto-inject into browsers
gulp.task('app-css', () => {
  return gulp
    .src('assets/scss/application.scss')
    .pipe(sourcemaps.init())
    .pipe(sass())
    .on('error', notify.onError())
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('public/assets/css'))
    .pipe(browserSync.stream({ match: '**/*.css' }));
});

gulp.task('app-js', () => {
  const files = ['assets/js/application.js', 'assets/js/application/invoices.js'];
  return gulp
    .src(files)
    .pipe(sourcemaps.init())
    .pipe(
      babel({
        presets: ['@babel/preset-env'],
        sourceType: 'unambiguous',
      })
    )
    .on('error', notify.onError())
    .pipe(concat('application.js'))
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('public/assets/js'));
});

gulp.task('serve', () => {
  browserSync.init({
    proxy: {
      target: 'http://localhost:3003',
      proxyReq: [
        proxyReq => {
          // fix ActionController::InvalidAuthenticityToken error where
          // HTTP Origin header (http://localhost:3001) didn't match request.base_url (http://localhost:3000)
          proxyReq.setHeader('HOST', 'localhost:3004'); //
        },
      ],
    },
    open: false,
    port: 3004,
    ghostMode: false, // do not replicate clicks/forms/scroll across opened browsers
    notify: false, // hide browser notifications
  });

  gulp.watch(
    ['assets/scss/application.scss', 'assets/scss/application/**/*.scss'],
    gulp.series('app-css')
  );
  gulp.watch(['assets/js/application.js', 'assets/js/application/**/*.js'], gulp.series('app-js'));

  gulp.watch('public/assets/js/*.js').on('change', browserSync.reload);
  gulp.watch('app/views/**/*.html.erb').on('change', browserSync.reload);
});

gulp.task('compile-assets', done => {
  gulp.series(gulp.parallel('app-css', 'app-js'))();
  done();
});

gulp.task('default', gulp.series('compile-assets', 'serve'));
