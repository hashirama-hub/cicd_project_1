FROM python:3.9-slim-buster
RUN pip3 install flask
WORKDIR /app
COPY app.py .
EXPOSE 5000
ENTRYPOINT [ "python","app.py" ]