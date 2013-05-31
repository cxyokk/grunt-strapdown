
module.exports = (grunt)->
  _ = require 'lodash'
  path = require 'path'

  strapdownEscape = (text)->
    pattern = /<\/xmp>/g
    replacement = '</×mp>' # letter 'x' to multiplication sign '×'
    count = text.match(pattern)
    if not count
      return {text: text, count: 0}
    return {text: text.replace(pattern,replacement), count: count.length}

  grunt.registerMultiTask 'strapdown', 'compiles markdown files into strapdown template', ->
    options = @options
      template: "#{__dirname}/template.html"
      templateData:
        theme: 'cyborg'
    if @data.theme
      options.templateData.theme = @data.theme
    template = grunt.file.read options.template
    @files.forEach (f)->
      grunt.file.expand({fileter:'isFile'}, f.src).forEach (filepath)->
        {text:content,count:count} = strapdownEscape grunt.file.read filepath
        title = path.basename filepath, '.md'
        _.merge options.templateData,
          content: content
          title: title
        html = _.template template, options.templateData
        dest = path.join f.dest, "#{title}.html"

        grunt.file.write dest, html

        grunt.log.write "#{filepath} -> #{dest}"
        if count > 0
          grunt.log.write ", escaped #{count} '</xmp>'"
        grunt.log.write('...').ok()
