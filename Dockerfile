FROM golang:1.21.10 as base

WORKDIR /app

COPY go.mod . 
#copying all requirements

RUN go mod download
#running them

COPY . . 
#copying all apllication files

RUN go build -o main .

#-- multistage docker- distroless image
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD [ "./main"]