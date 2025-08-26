FROM python

WORKDIR /runner

# Install system dependencies (only what's needed for Postgres optional use)
RUN apt-get update && apt-get install -y \
    libpq-dev gcc netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

# Install Gunicorn + psycopg2 (binary so optional)
RUN pip install --no-cache-dir gunicorn psycopg2-binary

# Default envs (override at runtime)
ENV APP_PATH=/mnt/app \
    WSGI_MODULE=mysite

COPY entrypoint.sh /runner/entrypoint.sh
RUN chmod +x /runner/entrypoint.sh

EXPOSE 8000
CMD ["/runner/entrypoint.sh"]
