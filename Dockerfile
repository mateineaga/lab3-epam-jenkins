FROM node:7.8.0
WORKDIR /opt
COPY . /opt

RUN npm config set timeout 100000

RUN npm install
ENTRYPOINT ["npm", "run", "start"]