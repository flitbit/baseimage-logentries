NAME = flitbit/baseimage-logentries
VSN = 0.1.0

.PHONY: all build tag_latest

all: build

build:
	docker build -t $(NAME):$(VSN) --rm .

tag_latest:
	docker tag $(NAME):$(VSN) $(NAME):latest

