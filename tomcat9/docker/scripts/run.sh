#!/bin/bash

# Author: James Rowe
# Description: Bootstrapper for Tomcat container and healthchecks.


function handle_err { 
    exit 1;
}


function healthcheck {
    curl -f http://localhost:$TOMCATPORT/ || handle_err
}

function help {
    echo 'Usage: run.sh {start|stop|restart|healthcheck}'
}

if [ -z $1 ]; then
    help
    exit 1
fi

case "$1" in
    healthcheck)
        healthcheck
        ;;
    help)
        help
        exit 255
        ;;
    restart)
        echo 'Restarting Tomcat'
        catalina.sh stop
        # TODO: Wait for Tomcat to Die
        
        catalina.sh start
        ;;
    start)
        if [ -f "$TOMCATHOME/.firstrun" ]; then
            echo 'First time run detected. Boostrapping'
            # TODO: Implement this portion.
            
            # if [ $(id -u tomcat) -ne $TOMCATUSER ]; then
            #     echo "Changing Tomcat UID to match $TOMCATUSER"
            #     usermod -u $TOMCATUSER tomcat
            # fi
            # if [ $(id -g tomcat) -ne $TOMCATGROUP ]; then
            #     echo "Changing Tomcat GID to match $TOMCATGROUP"
            #     groupmod -g $TOMCATGROUP tomcat
            # fi
            # chown -R tomcat:tomcat /usr/local/tomcat
            if [ $TOMCATPORT -ne 8080 ]; then
                # TODO: This is gross, but it works for now.
                echo "Changing tomcat port to $TOMCATPORT"
                for f in $(grep -rl '8080' $HOME/{conf,webapps.dist}); do sed -i "s/port=\"8080\"/port=\"$TOMCATPORT\"/g" $f; sed -i "s/localhost\:8080/localhost\:$TOMCATPORT/g" $f; done
            fi
            rm -f /usr/local/tomcat/.firstrun
        fi
        echo 'Starting Tomcat'
        catalina.sh run
        ;;
    stop)
        echo 'Stopping Tomcat'
        catalina.sh stop
        ;;

    *)
        help
        exit 1
        ;;
esac

