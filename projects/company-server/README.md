# Company Server

## Overview

Company Server is a containerized Flask operations dashboard built as part of my DevOps learning journey.

The project began as a simulated Linux server environment for practising administration and Bash scripting. It was later upgraded into a real web application that can run locally or inside Docker using Gunicorn and Docker Compose.


## Features

- Responsive operations dashboard
- Application health endpoint
- Runtime information API
- Environment-based configuration
- Gunicorn production WSGI server
- Docker containerization
- Docker Compose deployment
- Linux monitoring and automation scripts


## Application Endpoints

| Endpoint    | Purpose                                     |
|-------------|---------------------------------------------|
| `/`         | Operations dashboard                        |
| `/health`   | Lightweight application health check        |
| `/api/info` | Detailed runtime and deployment information |


## Technology Stack

- Python
- Flask
- Gunicorn
- HTML
- CSS
- Linux
- Bash
- Docker
- Docker Compose


## Project Structure

```text
company-server/
├── README.md
└── web-app
    ├── Dockerfile
    ├── README.md
    ├── app.py
    ├── backup
    │   └── config.yml
    ├── compose.yaml
    ├── config.yml
    ├── logs
    ├── requirements.txt
    ├── scripts
    │   ├── backup.sh
    │   ├── cleanup-logs.sh
    │   ├── deploy.sh
    │   ├── disk-check.sh
    │   ├── greet.sh
    │   ├── hello.sh
    │   ├── input.sh
    │   ├── monitor-server.sh
    │   ├── server-health.sh
    │   ├── service-check.sh
    │   ├── status.sh
    │   └── variables.sh
    ├── static
    │   └── style.css
    └── templates
        └── index.html
```


## Scripts

| Script                      | Purpose                             |
| ----------------------------| ------------------------------------|
| `scripts/monitor-server.sh` | Displays server health              |
| `scripts/cleanup-logs.sh`   | Archives old log files              |
| `scripts/deploy.sh`         | Simulates an application deployment |


## Run Locally

Go to the web application directory:

```bash
cd web-app
```


Create and activate a Python virtual environment:

```bash
python3 -m venv .venv
source .venv/bin/activate
```


Install the dependencies:

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

Stop the application using `Ctrl + C`, then deactivate the virtual environment:

```bash
deactivate
```


## Run with Docker Compose

Go to the web application directory:

```bash
cd web-app
```


Validate the Compose configuration:

```bash
docker compose config
```


Build and start the application:

```bash
docker compose up --build -d
```


Open:

```text
http://localhost:8080
```


Inspect the container and its logs:

```bash
docker compose ps
docker compose logs
```


Stop and remove the Compose environment:

```bash
docker compose down
```


## Test the Endpoints

Health Check:

```bash
curl http://localhost:8080/health
```

Runtime Information:

```bash
curl http://localhost:8080/api/info
```


## Skills Demonstrated

- Linux filesystem navigation
- File and permission management
- Process and service inspection
- Linux log analysis
- Bash scripting
- Docker image creation
- Docker networking and port mapping
- Docker Compose configuration
- Environment variable management
- Health endpoint design
- Containerized web application deployment