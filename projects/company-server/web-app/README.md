# Company Server Web Application

This Flask application powers the Company Server Operations Dashboard.

## Run Locally

Create and activate a virtual environment:

```bash
python3 -m venv .venv
source .venv/bin/activate
```


Install dependencies:

```bash
pip install -r requirements.txt
```


Run the Flask development server:

```bash
python app.py
```


Open:

```text
http://localhost:5000
```


## Run with Docker Compose

```bash
docker compose up --build -d
```


Open:

```text
http://localhost:8080
```


Stop the application:

```bash
docker compose down
```


## Endpoints

| Endpoint    | Purpose                                     |
|-------------|---------------------------------------------|
| `/`         | Operations dashboard                        |
| `/health`   | Lightweight application health check        |
| `/api/info` | Detailed runtime and deployment information |


## Technology

- Python
- Flask
- Gunicorn
- Docker
- Docker Compose