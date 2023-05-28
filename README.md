# gunicorn_django

Certainly! Here's an example of a `README.md` file you can include in your GitHub repository to describe your Django development container:

```markdown
# Django Development Container with Gunicorn

This repository provides a Docker configuration for setting up a Django development environment with Gunicorn as the web server. It allows you to easily containerize your Django project and run it in a self-contained environment.

## Features

- Uses the base Python Docker image for simplicity and flexibility.
- Configures Gunicorn as the WSGI HTTP server for serving your Django application.
- Supports PostgreSQL compatibility with `psycopg2-binary` package.
- Enables easy development and deployment of Django applications.


## Getting Started

docker run
  -d
  --name='djangosite'
  -e 'TCP_PORT_8000'='8000'
  -e 'POSTGRES_DB'='<djangosite>'
  -e 'POSTGRES_USER'='<djangosite>'
  -e 'POSTGRES_PASSWORD'='<djangosite>'
  -e 'POSTGRES_HOST'='<posgres_host>'
  -e 'WSGI_MODULE'='mysite'
  -v '/path/to/mysite/':'/mnt/app':'rw' 'ghcr.io/damianolombardo/gunicorn_django:main' 


## Customization

- **Project Configuration**: Modify the environment variable `WSGI_MODULE` with the name of your Django project.

- **Database Configuration**: Modify the environment variables (`POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`, `POSTGRES_HOST`) to match your PostgreSQL database settings.

## Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
```
