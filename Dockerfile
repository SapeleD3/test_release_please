FROM python:3.12

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory
WORKDIR /app
COPY . /app/

# installing dependencies
RUN --mount=type=cache,target=/root/.cache \pip3 install -r requirements.txt

# running databse migrations
RUN python manage.py makemigrations && python manage.py migrate --noinput

EXPOSE 8000

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]