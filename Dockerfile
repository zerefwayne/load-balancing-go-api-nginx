# Base image for building the go project
FROM golang:1.14-alpine AS build

# Updates the repository and installs git
RUN apk update && apk upgrade && \
    apk add --no-cache git

# Switches to /tmp/app as the working directory, similar to 'cd'
WORKDIR /tmp/app

COPY . .

# Builds the current project to a binary file called api
# The location of the binary file is /tmp/app/out/api
RUN GOOS=linux go build -o ./out/api .

#########################################################

# The project has been successfully built and we will use a
# lightweight alpine image to run the server 
FROM alpine:latest

# Adds CA Certificates to the image
RUN apk add ca-certificates

# Copies the binary file from the BUILD container to /app folder
COPY --from=build /tmp/app/out/api /app/api

# Switches working directory to /app
WORKDIR "/app"

# Exposes the 5000 port from the container
EXPOSE 5000

# Runs the binary once the container starts
CMD ["./api"]