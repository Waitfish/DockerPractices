FROM alpine:3.18

# libxml2 and libjansson are not enabled as they're not needed for building nghttpd & nghttpx
COPY nghttp2-1.55.1.tar.gz ./
RUN apk add --no-cache openssl libgcc libstdc++ jemalloc libev c-ares zlib \
	&& apk add --no-cache --virtual .build-deps openssl-dev gcc g++ git jemalloc-dev libev-dev autoconf automake make libtool c-ares-dev zlib-dev \
	&& tar xvf nghttp2-1.55.1.tar.gz \
	&& cd  nghttp2-1.55.1/ \
	&& ./configure \
	&& make && make install-strip \
	&& cd .. && rm -rf nghttp2-1.55.1 && rm -rf nghttpx2-1.55.1.tar.gz\
	&& apk del .build-deps