FROM resin/rpi-raspbian
MAINTAINER Gavin Adam <gavinadam80@gmail.com>

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libssl-dev \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    software-properties-common \
    --no-install-recommends

RUN apt-get update && apt-get install -y \
    oracle-java8-jdk \
    --no-install-recommends

RUN apt-get update && apt-get install -y \
    python \
    python-dev \
    python-pip \
    libjpeg-dev \
    --no-install-recommends && \
    pip install --upgrade pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /root
RUN git clone https://github.com/ajinabraham/Mobile-Security-Framework-MobSF.git

WORKDIR /root/Mobile-Security-Framework-MobSF

RUN pip install -r requirements.txt && \
pip install html5lib==1.0b8

WORKDIR /root/Mobile-Security-Framework-MobSF/MobSF
RUN sed -i 's/USE_HOME = False/USE_HOME = True/g' settings.py

EXPOSE 8888

WORKDIR /root/Mobile-Security-Framework-MobSF
CMD ["python","manage.py","runserver","0.0.0.0:8888"]
