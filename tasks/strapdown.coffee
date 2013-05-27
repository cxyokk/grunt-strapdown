
module.exports = (grunt)->
  _ = require 'lodash'
  path = require 'path'

  template = grunt.file.read "#{__dirname}/template.html"

  strapdownEscape = (text)->
    pattern = /<\/xmp>/g
    replacement = '</×mp>' # letter 'x' to multiplication sign '×'
    count = text.match(pattern)
    if not count
      return {text: text, count: 0}
    return {text: text.replace(pattern,replacement), count: count.length}

  grunt.registerMultiTask 'strapdown', 'compiles markdown files into strapdown template', ->
    theme = @data.theme ? 'cyborg'
    @files.forEach (f)->
      grunt.file.expand({fileter:'isFile'}, f.src).forEach (filepath)->
        {text:content,count:count} = strapdownEscape grunt.file.read filepath
        title = path.basename filepath, '.md'
        html = _.template template, {
          content: content
          title: title
          theme: theme
        }
        dest = path.join f.dest, "#{title}.html"

        grunt.file.write dest, html

        grunt.log.write "#{filepath} -> #{dest}"
        if count > 0
          grunt.log.write ", escaped #{count} '</xmp>'"
        grunt.log.write('...').ok()
