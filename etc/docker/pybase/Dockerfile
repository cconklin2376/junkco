# start with the base image
FROM ubuntu
# optional maintainer
MAINTAINER Chris Conklin "cconklin2376@gmail.com"

# patch the system
RUN apt-get -y update

# install pip
RUN apt-get -y install python-pip gcc python-dev

# install uwisgi python app server
RUN pip install uwsgi

# copy package dependencies
ADD requirements.txt /tmp/requirements.txt

# install python dependencies
RUN pip install -r /tmp/requirements.txt

# clean up the dependency file
RUN rm /tmp/requirements.txt
