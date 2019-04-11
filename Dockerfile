#FROM sourceryinstitute/docker-base:latest as schur
#RUN  apt-get update && apt-get install flex libreadline6-dev -y
FROM frolvlad/alpine-gcc as schur
RUN apk update && apk add flex readline-dev make ncurses-dev
COPY ./schur /usr/src/schur
WORKDIR /usr/src/schur
RUN  ./configure && make install
ENTRYPOINT ["schur"] 
