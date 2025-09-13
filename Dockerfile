FROM python:3.11-slim

WORKDIR /app

COPY src/ ./src/

CMD ["python", "src/calculator.py", "--mode", "service"]
