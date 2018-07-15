FROM ubuntu:12.04

ENV JENKINS_MASTER=""
ENV COMPUTER_NAME=""
ENV WORK_DIR="/var/jenkins"
ENV JENKINS_SECRET=""
ENV DEBIAN_FRONTEND noninteractive

USER root
RUN apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get install -y php5-cli php5-common php5-curl php5-fpm php5-gd php5-imagick php5-mcrypt php5-mysql php5-xsl curl bzip2 wget git unzip software-properties-common python-software-properties \
    && add-apt-repository -y ppa:openjdk-r/ppa \
    && apt-get update \
    && apt-get install -y openjdk-8-jdk

RUN mkdir /opt/composer \
    && wget https://getcomposer.org/installer -O /tmp/composer-installer.php \
    && php /tmp/composer-installer.php --install-dir=/opt/composer \
    && ln -s /opt/composer/composer.phar /usr/local/bin/composer \
    && rm /tmp/composer-installer.php

RUN useradd -m -U -s /bin/bash jenkins \
    && mkdir -p /var/jenkins \
    && chown -R jenkins:jenkins /var/jenkins \
    && chmod -R g+rwxs /var/jenkins

COPY --chown=jenkins run-jenkins.sh /home/jenkins/

RUN chmod +x /home/jenkins/run-jenkins.sh

USER jenkins
VOLUME /var/jenkins

CMD [ "/home/jenkins/run-jenkins.sh" ]

