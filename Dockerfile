FROM ubuntu:16.04
LABEL version "1.0"
LABEL description "Docker image for newrelic-python-agent."


RUN mkdir -p /home/newrelic /etc/newrelic /var/log/newrelic /var/run/newrelic && \
    groupadd --system newrelic && \
    useradd --system --gid newrelic newrelic && \
    apt-get update && \
    apt-get install --yes python-pip && \
    pip install newrelic-python-agent && \
    pip install newrelic-python-agent[postgresql] && \
    pip install newrelic-python-agent[pgbouncer] && \
    pip install newrelic-python-agent[mongodb] && \
    chown -R newrelic:newrelic /home/newrelic /etc/newrelic /var/log/newrelic /var/run/newrelic && \
    chmod -R 755 /etc/newrelic /var/log/newrelic /var/run/newrelic

# Rebuild from git master hack.
RUN apt-get install --yes git && \
    git clone https://github.com/NewRelic-Python-Plugins/newrelic-python-agent.git && \
    cd newrelic-python-agent && \
    python setup.py install && \
    apt-get remove --yes git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/newrelic

USER newrelic

CMD ["/usr/local/bin/newrelic-python-agent", "-c", "/etc/newrelic/newrelic-python-agent.cfg", "-f"]
