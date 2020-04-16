FROM alpine:latest
MAINTAINER <aipeachpro@outlook.com>

ENV IMAP_HOST=imap.sina.com          \
    MAIL_USER=example@sina.com       \
    MAIL_PWD=mailpasswd              \
    APPLEID_PWD=appleidpwd 

COPY . /root/appleid_unblocker
WORKDIR /root/appleid_unblocker

RUN apk add --upgrade && apk --no-cache add \
                                   chromium \
                      chromium-chromedriver \
                                python3-dev \
                                 py3-pip && \
    ln -s /usr/bin/python3 /usr/bin/python   && \
    ln -s /usr/bin/pip3    /usr/bin/pip      && \
    pip3 install --upgrade pip               && \
    pip3 install -r requirements.txt


CMD sed -i "s|imap.sina.com|${IMAP_HOST}|"                            /root/appleid_unblocker/venv/EmailManager.py && \
    sed -i "s|example@sina.com|${MAIL_USER}|"                         /root/appleid_unblocker/venv/EmailManager.py && \
    sed -i "s|mailpasswd|${MAIL_PWD}|"                                /root/appleid_unblocker/venv/EmailManager.py && \
    sed -i "s|appleidpwd|${APPLEID_PWD}|"                             /root/appleid_unblocker/venv/EmailManager.py && \
    python3 /root/appleid_unblocker/venv/EmailManager.py
