FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN ln -s /usr/bin/python3 /usr/bin/python
# Встановлюємо wheel для уникнення проблем з установкою
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-wheel \
    && rm -rf /var/lib/apt/lists/*
RUN python3 -m venv /app/myenv
RUN pip install --upgrade pip setuptools wheel
RUN pip install --use-pep517 -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["python", "./manage.py", "runserver", "0.0.0.0:8000"]

