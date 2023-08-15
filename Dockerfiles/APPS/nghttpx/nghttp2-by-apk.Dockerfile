FROM alpine:3.18

RUN adduser -S -D -h /dev/null -s /sbin/nologin nghttpx && \
	apk add --update nghttp2  openssl ca-certificates && \
	rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/nghttpx", "--user=nghttpx"]
