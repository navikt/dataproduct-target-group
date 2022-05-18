FROM navikt/python:3.8

USER root

COPY . .
RUN pip install -r requirements.txt

USER apprunner

CMD ["python", "etl/alt_source_stage.py"]