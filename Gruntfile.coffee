
module.exports = (grunt)->
  grunt.initConfig
    strapdown:
      default:
        src: ['path/to/*.md']
        dest: 'output_dir'
      change_theme:
        src: ['path/to/*.md']
        dest: 'output_dir'
        theme: 'slate'
      custom_template:
        src: ['path/to/*.md']
        dest: 'output_dir'
        options:
          template: 'path/to/your/template.html'
          templateData:
            charset: 'utf8'
            version: '1.0'
            whatever: 'you want'

  grunt.loadTasks 'tasks'

  # this is just an example
