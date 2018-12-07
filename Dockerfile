#
# youtube-dl Server Dockerfile
#
# https://github.com/ycrack/youtube-dl-server
#

FROM python:slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y libav-tools tzdata wget bzip2 --no-install-recommends && \
  apt-get clean && \
  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /usr/src/app

RUN chmod a+x ./youtube-dl-server.py
RUN wget 'https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2' && \
  tar jxf phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
  rm phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
  ln -s -r /usr/src/app/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs

EXPOSE 8080

VOLUME ["/youtube-dl"]

CMD [ "python", "-u", "./youtube-dl-server.py" ]
