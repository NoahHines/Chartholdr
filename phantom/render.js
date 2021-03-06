// Render the chart

var system = require('system');
var fs = require('fs');
var path = system.args[1];
var opened = fs.open(path, "r");
var data = fs.read(path);
var jsonData = JSON.parse(data);

var page = require('webpage').create();
page.viewportSize = { width: jsonData["width"], height: jsonData["height"] };
page.open(jsonData["template"], function start(status) {
  page.render(jsonData["image"], {format: 'png', quality: '2'});
  phantom.exit();
});