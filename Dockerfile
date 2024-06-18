# Use an official Node.js runtime based on Alpine Linux
FROM node:14-alpine

# Set environment variable for Instana auto profiling
ENV INSTANA_AUTO_PROFILE true

# Expose port 8080
EXPOSE 8080

# Set working directory in the container
WORKDIR /opt/server

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the application code
COPY server.js ./

# Command to run the application
CMD ["node", "server.js"]

# FROM node:14

# ENV INSTANA_AUTO_PROFILE true

# EXPOSE 8080

# WORKDIR /opt/server

# COPY package.json /opt/server/

# RUN npm install

# COPY server.js /opt/server/

# CMD ["node", "server.js"]

