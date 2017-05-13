if [ -z "$FETCHMAIL_FORCE_GRAB" ]; then
  su splunk -c 'fetchmail -d 300 -f /etc/fetchmailrc'
else
  su splunk -c 'fetchmail -f /etc/fetchmailrc-force-grab' &
  FETCHMAIL_PID=$!
  wait $FETCHMAIL_PID
  su splunk -c 'fetchmail -d 300 -f /etc/fetchmailrc'
fi
