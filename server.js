var http = require('http');
var express = require('express');
var graff = require('graff');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World\nApp (prooferb) is running..');
}).listen(9511);
