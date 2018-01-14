FROM debian:jessie AS maker

RUN apt update && apt -yy install \
  git cmake make build-essential gnutls-dev uuid-dev

FROM maker AS builder

ARG VERSION

RUN git clone https://git.tasktools.org/TM/taskd.git /usr/local/src/taskd
RUN cd /usr/local/src/taskd && git checkout "${VERSION:-s1.2.0}"
RUN cd /usr/local/src/taskd && cmake -DCMAKE_BUILD_TYPE=release .
RUN cd /usr/local/src/taskd && make

FROM maker AS taskd

COPY --from=builder /usr/local/src/taskd /usr/local/src/taskd
RUN cd /usr/local/src/taskd && make install
