# Use an official Python runtime as a parent image
FROM python:3.9-slim

ENV INSTANA_SERVICE_NAME=payment

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY *.py ./
COPY payment.ini ./
d
EXPOSE 8080

CMD ["uwsgi", "--ini", "payment.ini"]

# FROM python:3.9

# EXPOSE 8080
# USER root

# ENV INSTANA_SERVICE_NAME=payment

# WORKDIR /app

# COPY requirements.txt /app/

# RUN pip install -r requirements.txt

# COPY *.py /app/
# COPY payment.ini /app/

# #CMD ["python", "payment.py"]
# CMD ["uwsgi", "--ini", "payment.ini"]

