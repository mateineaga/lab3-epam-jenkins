FROM node:19-bullseye

WORKDIR /opt

COPY . /opt

RUN npm install

ENTRYPOINT ["npm", "run", "start"]