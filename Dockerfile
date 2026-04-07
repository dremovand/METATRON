FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    nmap \
    whois \
    whatweb \
    curl \
    dnsutils \
    ca-certificates \
    && if apt-cache show nikto >/dev/null 2>&1; then apt-get install -y --no-install-recommends nikto; else echo "[!] nikto package not available in this base image; continuing without it"; fi \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "metatron.py"]
