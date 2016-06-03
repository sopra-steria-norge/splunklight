FROM centos:7

RUN yum update -y && yum install -y vim 

RUN mv /etc/localtime /etc/localtime.origin
RUN ln -s /usr/share/zoneinfo/Europe/Oslo /etc/localtime

RUN curl http://download.splunk.com/products/splunk/releases/6.4.1/linux/splunk-6.4.1-debde650d26e-linux-2.6-x86_64.rpm > splunk.rpm
#RUN curl http://download.splunk.com/products/splunk_light/releases/6.3.3/linux/splunklight-6.3.3-f44afce176d0-linux-2.6-x86_64.rpm > splunk.rpm
RUN rpm -i splunk.rpm


EXPOSE 8000
EXPOSE 9997

RUN /opt/splunk/bin/splunk start --accept-license
RUN /opt/splunk/bin/splunk edit user admin -password password -auth admin:changeme
RUN touch /opt/splunk/etc/.ui_login


CMD ["restart", "--nodaemon"]
ENTRYPOINT ["/opt/splunk/bin/splunk"]
