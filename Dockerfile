FROM debian:stretch

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PYTHONPATH=/etc/superset:/home/superset:$PYTHONPATH \
    SUPERSET_HOME=/var/lib/superset

# Create superset user & install dependencies
RUN useradd -U -m superset && \
    mkdir /etc/superset  && \
    mkdir ${SUPERSET_HOME} && \
    chown -R superset:superset /etc/superset && \
    chown -R superset:superset ${SUPERSET_HOME} && \
    apt-get update && \
    apt-get install -y \
            build-essential \
            libssl-dev \
            libffi-dev \
            python-dev \
            python-pip \
            libsasl2-dev \
            libldap2-dev && \
    pip install --upgrade setuptools pip && \
    pip install \
         psycopg2-binary \
         superset \
         psycopg2

WORKDIR /home/superset

EXPOSE 8088
ENTRYPOINT ["superset"]
CMD ["runserver"]

USER superset
