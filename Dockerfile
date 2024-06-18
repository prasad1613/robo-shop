# Use a smaller base image
FROM node:14-alpine

# Set environment variables
ENV INSTANA_AUTO_PROFILE=true

# Set the working directory
WORKDIR /opt/server

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install --production

# Copy the rest of the application code
COPY server.js ./

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["node", "server.js"]

# FROM node:14

# ENV INSTANA_AUTO_PROFILE true

# EXPOSE 8080

# WORKDIR /opt/server

# COPY package.json /opt/server/

# RUN npm install

# COPY server.js /opt/server/

# CMD ["node", "server.js"]


