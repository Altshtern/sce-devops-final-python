# Use official Python runtime as a parent image
FROM python:3.7.17-alpine

# Set working directory
WORKDIR /app

# Install system dependencies
# RUN apk add --no-cache gcc musl-dev

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create non-root user for security
RUN adduser --disabled-password --gecos '' appuser && \
    chown -R appuser:appuser /app
USER appuser

# Run the application
CMD ["python", "app.py"]
