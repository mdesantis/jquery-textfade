module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    # -> coffee --compile --output lib src
    coffee:
      compile:
        files:
          'lib/jquery.textfade.js': 'src/jquery.textfade.coffee'
    
    # -> uglifyjs lib/jquery.textfade.js -o lib/jquery.textfade.min.js -m -c --comments '/^!/'
    uglify:
      options:
        compress:         true
        mangle:           true
        preserveComments: (_, comment) -> /^!/.test comment.value
      minify:
        files:
          'lib/jquery.textfade.min.js': 'lib/jquery.textfade.js'
    
    # -> coffee --watch --output lib src
    watch:
      coffee:
        files: ['src/jquery.textfade.coffee']
        tasks: 'coffee'


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'prepublish', ['coffee', 'uglify']

  null