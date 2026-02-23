FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create non-root user
RUN groupadd -r tradingagents && \
    useradd -r -g tradingagents -u 1000 -m -d /home/tradingagents tradingagents && \
    chown -R tradingagents:tradingagents /app

USER tradingagents

EXPOSE 11360
CMD ["python", "http_server.py"]
