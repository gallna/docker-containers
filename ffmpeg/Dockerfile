FROM  ubuntu:16.04

ENV FFMPEG_VERSION=3.1.2 \
    FAAC_VERSION=1.28 \
    FDKAAC_VERSION=0.1.4 \
    LAME_VERSION=3.99.5 \
    OGG_VERSION=1.3.2 \
    OPUS_VERSION=1.1.1 \
    THEORA_VERSION=1.1.1 \
    YASM_VERSION=1.3.0 \
    VORBIS_VERSION=1.3.5 \
    VPX_VERSION=1.5.0 \
    XVID_VERSION=1.3.4 \
    SRC=/usr/local \
    DIR=/usr/local/src \
    MAKEFLAGS="-j$[$(nproc) + 1]" \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

ENTRYPOINT ["ffmpeg"]
CMD ["--help"]

RUN apt-get -yqq update && \
    apt-get install -yq --no-install-recommends \
    autoconf \
    automake \
    bzip2 \
    ca-certificates \
    cmake \
    curl \
    g++ \
    gcc \
    git \
    mercurial \
    libssl-dev \
    libtool \
    make \
    nasm \
    perl \
    pkg-config \
    python \
    tar \
    xmlto \
    zlib1g-dev

WORKDIR $DIR

# yasm
RUN curl -sL https://github.com/yasm/yasm/archive/v${YASM_VERSION}.tar.gz | tar zxf - -C . && \
    cd yasm-${YASM_VERSION} && \
    ./autogen.sh && \
    ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --docdir=${DIR} -mandir=${DIR}&& \
    make && \
    make install && \
    rm -rf ${DIR}

# x264
RUN git clone -b stable  --single-branch --depth 1 git://git.videolan.org/x264 && \
    cd x264 && \
    ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --enable-static && \
    make && \
    make install && \
    make distclean && \
    rm -rf ${DIR}

# x265
RUN hg clone https://bitbucket.org/multicoreware/x265 && \
    cd x265 && \
    cmake -DENABLE_SHARED:bool=off -G "Unix Makefiles" source && \
    make && \
    make install && \
    rm -rf ${DIR}

# libogg
RUN curl -s http://downloads.xiph.org/releases/ogg/libogg-${OGG_VERSION}.tar.gz | tar zxf - -C . && \
    cd libogg-${OGG_VERSION} && \
    ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --disable-shared --datadir=${DIR} && \
    make && \
    make install && \
    make distclean && \
    rm -rf ${DIR}

# libopus
RUN curl -s http://downloads.xiph.org/releases/opus/opus-${OPUS_VERSION}.tar.gz | tar zxf - -C . && \
    cd opus-${OPUS_VERSION} && \
    autoreconf -fiv && \
    ./configure --prefix="${SRC}" --disable-shared --datadir="${DIR}" && \
    make && \
    make install && \
    make distclean && \
    rm -rf ${DIR}

# libvorbis
RUN curl -s http://downloads.xiph.org/releases/vorbis/libvorbis-${VORBIS_VERSION}.tar.gz | tar zxf - -C . && \
    cd libvorbis-${VORBIS_VERSION} && \
    ./configure --prefix="${SRC}" --with-ogg="${SRC}" --bindir="${SRC}/bin" --disable-shared --datadir="${DIR}" && \
    make && \
    make install && \
    make distclean && \
    rm -rf ${DIR}

# libtheora
RUN curl -s http://downloads.xiph.org/releases/theora/libtheora-${THEORA_VERSION}.tar.bz2 | tar jxvf - -C . && \
    cd libtheora-${THEORA_VERSION} && \
    ./configure --prefix="${SRC}" --with-ogg="${SRC}" --bindir="${SRC}/bin" --disable-shared --datadir="${DIR}" && \
    make && \
    make install && \
    make distclean && \
    rm -rf ${DIR}

# libvpx
RUN curl -s https://codeload.github.com/webmproject/libvpx/tar.gz/v${VPX_VERSION} | tar zxf - -C . && \
    cd libvpx-${VPX_VERSION} && \
    ./configure --prefix="${SRC}" --enable-vp8 --enable-vp9 --disable-examples --disable-docs && \
    make && \
    make install && \
    make clean && \
    rm -rf ${DIR}

# libmp3lame
RUN curl -Ls https://downloads.sf.net/project/lame/lame/${LAME_VERSION%.*}/lame-${LAME_VERSION}.tar.gz | tar zxf - -C . && \
    cd lame-${LAME_VERSION} && \
    ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --disable-shared --enable-nasm --datadir="${DIR}" && \
    make && \
    make install && \
    make distclean && \
    rm -rf ${DIR}

# xvid
RUN curl -L -s  http://downloads.xvid.org/downloads/xvidcore-${XVID_VERSION}.tar.gz | tar zxf - -C . && \
    cd xvidcore/build/generic && \
    ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --datadir="${DIR}" && \
    make && \
    make install && \
    rm -rf ${DIR}

# fdk-aac
RUN git clone --depth 1 git://git.code.sf.net/p/opencore-amr/fdk-aac && \
    cd fdk-aac && \
    autoreconf -fiv && \
    ./configure --prefix="${SRC}" --disable-shared && \
    make && \
    make install && \
    make distclean && \
    rm -rf ${DIR}

# librtmp
RUN git clone git://repo.or.cz/rtmpdump.git && \
    cd rtmpdump \
    make && \
    make install && \
    rm -rf ${DIR}

# ffmpeg
RUN curl -s http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar zxf - -C . && \
    cd ffmpeg-${FFMPEG_VERSION} && \
    ./configure \
    --prefix="${SRC}" \
    --extra-cflags="-I${SRC}/include" \
    --extra-ldflags="-L${SRC}/lib" \
    --bindir="${SRC}/bin" \
    --pkg-config-flags="--static" \
    --disable-doc \
    --extra-libs=-ldl \
    --enable-version3 \
    --enable-libfdk-aac \
    --enable-libmp3lame \
    --enable-libopus \
    --enable-libtheora \
    --enable-libvorbis \
    --enable-libvpx \
    --enable-libx264 \
    --enable-libx265 \
    --enable-libxvid \
    --enable-librtmp \
    --enable-gpl \
    --enable-avresample \
    --enable-postproc \
    --enable-nonfree \
    --disable-debug \
    --enable-small \
    --enable-openssl && \
    make && \
    make install && \
    make distclean && \
    hash -r && \
    cd tools && \
    make qt-faststart && \
    cp qt-faststart ${SRC}/bin && \
    rm -rf ${DIR}

# cleanup
RUN apt-get purge -yqq \
    autoconf \
    automake \
    bzip2 \
    cmake \
    g++ \
    gcc \
    git \
    mercurial \
    libtool \
    libssl-dev \
    make \
    nasm \
    perl \
    pkg-config \
    python \
    xmlto \
    zlib1g-dev && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists && \
    ffmpeg -buildconf
