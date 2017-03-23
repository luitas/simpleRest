FROM maven:3.3.9-jdk-8

#https://youtrack.jetbrains.com/issue/WI-32733

#RUN apt-get update
RUN export http_proxy=http://91.199.55.3:3128 \
    && export https_proxy=http://91.199.55.3:3128 \
    && export no_proxy=".kada.lan,.registrucentras.lt,.kada.lt" \
    && apt-get update \
    && apt-get install -y nano


WORKDIR /code
# FOR Test
#COPY pom1.xml /code/
#COPY settings1.xml /code/
#RUN ["mvn", "-s", "settings1.xml", "-f", "pom1.xml", "dependency:resolve"]

#VOLUME ["/root/.m2/repository"]

COPY *.xml /code/
#Real
#RUN cp /code/settings-security.xml /usr/share/maven/conf/settings-security.xml
#RUN cp /code/settings-security.xml /root/.m2/settings-security.xml

#RUN ls -la ~/.m2/

RUN export http_proxy=http://91.199.55.3:3128 \
    && export https_proxy=http://91.199.55.3:3128 \
    && export no_proxy=".kada.lan,.registrucentras.lt,.kada.lt"
#    && mvn -s settings.xml dependency:resolve

RUN ["mvn", "-s", "settings.xml", "dependency:resolve"]
RUN ["mvn", "-s", "settings.xml", "verify"]

COPY src /code/src
RUN export TZ=Europe/Vilnius
RUN ["mvn", "-s", "settings.xml", "package"]

##ENV test "Tetas"
##ENV username "IGOR"
#
EXPOSE 8080
#CMD ["/usr/lib/jvm/java-8-openjdk-amd64/bin/java", "-jar", "target/IPasas2-jar-with-dependencies.jar"]
CMD ["java", "-jar", "-Duser.timezone=Europe/Vilnius", "target/IPasas2-jar-with-dependencies.jar"]