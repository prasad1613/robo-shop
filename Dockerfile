FROM node:14-alpine
ENV INSTANA_AUTO_PROFILE=true
WORKDIR /opt/server
COPY package.json ./
RUN npm install --production
COPY server.js ./
EXPOSE 8080
CMD ["node", "server.js"]

# FROM node:14

# ENV INSTANA_AUTO_PROFILE true

# EXPOSE 8080

# WORKDIR /opt/server

# COPY package.json /opt/server/

# RUN npm install

# COPY server.js /opt/server/

# CMD ["node", "server.js"]


