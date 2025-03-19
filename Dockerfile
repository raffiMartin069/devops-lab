FROM python:3.12-slim AS build

WORKDIR /app

COPY . .

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install ssh -y && \
    apt-get install -y python3-pip python3-dev && \
    pip3 install --upgrade pip && \
    python -m pip install django && \
    python -m pip install gunicorn


RUN python manage.py collectstatic --noinput

EXPOSE 8000

EXPOSE 22

CMD ["gunicorn", "mysite.wsgi:application", "--bind", "0.0.0.0:8000"]