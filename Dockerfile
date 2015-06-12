# Version: 0.0.1
FROM ubuntu

MAINTAINER Xing Fu "bio.xfu@gmail.com"

RUN perl -p -i.orig -e 's/archive.ubuntu.com/mirrors.aliyun.com\/ubuntu/' /etc/apt/sources.list; \
    echo 'deb http://mirrors.ustc.edu.cn/CRAN/bin/linux/ubuntu trusty/' >> /etc/apt/sources.list; \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9; \
    apt-get update; \
    apt-get install -y build-essential git python python-dev python-setuptools nginx uwsgi uwsgi-plugin-python supervisor r-base; \
    apt-get clean; \
    apt-get autoremove; \
    easy_install pip

RUN echo "daemon off;" >> /etc/nginx/nginx.conf; \
    mkdir -p /var/log/uwsgi

ADD supervisor.conf /etc/supervisor/conf.d/

ADD nginx.conf /etc/nginx/conf.d/

ADD requirements.txt /src/

RUN pip install -r /src/requirements.txt

ADD install_R_packages.R /src/

RUN Rscript /src/install_R_packages.R

EXPOSE 5000

#ADD . /var/www/

#WORKDIR /var/www/

CMD ["supervisord", "-n"]

