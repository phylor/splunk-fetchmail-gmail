cat <<EOF > /etc/fetchmailrc
set no syslog
set logfile /var/log/fetchmail.log
set no bouncemail
set invisible

set postmaster "fetchmail"

poll imap.gmail.com with proto IMAP
  user '$FETCHMAIL_USER' there with password '$FETCHMAIL_PASSWORD' is splunk here with options ssl
  folder '$FETCHMAIL_LABEL'
  keep
  mda "/usr/bin/procmail -m /etc/procmail.conf"
EOF

cat <<EOF > /etc/procmail.conf
LOGFILE=/var/log/procmail
VERBOSE=on

:0
* Subject: .*
/home/splunk/Mail
EOF

chmod 0600 /etc/fetchmailrc
chown splunk:splunk /etc/fetchmailrc

# Start fetchmail daemon
su splunk -c 'fetchmail -d 300 -f /etc/fetchmailrc'

# Start splunk
/sbin/entrypoint.sh start-service