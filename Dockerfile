# syntax=docker/dockerfile:1
FROM golang:1.14-alpine AS build
ADD . /myapp
WORKDIR /myapp
RUN go build /myapp/app.go
ENTRYPOINT ["/myapp/app"]

