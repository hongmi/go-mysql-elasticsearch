FROM golang:bullseye

MAINTAINER go-mysql-org

RUN apt update

RUN apt install -y dirmngr lsb-release

# before 8.0.28 is 5072E1F5
RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 3A79BD29

RUN echo "deb http://repo.mysql.com/apt/debian $(lsb_release -sc) mysql-8.0" | \
    tee /etc/apt/sources.list.d/mysql80.list

RUN apt update

RUN apt install -y tini mysql-client

ADD . /go/src/github.com/go-mysql-org/go-mysql-elasticsearch

RUN apt install -y tini mysql-client

RUN cd /go/src/github.com/go-mysql-org/go-mysql-elasticsearch/ && \
    go build -o bin/go-mysql-elasticsearch ./cmd/go-mysql-elasticsearch && \
    cp -f ./bin/go-mysql-elasticsearch /go/bin/go-mysql-elasticsearch

ENTRYPOINT ["/usr/bin/tini", "go-mysql-elasticsearch"]
