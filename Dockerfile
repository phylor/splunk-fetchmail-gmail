FROM splunk/splunk

ENV SPLUNK_START_ARGS "--accept-license"

RUN apt update && apt install -y fetchmail procmail

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
RUN mkdir -p /home/splunk/Mail && chown splunk:splunk /home/splunk/Mail
RUN touch /var/log/fetchmail.log && chown splunk:splunk /var/log/fetchmail.log

COPY inputs.conf /opt/splunk/etc/system/local/
COPY props.conf /opt/splunk/etc/system/local/
COPY transforms.conf /opt/splunk/etc/system/local/

CMD /entrypoint.sh
