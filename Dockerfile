FROM ubuntu:12.04

ENV JENKINS_MASTER=""
ENV COMPUTER_NAME=""
ENV WORK_DIR="/var/jenkins"
ENV JENKINS_SECRET=""
ENV DEBIAN_FRONTEND noninteractive

USER root
RUN apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get install -y php5-cli php5-common php5-curl php5-fpm php5-gd php5-imagick php5-mcrypt php5-mysql curl bzip2 wget git

RUN cd /tmp \
    && wget https://download.java.net/java/GA/jdk10/10.0.1/fb4372174a714e6b8c52526dc134031e/10/openjdk-10.0.1_linux-x64_bin.tar.gz \
    && mkdir /opt/openjdk \
    && tar -xf /tmp/openjdk-10.0.1_linux-x64_bin.tar.gz -C /opt/openjdk \
    && ln -s /opt/openjdk/jdk-10.0.1 /opt/openjdk/jdk-10 \
    && useradd -m -U -s /bin/bash jenkins \
    && echo -n "export JAVA_HOME=/opt/openjdk/jdk-10\nexport PATH=\"\$JAVA_HOME/bin:\$PATH\"" > /etc/profile.d/openjdk.sh \
    && chmod +x /etc/profile.d/openjdk.sh \
    && rm /tmp/openjdk-10.0.1_linux-x64_bin.tar.gz

RUN mkdir /opt/composer \
    && wget https://getcomposer.org/installer -O /tmp/composer-installer.php \
    && php /tmp/composer-installer.php --install-dir=/opt/composer \
    && ln -s /opt/composer/composer.phar /usr/local/bin/composer \
    && rm /tmp/composer-installer.php

RUN mkdir -p /var/jenkins \
    && chown -R jenkins:jenkins /var/jenkins \
    && chmod -R g+rwxs /var/jenkins

COPY --chown=jenkins run-jenkins.sh /home/jenkins/

RUN chmod +x /home/jenkins/run-jenkins.sh

USER jenkins
VOLUME /var/jenkins

CMD [ "/home/jenkins/run-jenkins.sh" ]

