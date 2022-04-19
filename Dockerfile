FROM golang:1.17-stretch as build-stage

WORKDIR /app

COPY . /app

ENV CGO_ENABLED=0

RUN go build -o /app/build/ws-test ./main.go

FROM alpine

COPY --from=build-stage /app/build/ws-test /bin/ws-test

COPY ./index.html index.html

EXPOSE 8080

ENTRYPOINT ["/bin/ws-test"]
