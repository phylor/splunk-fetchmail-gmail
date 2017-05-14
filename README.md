# Splunk with a Gmail Fetcher

This repository contains a Dockerfile creating a Splunk container which regularly fetches e-mails from a directory on Gmail's IMAP. The Gmail login can be configured with environment variables. Note that you might need to create a Gmail app password.

## Usage

Mails are fetched every 5 minutes, are kept on the server but marked as read. Only unread messages are downloaded.

Use `-e FETCHMAIL_FORCE_GRAB=y` as an additional option to make the container first fetch all read emails before starting the daemon which regularly downloads unread emails. This is useful if you want to analyse historic email data in Splunk.

    docker run --rm -it \
        -e "FETCHMAIL_USER=user@gmail.com" \
        -e "FETCHMAIL_PASSWORD=my_gmail_password" \
        -e "FETCHMAIL_LABEL=my_gmail_folder" \
        -p 40000:8000 \
        phylor/splunk-fetchmail-gmail

## Systemd Example Unit

    [Unit]
    Description=Splunk Email Notification Service
    After=docker.service
    Requires=docker.service

    [Service]
    ExecStartPre=-/usr/bin/docker kill splunk-gmail
    ExecStartPre=-/usr/bin/docker rm splunk-gmail
    ExecStartPre=-/usr/bin/docker pull splunk-fetchmail-gmail
    ExecStart=/usr/bin/docker run -t --name splunk-gmail \
        -e "FETCHMAIL_USER=user@gmail.com" \
        -e "FETCHMAIL_PASSWORD=my_gmail_password" \
        -e "FETCHMAIL_LABEL=my_gmail_folder" \
        -v /opt/splunk/etc:/opt/splunk/etc \
        -v /opt/splunk/var:/opt/splunk/var \
        -v /opt/splunk/mail:/home/splunk/Mail \
        -p 40000:8000 \
        phylor/splunk-fetchmail-gmail
    ExecStop=/usr/bin/docker stop splunk-gmail
    
    [Install]
    WantedBy=multi-user.target

## References

- https://www.splunk.com/blog/2011/01/07/splunk-sysadmin-email/
- https://hub.docker.com/r/splunk/splunk/
