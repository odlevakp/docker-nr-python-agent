# NewRelic Python Agent inside docker

[NewRelic Python Agent](https://github.com/NewRelic-Python-Plugins/newrelic-python-agent) inside a docker Ubuntu 16.04 based container.

You need to provide a valid config before running. For instance `/tmp/newrelic-python-agent.cfg`:
```yaml
%YAML 1.2
---
Application:
  license_key: REPLACE_WITH_REAL_KEY
  wake_interval: 60

  elasticsearch:
    name: plugin-test
    host: 172.17.0.1
    port: 9200
 ```

Look at [github](https://github.com/NewRelic-Python-Plugins/newrelic-python-agent) for a complete configuration example.

To create a container:

```sh
docker run -d \
--name nr-agent \
-v /tmp/newrelic-python-agent.cfg:/etc/newrelic/newrelic-python-agent.cfg \
odlevakp/nr-python-agent:latest
```
