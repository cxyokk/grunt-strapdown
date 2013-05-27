path = require 'path'
grunt = require 'grunt'

exports.strapdown =
  test: (test)->
    files = grunt.file.glob.sync 'test/fixtures/*.md'
    if files.length < 1
      test.ok false, 'wth? nothing in fixures...'
    test.expect files.length
    files.forEach (f)->
      f = path.basename f, '.md'
      actualFile = "temp-test/#{f}.html"
      expectedFile = "test/expected/#{f}.html"
      actual = grunt.file.read actualFile
      expected = grunt.file.read expectedFile
      test.equal actual, expected, "#{actualFile} should be the same as #{expectedFile}"
    test.done()
