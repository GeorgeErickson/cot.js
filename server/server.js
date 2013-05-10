#!/usr/bin/env node


Onramp = require('onramp');
  



var host = "8080";

// Create the onramp instance at the localhost
var onramp = Onramp.create({host: host});

// Whenever a connection is established, tell it about all the 
// other connections available, and then broadcast it's connection
// identifier to the rest of the connections so everyone always
// knows who is connected to the onramp
onramp.on("connection", function(connection){
  console.log('new connection: ' + connection.id);
  onramp.connections.forEach(function(other){
    if(other === connection) return;
    
    connection.send('remote address', other.id);
    other.send('remote address', connection.id);
  });
});
