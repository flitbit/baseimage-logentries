NAME = baseimage-logentries
VSN = 0.1.0

.PHONY: all build tag_latest

all: build

build:
	docker build -t $(NAME):$(VSN) --rm image

tag_latest:
	docker tag $(NAME):$(VSN) $(NAME):latest

