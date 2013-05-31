should = require('chai').should()
exec = require('child_process').exec
file = require('grunt').file
path = require 'path'

config =
  dirs:
    fixtures: 'test/fixtures'
    expected: 'test/expected'
    output: 'test/output'
  strapdown:
    seems_fine:
      src: ['<%= dirs.fixtures %>/*.md']
      dest: '<%= dirs.output %>'
    custom_template:
      src: ['<%= dirs.fixtures %>/*.md']
      dest: '<%= dirs.output %>'
      theme: 'slate'
      options:
        template: '<%= dirs.fixtures %>/test-template.html'
        templateData:
          version: '3.4'

# run grunt task in a child process
gtask = (task, cb)->
  exec "grunt --gruntfile #{config.dirs.fixtures}/test-gruntfile.coffee strapdown:#{task}", cb

# expect every .html in expectedDir should has a match in output dir.
# expectedDir should be the subpath in config.dirs.expected.
expect_output = (expectedDir)->
  expectedDir = config.dirs.expected + '/' + expectedDir
  file.glob.sync(expectedDir+'/*.html').forEach (f)->
    filename = path.basename f
    output = file.read config.dirs.output+'/'+filename
    expected = file.read f
    output.should.equal expected

describe 'grunt-strapdown', ->
  beforeEach ->
    if file.exists config.dirs.output
      file.delete config.dirs.output
    file.mkdir config.dirs.output
    file.write config.dirs.output+'/config.json', JSON.stringify config

  afterEach ->
    file.delete config.dirs.output

  describe 'when all seems fine', ->
    it 'should work', (done)->
      gtask 'seems_fine', ->
        expect_output 'seems-fine'
        done()

  describe 'when using custom template', ->
    it 'should work', (done)->
      gtask 'custom_template', ->
        expect_output 'custom-template'
        done()
