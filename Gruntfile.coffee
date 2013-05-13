livereload = require('grunt-contrib-livereload/lib/utils').livereloadSnippet
path = require('path')

SRC = ['src/**/*.coffee']
SPEC = ['test/spec/**/*.coffee']

module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);
  #Project Config
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    regarde:
      coffee: 
        files: SRC
        tasks: ['coffee:src']

      coffee_spec: 
        files: SPEC
        tasks: ['coffee:spec']

      livereload:
        files: ['.tmp/**/*', 'test/*.html']
        tasks: ['livereload']

      vendor:
        files: ['vendor/*']
        tasks: ['copy:vendor']

    #lint coffeescript
    coffeelint:
      options:
        max_line_length:
          level: 'ignore'
        no_trailing_whitespace:
          level: 'ignore'
      src: SRC
      spec: SPEC

    copy:
      vendor:
        files: [
          expand: true
          dot: true
          cwd: 'vendor'
          src: '**/*'
          dest: '.tmp/vendor'
        ]

      dist:
        files: [
          expand: true
          dot: true
          cwd: '.tmp'
          src: '**/*'
          dest: 'dist'
        ]
      test:
        files: [
          expand: true
          dot: true
          cwd: 'test'
          src: '**/*'
          dest: 'dist'
        ]

    coffee:
      src:
        files: [{
          expand: true
          cwd: 'src/'
          src: ['**/*.coffee']
          dest: '.tmp/src/'
          ext: '.js'
        }]

      spec:
        files: [{
          expand: true
          cwd: 'test/spec/'
          src: ['**/*.coffee']
          dest: '.tmp/spec/'
          ext: '.js'
        }]

    clean:
      temp: ['.tmp']

    mocha:
      all:
        options:
          run: true
          urls: ['http://localhost:9000/index.html']

    connect:
      livereload:
        options:
          port: 9001
          hostname: '*'
          middleware: (connect, options) ->
            static_folder = (point) ->
              connect.static path.resolve(point)

            [livereload, static_folder('.tmp'), static_folder('test')]


  grunt.registerTask 'build', [
    'clean:temp',
    'coffeelint',
    'coffee',
    'copy:vendor'
  ]
  grunt.registerTask 'watch', [
    'build',
    'livereload-start',
    'connect:livereload',
    'regarde'
  ]
  grunt.registerTask 'dist', [
    'build',
    'copy:dist'
    'copy:test'
  ]