
module.exports = (grunt)->

  process.chdir '../..' # go to module root dir

  grunt.initConfig JSON.parse grunt.file.read 'test/output/config.json'

  grunt.loadTasks 'tasks'
