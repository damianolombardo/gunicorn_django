FROM python:latest

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file to the container
COPY requirements.txt .

# Install the project dependencies
RUN pip install -r requirements.txt

# Install PostgreSQL client libraries
RUN apt-get update && apt-get install -y libpq-dev

# Copy the project code to the container
COPY . .

# Expose the port that Gunicorn will use
EXPOSE 8000

# Set environment variables for PostgreSQL connection
ENV POSTGRES_DB postgresdb
ENV POSTGRES_USER postgresuser
ENV POSTGRES_PASSWORD postgrespassword
ENV POSTGRES_HOST postgreshost

# Set the command to run Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--chdir", "/mnt/app", "mysite.wsgi:application"]

