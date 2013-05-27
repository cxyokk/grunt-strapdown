
module.exports = (grunt)->
  grunt.initConfig
    strapdown:
      test:
        src: ['test/fixtures/*.md']
        dest: 'temp-test'
        theme: 'cyborg'

    nodeunit:
      test: ['test/*.{coffee,js}']

    clean:
      test: ['temp-test']

  grunt.loadTasks 'tasks'
  grunt.loadNpmTasks 'grunt-contrib-nodeunit'
  grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.registerTask 'mkdir', grunt.file.mkdir
  grunt.registerTask 'test', [
    'clean'
    'mkdir:temp-test'
    'strapdown'
    'nodeunit'
    'clean'
  ]
  grunt.registerTask 'default', ['test']
