FROM ubuntu:16.04

# Install dependencies
RUN apt-get update --yes && apt-get upgrade --yes
RUN apt-get install git nodejs npm \
libcairo2-dev libjpeg8-dev libpango1.0-dev libgif-dev libpng-dev build-essential g++ \
ffmpeg \
redis-server --yes

RUN ln -s `which nodejs` /usr/bin/node

# Non-privileged user
RUN mkdir audiogram
WORKDIR /home/root/audiogram

# Clone repo
COPY package*.json ./

# Install dependencies
RUN npm install

# install code
COPY . .
RUN npm build

EXPOSE 8888

CMD npm start
