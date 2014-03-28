module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    uglify:
      options:
        compress:         true
        mangle:           true
        preserveComments: (_, comment) -> /^!/.test comment.value
      main:
        files:
          'lib/jquery.textfade.min.js': ['lib/jquery.textfade.js']

  grunt.loadNpmTasks 'grunt-contrib-uglify'

  null