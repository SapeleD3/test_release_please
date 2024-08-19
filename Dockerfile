FROM python:3.12-alpine3.19


# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
# ENV NEW_RELIC_CONFIG_FILE=newrelic.ini
# ENV NEW_RELIC_ENVIRONMENT=development



RUN apk add --no-cache bzip2-dev \
        coreutils \
        gcc \
        libc-dev \
        libffi-dev \
        libressl-dev \
        linux-headers



# Set the working directory
WORKDIR /app
COPY . /app/

# installing dependencies
RUN --mount=type=cache,target=/root/.cache \pip3 install -r requirements.txt

# running databse migrations
RUN python manage.py makemigrations && python manage.py migrate --noinput

EXPOSE 8000

# CMD ["newrelic-admin", "run-program", "python", "manage.py", "runserver", "0.0.0.0:8000"]
CMD ["newrelic-admin", "run-program", "gunicorn", "voltro_pay.wsgi:application", "--bind", "0.0.0.0:8000"]


