Pretend You're Xyzzy
===================

A Cards Against Humanity clone, server and web client. See WebContent/license.html for full details.

Note: This project is only known to work with Tomcat 7, all other versions are unsupported. 
Currently, the only way to build PYX is using Maven via ```mvn clean package war:war``` in the project's directory.


If you're doing ```mvn clean package war:exploded jetty:run```, you now need to add ```-Dmaven.buildNumber.doCheck=false -Dmaven.buildNumber.doUpdate=false``` to make the buildnumber plugin allow you to run with uncommited changes.


For GeoIP functions to work, download http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz somewhere, gunzip it, and update the geoip.db value in build.properties to point to it.

## Third-Party Usage

A Docker package for this project exists at [emcniece/DockerYourXyzzy](https://github.com/emcniece/DockerYourXyzzy):

```sh
docker run -d -p 8080:8080 emcniece/dockeryourxyzzy:dev
```
