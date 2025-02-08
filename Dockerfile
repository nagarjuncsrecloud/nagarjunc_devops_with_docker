# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Install curl
RUN apt update && apt install -y curl

# Copy the script into the container
COPY script.sh /script.sh

# Give execution permissions to the script
RUN chmod +x /script.sh

# Set the script to run when the container starts
CMD ["bash", "/script.sh"]

#Alternatively, you can also use the below CMD line by uncommenting it and comment the CMD above. However, the exercise requirements mentioned usage of COPY and RUN chmod in Dockerfile

#CMD sh -c "while true; do echo 'Input website:'; read website; echo 'Searching..'; sleep 1; curl http://$website; done"