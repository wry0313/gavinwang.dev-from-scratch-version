# Build stage: Installing Node.js, TailwindCSS, and building the Go application
FROM golang:1.20-alpine AS builder

# Installing Node.js and npm
RUN apk add --update nodejs npm

# Set the working directory inside the container
WORKDIR /app

# Copy the entire project directory
COPY . .

# Install TailwindCSS and generate the CSS
RUN npm install -D tailwindcss
RUN npx tailwindcss -i ./static/css/input.css -o ./static/css/output.css --minify

# Compile the Go app
RUN go build -o server .

# Final stage: Create the final image with the Go binary and necessary assets
FROM alpine:latest

# Set the working directory
WORKDIR /root/

# Copy the Go binary and static assets from the builder stage
COPY --from=builder /app/server .
COPY --from=builder /app/static ./static

# Command to run the Go binary
CMD ["./server"]