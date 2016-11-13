# ffmpeg

 - gallna/ffmpeg
 - gallna/ffmpeg:librtmp

Based on

- https://github.com/jrottenberg/ffmpeg
- https://github.com/cellofellow/ffmpeg
- https://github.com/sameersbn/docker-ffmpeg

## Compilation guide:

https://trac.ffmpeg.org/wiki/CompilationGuide/Centos#libfdk_aac

## Test

```
docker run  --hostname ffmpeg gallna/ffmpeg:librtmp \
    -i http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4 \
    -c copy \
    -listen 1 -f mp4 http://0.0.0.0:80/ElephantsDream
```

```
docker run --hostname ffmpeg gallna/ffmpeg:librtmp -i http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4 \
    -c copy -bsf:v h264_mp4toannexb -movflags empty_moov+frag_keyframe -bsf dump_extra \
    -listen 1 -f mp4 http://0.0.0.0:80/ElephantsDream.mp4
```

```
docker run --hostname ffmpeg gallna/ffmpeg:librtmp -re -i http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4 \
    -listen 1 -f mpegts http://0.0.0.0:80/ElephantsDream
```
