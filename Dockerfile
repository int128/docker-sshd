FROM alpine:3.9
RUN apk update && apk add openssh sudo
EXPOSE 22
ENV SSH_USERNAME tester
ENV SSH_PASSWORD hello
COPY init.sh /init.sh
CMD ["/init.sh"]
