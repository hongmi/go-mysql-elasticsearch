all: build

build: build-elasticsearch

build-elasticsearch:
	GO111MODULE=on go build -o bin/go-mysql-elasticsearch ./cmd/go-mysql-elasticsearch

test:
	GO111MODULE=on go test -timeout 1m --race ./...

clean:
	GO111MODULE=on go clean -i ./...
	@rm -rf bin


IMAGE_NAME=hongmin/go-mysql-elasticsearch
IMAGE_TAG=0.0.9

image:
	docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
	docker push ${IMAGE_NAME}:${IMAGE_TAG}

