# Tomcat for the security minded

## Description

This container image is built atop the official Tomcat image offered by Docker. The purpose is to add a little more control for end-users wishing to run this container in a rootless non-root configuration. This image has been tested to work with podman with a uidmap/gidmap in place. 

## Variables

**TOMCATUSER** - This is essentially just a UID filler for now. Read Only for now.


**TOMCATGROUP** - This is the GID the container will set the tomcat user to. Read Only for now. 


**TOMCATPORT** - This is the port the system system is going to be set to run on. First run bootstrap will use this to swap out the default (8080) if necessary. Defaults to 8080.


**TOMCATHOME** - This is the home folder the tomcat user will operate out of. Defaults to /usr/local/tomcat/.


## run.sh

### Description

This script is what bootstraps everything. There is a flat file in the tomcat home directory known as .firstrun. On a start command the script will look for the existence of this file to determine if this container has been configured yet. On a first run, the script will configure the port in server.xml and all relevant places in conf/ and webapps.dist to $TOMCATPORT (anywhere the default port="8080" or localhost:8080 is specified will be swapped out for $TOMCATPORT e.g. port="8085").

### Available Commands

***start*** - Detects if bootstrapping is necessary, then instructs catalina.sh to start.

***stop*** - Instructs catalina.sh to stop. (NOTE, unless you've over-ridden the default CMD, this will kill the container!)

***restart*** - Instructs catalina.sh to stop, then start. (NOTE: Unless you've over-ridden the default CMD, this will kill the container!)

***help*** - Prints Help dialog.

***healthcheck*** - Instructs the system to perform a curl at http://localhost:$TOMCATPORT and exit 1 on failure. (NOTE: Used for HEALTHCHECK)

