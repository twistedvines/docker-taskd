.PHONY: build tag push

VERSION=$(shell cat .version)

build:
	docker build --build-arg VERSION=$(VERSION) -t "taskd:latest" .

tag:
	docker tag 'taskd:latest' "task:$(VERSION)"
	docker tag 'taskd:latest' "twistedvines/taskd:$(VERSION)"

push:
	docker push "twistedvines/taskd:$(VERSION)"
