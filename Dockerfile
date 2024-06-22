# Use an official Python runtime as a parent image
FROM python:3.9-slim
EXPOSE 8080
USER root
ENV INSTANA_SERVICE_NAME=payment
WORKDIR /app
COPY requirements.txt /app/
RUN pip install -r requirements.txt
COPY *.py /app/
COPY payment.ini /app/
CMD ["python", "payment.py"]
CMD ["uwsgi", "--ini", "payment.ini"]

