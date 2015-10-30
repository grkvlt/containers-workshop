FROM gliderlabs/alpine:3.1

RUN apk-install python
ADD ./app /app
WORKDIR /app

CMD python -m SimpleHTTPServer 8080
EXPOSE 8080
