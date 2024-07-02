FROM python:3.11-bullseye AS build

WORKDIR /src

RUN python3 -m venv /app
ENV PATH=/app/bin:$PATH

RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt

FROM gcr.io/distroless/python3-debian12 AS final

COPY ETL/main.py .
COPY --from=build /app /app
ENV PATH=/app/bin:$PATH
ENV PYTHONPATH=/app/lib/python3.11/site-packages:$PYTHONPATH

CMD ["main.py"]