FROM ubuntu
RUN apt update && apt install -y curl
CMD sh -c "while true; do echo 'Input website:'; read website; echo 'Searching..'; sleep 1; curl http://\$website; done"