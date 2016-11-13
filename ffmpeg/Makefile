.PHONY: build push
.DEFAULT_GOAL := build

build:
	@docker build -t gallna/ffmpeg .
	@docker tag gallna/ffmpeg gallna/ffmpeg:librtmp

push:
	@docker push gallna/ffmpeg
	@docker push gallna/ffmpeg:librtmp

release:
	build
	push
