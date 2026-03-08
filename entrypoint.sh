#!/bin/bash
set -e

echo "🚀 Starting Django app runner..."
cd "$APP_PATH"

# Optional per-app setup.sh
if [ -f "$APP_PATH/setup.sh" ]; then
    echo "⚙️ Running app setup.sh..."
    bash "$APP_PATH/setup.sh"
fi

# If the app has manage.py, run standard setup
if [ -f "manage.py" ]; then
    echo "📦 Installing requirements (if any)..."
    [ -f requirements.txt ] && pip install -r requirements.txt || echo "No requirements.txt found"

    # Run migrations
    echo "📦 Running migrations..."
    python manage.py migrate --noinput || true

    # Collect static files
    echo "📦 Collecting static files..."
    python manage.py collectstatic --noinput || true
fi

echo "✅ Setup complete, launching..."
if [ $# -gt 0 ]; then
    exec "$@"
else
    RELOAD_FLAG=""
    [ "${GUNICORN_RELOAD}" = "true" ] && RELOAD_FLAG="--reload"
    exec gunicorn --bind 0.0.0.0:8000 $RELOAD_FLAG --error-logfile - --capture-output --log-level info "${WSGI_MODULE}.wsgi:application"
fi
