# Django Development Container with Gunicorn

A Docker container for running Django applications with Gunicorn. Mount your Django project, set a few environment variables, and it handles the rest — dependency installation, migrations, static files, and serving.

## Features

- Python base image with Gunicorn pre-installed
- Automatically installs your app's `requirements.txt` on startup
- Runs `migrate` and `collectstatic` automatically if `manage.py` is present
- Supports an optional `setup.sh` hook for custom pre-startup logic
- PostgreSQL-ready with `psycopg2-binary` included
- Logs to stdout/stderr for easy container log access

## Quick Start

```bash
docker run -d \
  --name djangosite \
  -p 8000:8000 \
  -e WSGI_MODULE=mysite \
  -e POSTGRES_DB=mydb \
  -e POSTGRES_USER=myuser \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_HOST=db \
  -v /path/to/mysite:/mnt/app:rw \
  ghcr.io/damianolombardo/gunicorn_django:main
```

## Environment Variables

| Variable | Default | Description |
|---|---|---|
| `WSGI_MODULE` | `mysite` | Django project name (used as `<module>.wsgi:application`) |
| `APP_PATH` | `/mnt/app` | Path inside the container where your app is mounted |
| `POSTGRES_DB` | — | PostgreSQL database name |
| `POSTGRES_USER` | — | PostgreSQL username |
| `POSTGRES_PASSWORD` | — | PostgreSQL password |
| `POSTGRES_HOST` | — | PostgreSQL host |
| `GUNICORN_RELOAD` | — | Set to `true` to enable Gunicorn auto-reload on code changes (recommended for development) |

## Startup Behavior

On each container start, the entrypoint:

1. Runs `$APP_PATH/setup.sh` if it exists (useful for custom pre-startup steps)
2. Installs `requirements.txt` from your app if present
3. Runs `python manage.py migrate --noinput`
4. Runs `python manage.py collectstatic --noinput`
5. Starts Gunicorn on `0.0.0.0:8000`

## Custom Commands

You can override the default Gunicorn startup by passing a command:

```bash
docker run ... ghcr.io/damianolombardo/gunicorn_django:main python manage.py shell
```

## Contributing

Contributions are welcome! Open an issue or submit a pull request for bug reports or improvements.

## License

This project is licensed under the [MIT License](LICENSE).
