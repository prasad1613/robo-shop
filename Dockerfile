FROM python:3.9-slim

# Install system dependencies
RUN apt-get update && apt-get install -y build-essential python3-dev

# Upgrade pip
RUN pip install --upgrade pip

# Set environment variables
ENV INSTANA_SERVICE_NAME=payment

# Set working directory
WORKDIR /app

# Copy requirements file and install dependencies
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Copy application files
COPY *.py /app/
COPY payment.ini /app/

# Expose the port the app runs on
EXPOSE 8080

# Set the command to run the application
CMD ["uwsgi", "--ini", "payment.ini"]

