_ = require('lodash')
fs = require('fs')
wrench = require('wrench')
path = require('path')

class Gake
  # returns a file name without the extension, given a relative filename and a root directory,
  # useful for object mapping
  fileNameFromPath= (fileWithPath, basePath)->
    #getting the file with the extension
    fileWithExtension = path.relative(basePath, fileWithPath).split(path.sep).pop()
    #removing the extension
    path.basename(fileWithExtension, path.extname(fileWithPath))

  # loads grunt configuration from a specified directory
  # arguments:
  #  grunt - a grunt instance
  #  options -
  @loadConfig: (grunt, options = {}) ->
    defaults = {
      configDir: './lib/grunt/config'
    }
    options = _.defaults(options, defaults)

    object = grunt.config.data
    grunt.file.expand([path.join(options.configDir, "/**/*.{coffee,js}")])
      .forEach((option)->
        tempObject = object;
        path.relative(options.configDir, option).split(path.sep).forEach( (key) ->
          unless (grunt.util._.isString(tempObject) || grunt.util._.isString(tempObject[key]))
            tempObject[key] = tempObject[key] || {}
            tempObject = tempObject[key]
        )
        file = fileNameFromPath(option, options.configDir)
        tempObject[file] = require(path.resolve(option))
      )
    object

  @loadTasks: (grunt, options = {})->
    defaults = {
      taskDir: './lib/grunt/tasks'
    }
    options = _.defaults(options, defaults)

    unless grunt.file.exists(options.taskDir)
      return grunt.log.error('Tasks directory "' + options.taskDir + '" not found.');

    grunt.loadTasks(options.taskDir)
    wrench.readdirSyncRecursive(options.taskDir)
      .map((dir) -> path.resolve(options.taskDir, dir))
      .filter((file)->fs.statSync(file).isDirectory())
      .forEach((fullPathDir)->grunt.loadTasks(fullPathDir))

module.exports = Gake