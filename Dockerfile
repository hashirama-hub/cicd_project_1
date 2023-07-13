# FROM python:3.9-slim-buster
# RUN pip3 install flask
# WORKDIR /app
# COPY app.py .
# EXPOSE 5000
# ENTRYPOINT [ "python","app.py" ]

FROM python:3.9-slim-buster
WORKDIR /app 
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . .
ENV FLASK_RUN_HOST=0.0.0.0
EXPOSE 5000
CMD [ "flask", "run" ]