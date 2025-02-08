# Use the existing image as the base
FROM devopsdockeruh/simple-web-service:alpine

# Use CMD to specify the default argument to start the server
CMD ["server"]