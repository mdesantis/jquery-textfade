module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    # -> coffee --compile --output dist src
    coffee:
      compile:
        files:
          'dist/jquery-textfade.js': 'src/jquery-textfade.litcoffee'

    # -> uglifyjs dist/jquery-textfade.js -o dist/jquery-textfade.min.js -m -c --comments '/^!/'
    # uglify:
    #   options:
    #     compress:         {}
    #     mangle:           true
    #     preserveComments: (_, comment) -> /^!/.test comment.value
    #   minify:
    #     files:
    #       'dist/jquery-textfade.min.js': 'dist/jquery-textfade.js'

    uglify:
      dist:
        options:
          sourceMap: true
          output:
            comments: (_, comment) -> /^!/.test comment.value
        files:
          'dist/jquery-textfade.min.js': 'dist/jquery-textfade.js'



    # -> coffee --watch --output dist src
    watch:
      coffee:
        files: ['src/jquery-textfade.litcoffee']
        tasks: ['prepublish']
        options:
          livereload: true

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'prepublish', ['coffee', 'uglify']

  null
