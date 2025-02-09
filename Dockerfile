# Stage 1: Build the Go application
FROM golang:1.16 AS build

WORKDIR /app

# Copy go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the application for Linux architecture
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server .

# Stage 2: Run the application
FROM alpine:latest

WORKDIR /root/

# Install necessary libraries
RUN apk add --no-cache bash ca-certificates

# Copy the built binary and ensure it has executable permissions
COPY --from=build /app/server .
RUN chmod +x ./server

EXPOSE 8080

CMD ["./server"]