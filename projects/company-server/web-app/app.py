import os
import socket
from datetime import datetime, timezone

from flask import Flask, jsonify, render_template

app = Flask(__name__)

APP_NAME = os.getenv("APP_NAME", "Company Server")
APP_ENVIRONMENT = os.getenv("APP_ENVIRONMENT", "Development")
APP_VERSION = os.getenv("APP_VERSION", "1.0.0")
DEPLOYMENT_PLATFORM = os.getenv("DEPLOYMENT_PLATFORM", "Local Development")



def get_application_info() -> dict[str, str]:
    """Return runtime information shared by the dashboard and API routes."""
    return {
        "application": APP_NAME,
        "status": "healthy",
        "environment": APP_ENVIRONMENT,
        "version": APP_VERSION,
        "hostname": socket.gethostname(),
        "platform": DEPLOYMENT_PLATFORM,
        "server_time": datetime.now(timezone.utc).strftime(
            "%Y-%m-%d %H:%M:%S UTC"
        ),
    }


@app.get("/")
def index():
    """Render the application status dashboard."""
    return render_template(
        "index.html",
        app_info=get_application_info()
    )


@app.get("/health")
def health():
    """Return a machine-readable health response."""
    return jsonify(
        status="healthy",
        application=APP_NAME,
        version=APP_VERSION,
    ), 200


@app.get("/api/info")
def application_info():
    """Return detailed application and runtime information."""
    return jsonify(get_application_info()), 200


if __name__ == "__main__":
    port = int(os.getenv("PORT", "5000"))
    app.run(host="0.0.0.0", port=port)

echo 'BROKEN_SYNTAX =' >> projects/company-server/web-app/app.py