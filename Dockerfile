FROM hub.sxt.dev:5000/jdk:1.8
ENV LANG="C.UTF-8"
COPY app.jar /opt/app/app.jar
WORKDIR /opt/app
EXPOSE 5010
CMD ["/opt/jre/bin/java", "-Duser.timezone=GMT+08", "-Dsun.jnu.encoding=UTF-8", "-Dfile.encoding=UTF-8", "-jar", "/opt/app/app.jar"]