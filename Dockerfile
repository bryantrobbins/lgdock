FROM dockerfile/nginx
MAINTAINER Bryan Robbins <bryantrobbins@gmail.com>

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-2.1-bin.zip
RUN unzip gradle-2.1-bin.zip
RUN mv gradle-2.1 gradle
ENV PATH $PATH:/gradle/bin

EXPOSE 80
