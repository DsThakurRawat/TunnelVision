# Build stage
FROM golang:1.25-alpine AS builder

WORKDIR /app

# Install make and other build tools
RUN apk add --no-cache make git

# Copy go mod and sum files
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build the application
RUN make build

# Final stage
FROM alpine:latest

WORKDIR /app

# Install CA certificates for TLS
RUN apk add --no-cache ca-certificates

# Copy the binary from the build stage
COPY --from=builder /app/bin/tunnelvision /usr/local/bin/tunnelvision

# Create a non-root user
RUN adduser -D -g '' tunnelvision
USER tunnelvision

ENTRYPOINT ["tunnelvision"]
