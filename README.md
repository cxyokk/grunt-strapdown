# grunt-strapdown

> grunt task for strapdown.js

## What Is This
This [grunt](http://gruntjs.com/) task does a very stupid thing: it takes a set of markdown files and **inserts** each of them into a html template, where [strapdown.js][strapdown.github] takes care of all the rest (the parsing and the styling).

For example, this markdown file `xxx.md`:
```markdown
# I Am So Hungry
I am so hungry i can eat an elephant.
```
will be converted into a `xxx.html`:
```html
<!DOCTYPE html>
<html>
<title>a</title>
<body>
<xmp theme="cyborg" style="display:none;">
# I Am So Hungry
I am so hungry i can eat an elephant.
</xmp>
<script src="http://strapdownjs.com/v/0.2/strapdown.js"></script>
</body>
</html>
```
*(Something looks different about that `</xmp>` closing tag, see FAQ below.)*

Drop this `xxx.html` into any static web server and open it from the browser, and [strapdown.js][strapdown.github] will parse and style the markdown text for you.

## Usage
Install this plugin:
```shell
npm install --save-dev grunt-markdown
```

Then enable it in your gruntfile, e.g.:
```coffeescript
# example gruntfile in coffeescript:
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

  grunt.loadNpmTasks 'grunt-strapdown'
```

You can then run this task with `grunt strapdown`.

### Options
Follow the example gruntfile above, these are the options that the `strapdown` task accepts:

* `src`: required, pattern(s) to match markdown files.
* `dest`: required, the **directory** where generated html files will be stored in.
* `theme`: optional, defaults to 'cyborg'. See [here](https://github.com/arturadib/strapdown/tree/gh-pages/v/0.2/themes) for strapdown's bulitin themes and see [bootswatch][bootswatch] for more.
* `options.template`: optional, path to html template. Copy and modify grunt-strapdown's default template from [here][default-template] to make your own template.
* `options.templateData`: optional, data to be passed into the template. We use [lodash.template()][lodash.template].

## FAQ
1.  **So what my markdown file didn't get parsed, it's just inserted right into the middle of a html template?**

    Yes.

2.  **And then when I open the html from the browser, that `<script src="http://strapdownjs.com/v/0.2/strapdown.js">` tag is gonna get downloaded, and it's gonna do the parsing and styling for me?**

    Yes.

3.  **So i have to download a js file from somewhere else, that sounds weird and slow, why can't i just host that js file on my own server?**

    You can, but it's a little bit more complicated, **because strapdown.js is not just *a* js file**. In order to parse and style the markdown text, this js file will dynamiclly load some other js/css files from [strapdownjs.com][strapdown.com]. So you can't just host that single js file, you need to host all those other js/css files on your server, i.e. you need to clone this repo [github.com/arturadib/strapdown][strapdown.github].

    *(Use the `template` option to do this.)*

4.  **Oh, what about that `</xmp>` tag in the example? The 'x' looks different.**

    It's not the letter 'x', it's the multiplication sign '×'([wiki](http://en.wikipedia.org/wiki/Multiplication_sign)). Quote from [strapdown.js][strapdown.github]:

      > Limitations:

      > It's an unlikely scenario, but since Strapdown uses the `<xmp>` tag to wrap your Markdown (so that users don't have to escape special HTML characters), your text can't contain the string `</xmp>`.

    That's why the 'x's in `</xmp>`s are replaced by grunt-strapdown before the insertion into html.

5.  **So i read your test code, it's even longer than your task code, why do that?**

    I don't know why.

6.  **What's your favorite number?**

    42.

## License
MIT license, see [LICENSE](LICENSE).


[strapdown.com]: http://strapdownjs.com
[strapdown.github]: https://github.com/arturadib/strapdown
[bootswatch]: https://github.com/thomaspark/bootswatch/
[default-template]: https://github.com/cxyokk/grunt-strapdown/blob/master/tasks/template.html
[lodash.template]: http://lodash.com/docs#template
