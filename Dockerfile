# Use the Alpine variant of the official golang image as the builder stage
FROM golang:1.20-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the source from the current directory to the working Directory inside the container
COPY . .

# Compile the app
RUN go build -o server .

# Use the lightweight Alpine image for the final stage
FROM alpine:latest

# Set the working directory
WORKDIR /root/

# Copy the compiled Go binary from the builder stage to the current stage
COPY --from=builder /app/server .

# Copy static assets
COPY ./static /root/static

# Command to run the Go binary
CMD ["./server"]

