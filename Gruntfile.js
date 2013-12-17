gake = require('./lib/gake');

module.exports = function (grunt) {
  var config = {
    pkg: grunt.file.exists('package.json') ? grunt.file.readJSON('package.json') : {},
    env: process.env.ENV || 'development'
  };


  gake.loadTasks(grunt, {taskDir: './test/grunt/tasks'});

  grunt.initConfig(config);
  gake.loadConfig(grunt, {configDir: './test/grunt/config'});
};
