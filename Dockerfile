FROM debian:jessie AS maker

RUN apt update && apt -yy install \
  git cmake make build-essential gnutls-dev uuid-dev

FROM maker AS builder

ARG VERSION

RUN git clone https://git.tasktools.org/TM/taskd.git /usr/local/src/taskd
RUN cd /usr/local/src/taskd && git submodule update --init --recursive
RUN cd /usr/local/src/taskd && git checkout "${VERSION:-1.2.0}"
RUN cd /usr/local/src/taskd && cmake -DCMAKE_BUILD_TYPE=release .
RUN cd /usr/local/src/taskd && make

FROM maker AS taskd

ENV TASKDDATA=/var/taskd

RUN apt -yy install gnutls-bin net-tools
RUN useradd -m taskd
COPY --from=builder /usr/local/src/taskd /usr/local/src/taskd
RUN cp -r /usr/local/src/taskd/pki /home/taskd/pki
RUN chown -R taskd: /home/taskd
RUN cd /usr/local/src/taskd && make install
RUN chown -R taskd: /usr/local/src/taskd
RUN mkdir $TASKDDATA && chown -R taskd: $TASKDDATA
USER taskd
RUN taskd init --data $TASKDDATA
COPY ./scripts/create_keys_and_certs.bash /usr/local/bin/create_keys_and_certs
COPY ./scripts/entrypoint.bash /usr/local/bin/entrypoint
COPY ./scripts/add_user.bash /usr/local/bin/add_user
COPY ./scripts/add_org.bash /usr/local/bin/add_org
VOLUME $TASKDDATA
VOLUME /home/taskd/pki
ENTRYPOINT ["/usr/local/bin/entrypoint"]
