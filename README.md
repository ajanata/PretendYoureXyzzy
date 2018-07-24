Pretend You're Xyzzy
===================

A Cards Against Humanity clone, server and web client. Play at http://pyx.gianlu.xyz/

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Build

To build this using Maven run `mvn clean package`, then execute `java -jar target/PYX-jar-with-dependencies.jar --pyx.server.port=80`.

For GeoIP functions to work, download http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz somewhere, gunzip it, and update the geoip.db value in build.properties to point to it.

## Server discovery API

Due to the recent unavailability of the main PYX servers I've implemented the server discovery feature. It allows any server to be discovered by the main API which will then provide a list of available servers for everyone to connect to them.

By default this feature is disabled. To enable it:

 - Find your `build.properties` file (copy it from `build.properties.example` if you don't have one)
 - Set `pyx.server_discovery_enabled` to `true`
 - Set `pyx.server_discovery_address` to your external IP address or domain
 - Set `pyx.server_discovery_port` to the external port
 - Open the necessary ports on your router/firewall
 - Deploy! In a few minutes, if your configuration is correct, your server will appear [here](https://script.google.com/macros/s/AKfycbxaWVr4sEiivlmw_0WqNaYXyMwkZGoarBXcQ7HfZ3tJ53WFqogG/exec?op=list).