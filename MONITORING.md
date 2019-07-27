# Monitoring

### Web Console

To run a local web console of the medium intended for the metrics endpoint (Prometheus):

1. Create a config file for Prometheus and save it to `<current_directory>/prom_config_out/prometheus.yml`:

i.e.:
```
global:
  scrape_interval:     15s # By default, scrape targets every 15 seconds.

  # Attach these labels to any time series or alerts when communicating with
  # external systems (federation, remote storage, Alertmanager).
  external_labels:
    monitor: 'my-cool-monitor'

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    static_configs:
    - targets: ['localhost:9090']

  - job_name: 'java-tron'

    static_configs:
    - targets: ['java-tron:19000'] <-- container's name/IP and it's metrics port
```

2. Run it in Docker:
```
docker run -d --rm -p 9090:9090 --network tron -v $(PWD)/prom_config_out:/etc/prometheus/config_out \
    quay.io/prometheus/prometheus:v2.7.2 \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries \
    --config.file=/etc/prometheus/config_out/prometheus.yml \
    --storage.tsdb.path=/prometheus \
    --storage.tsdb.retention.time=20m \
    --web.enable-lifecycle \
    --storage.tsdb.no-lockfile \
    --web.route-prefix=/
```