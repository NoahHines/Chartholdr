// Render the chart

var system = require('system');
var fs = require('fs');
var path = system.args[1];
var opened = fs.open(path, "r");
var data = fs.read(path);
var jsonData = JSON.parse(data);

fs.write("var.txt", jsonData["template"], 'w');

var page = require('webpage').create();
page.viewportSize = { width: jsonData["width"], height: jsonData["height"] };
page.open(jsonData["template"], function start(status) {
  page.render('render.png', {format: 'png', quality: '2'});
  phantom.exit();
});