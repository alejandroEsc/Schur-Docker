FROM gcc:4.9
COPY ./schur /usr/src/schur
WORKDIR /usr/src/schur
RUN ./configure
RUN make
RUN make install
CMD ["schur"]

