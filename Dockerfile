FROM python:latest

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

# 8082 is the default port for luigi

EXPOSE 8082

# Copy in pipeline

COPY pipeline /opt/recon-pipeline/pipeline
COPY Pipfile* /opt/recon-pipeline/

# Install dependencies

RUN cd /opt/recon-pipeline && \
    pip3 install pipenv && \
    pipenv install --system --deploy && \
    mkdir -p /var/log/luigi && \
    ln -s /opt/recon-pipeline/pipeline/recon-pipeline.py /bin/pipeline

# Run luigi

CMD ["/usr/local/bin/luigid", "--pidfile", "/var/run/luigid.pid", "--logdir", "/var/log/luigi"]
