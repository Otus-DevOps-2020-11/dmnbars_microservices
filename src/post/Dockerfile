FROM python:3.6.0-alpine

WORKDIR /app

COPY requirements.txt .

RUN apk --no-cache --update add build-base=0.4-r1 && \
    pip install --no-cache-dir -r requirements.txt && \
    apk del build-base

COPY . .

ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts

ENTRYPOINT ["python3", "post_app.py"]
