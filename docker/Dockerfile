FROM ubuntu

### build hadoop 
# jdk
ADD resource/openlogic-openjdk-8u392-b08-linux-x64.tar.gz /usr/local
RUN mv /usr/local/openlogic-openjdk-8u392-b08-linux-x64 /usr/local/jdk
ENV JAVA_HOME /usr/local/jdk
ENV PATH $JAVA_HOME/bin:$PATH

# hadoop
ADD resource/hadoop-3.3.6.tar.gz  /usr/local
RUN mv /usr/local/hadoop-3.3.6 /usr/local/hadoop
ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $HADOOP_HOME/bin:$PATH
ENV PATH $HADOOP_HOME/sbin:$PATH
RUN mkdir /hadoop/data -p
###

### basic config
# set root 
RUN echo "root:123456" | chpasswd
RUN echo "root   ALL=(ALL)       ALL" >> /etc/sudoers

# apt install
RUN apt update \
    && apt install -y python3 \
    && apt install -y python3-pip \
    && apt install -y openssh-client \ 
    && apt install -y openssh-server \ 
    && apt install -y sshpass \
    && apt install -y net-tools \
    && apt install -y inetutils-ping \
    && apt install -y make

# generate key
RUN ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa

# config ssh
RUN touch ~/.ssh/authorized_keys \ 
    && chmod 700 ~/.ssh \ 
    && chmod 600 ~/.ssh/authorized_keys \
    && chmod 600 ~/.ssh/id_rsa
    
COPY config_file/ssh_config /etc/ssh/ssh_config
COPY config_file/sshd_config /etc/ssh/sshd_config

# ssh auto start
RUN echo '/etc/init.d/ssh start' >> ~/.bashrc
RUN /etc/init.d/ssh start

# close firewall
###

### hadoop config
COPY config_file/hadoop-env.sh /usr/local/hadoop/etc/hadoop/
COPY config_file/*-site.xml /usr/local/hadoop/etc/hadoop/
###