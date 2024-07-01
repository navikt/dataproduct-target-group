FROM python:3.12-bullseye

RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /app/ETL
COPY ETL/main.py .

RUN groupadd --system --gid 1069 apprunner
RUN useradd --system --uid 1069 --gid apprunner apprunner

CMD ["python", "main.py"]