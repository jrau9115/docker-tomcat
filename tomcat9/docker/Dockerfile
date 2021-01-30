FROM tomcat:9-jdk11-openjdk-slim

# TODO: Possibly add a way to make these adjustable down the road for those of us who want to UID/GID match on the host.
ENV TOMCATUSER=1001
ENV TOMCATGROUP=1001
ENV TOMCATPORT=8080
ENV TOMCATHOME=/usr/local/tomcat

COPY ./.firstrun ${TOMCATHOME}/.firstrun


RUN groupadd -g ${TOMCATGROUP} tomcat
RUN useradd -d /usr/local/tomcat -u ${TOMCATUSER} -g ${TOMCATGROUP} -s /bin/false tomcat && chown -R tomcat:tomcat ${TOMCATHOME}

RUN apt-get update && apt-get install -y curl
RUN apt-get clean 
COPY ./scripts/run.sh ${TOMCATHOME}/bin/run.sh

RUN chmod 0645 ${TOMCATHOME}/bin/run.sh

HEALTHCHECK --interval=5s --timeout=3s --retries= CMD [ "/usr/local/tomcat/run.sh", "healthcheck" ]

EXPOSE ${TOMCATPORT}

USER tomcat

CMD [ "/usr/local/tomcat/bin/run.sh", "start" ]
