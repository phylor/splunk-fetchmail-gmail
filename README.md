# Splunk with a Gmail Fetcher

This repository contains a Dockerfile creating a Splunk container which regularly fetches e-mails from a directory on Gmail's IMAP. The Gmail login can be configured with environment variables. Note that you might need to create a Gmail app password.

## Usage

    docker run --rm -it -e FETCHMAIL_USER="user@gmail.com" -e FETCHMAIL_PASSWORD="my_gmail_password" -e FETCHMAIL_LABEL="my_gmail_folder" -p 40000:8000 splunk-fetchmail-gmail

## References

https://www.splunk.com/blog/2011/01/07/splunk-sysadmin-email/
