FROM python:3.11-bullseye AS build

WORKDIR /src

# Create and "activate" the virtual environment
RUN python3 -m venv /app
ENV PATH=/app/bin:$PATH

# Install the application as normal
COPY requirements.txt .
RUN pip install -r requirements.txt

FROM gcr.io/distroless/python3-debian12 AS final

COPY ETL/main.py .
COPY --from=build /app /app
ENV PATH=/app/bin:$PATH
ENV PYTHONPATH=/app/lib/python3.11/site-packages:$PYTHONPATH

# RUN . /app/bin/activate

# RUN pip install --upgrade pip
# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt

# WORKDIR /app/ETL
# COPY ETL/main.py .

# RUN groupadd --system --gid 1069 apprunner
# RUN useradd --system --uid 1069 --gid apprunner apprunner

CMD ["main.py"]