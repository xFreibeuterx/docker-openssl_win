FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tzdata
RUN apt-get install apt-transport-https -y
RUN apt-get install software-properties-common -y
RUN apt-get -y install build-essential checkinstall zlib1g-dev
RUN apt-get -y install mingw-w64
RUN apt-get -y install wget
RUN mkdir -p /home/scripts
RUN mkdir -p /home/Downloads
COPY . /home/scripts/
RUN rm /home/scripts/Dockerfile
RUN chmod -R a+x /home/scripts
WORKDIR /home/scripts/
