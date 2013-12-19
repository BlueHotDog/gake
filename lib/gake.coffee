_ = require('lodash')
fs = require('fs')
wrench = require('wrench')
path = require('path')

DEFAULT_CONFIG_DIR = './grunt/config'
DEFAULT_TASKS_DIR = './grunt/tasks'

class Gake
  # returns a file name without the extension, given a relative filename and a root directory,
  # useful for object mapping
  fileNameFromPath = (fileWithPath, basePath)->
    #getting the file with the extension
    fileWithExtension = path.relative(basePath, fileWithPath).split(path.sep).pop()
    #removing the extension
    path.basename(fileWithExtension, path.extname(fileWithPath))

  constructor: (@grunt) ->

  use: ->
    @loadConfig(@grunt)
    @loadTasks(@grunt)
    @

  # loads grunt configuration from a specified directory
  # arguments:
  #  grunt - a grunt instance
  #  options -
  loadConfig: (grunt) ->
    configDir = grunt.option('configDir') || DEFAULT_CONFIG_DIR
    object = grunt.config.data
    grunt.file.expand([path.join(configDir, "/**/*.{coffee,js}")])
    .forEach((configFile)->
        tempObject = object;
        path.relative(configDir, configFile).split(path.sep).forEach((key) ->
          unless (grunt.util._.isString(tempObject) || grunt.util._.isString(tempObject[key]))
            tempObject[key] = tempObject[key] || {}
            tempObject = tempObject[key]
        )
        file = fileNameFromPath(configFile, configDir)
        tempObject[file] = require(path.resolve(configFile))
      )
    object

  loadTasks: (grunt)->
    taskDir = grunt.option('taskDir') || DEFAULT_TASKS_DIR
    unless grunt.file.exists(taskDir)
      return grunt.log.error('Tasks directory "' + taskDir + '" not found.');

    grunt.loadTasks(taskDir)
    wrench.readdirSyncRecursive(taskDir)
      .map((dir) ->path.resolve(taskDir, dir))
      .filter((file)->fs.statSync(file).isDirectory())
      .forEach((fullPathDir)->grunt.loadTasks(fullPathDir))

module.exports = Gake