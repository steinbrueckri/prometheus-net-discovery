# prometheus-net-discovery

Scan entire networks for open ports with known prometheus exporters and generate files with targets to be used with `file_sd_config` file based discovery

## install

```
go get -u github.com/fortnoxab/prometheus-net-discovery
```

## example run

```
prometheus-net-discovery -networks "192.168.1.0/24" --filesdpath /tmp/
```

## usage

## Commandline usage

```
$ prometheus-net-discovery --help
Usage of prometheus-net-discovery:
  -filesdpath
      Change value of FileSdPath.
  -interval
      Change value of Interval. (default 60m)
  -log-format
      Change value of Log-Format. (default text)
  -log-formatter
      Change value of Log-Formatter. (default <nil>)
  -log-level
      Change value of Log-Level.
  -networks
      Change value of Networks.

Generated environment variables:
   CONFIG_FILESDPATH
   CONFIG_INTERVAL
   CONFIG_LOG_FORMAT
   CONFIG_LOG_FORMATTER
   CONFIG_LOG_LEVEL
   CONFIG_NETWORKS

```

## Helm

```
helm repo add steinbrueckri https://steinbrueckri.github.io/prometheus-net-discovery
helm install --set interval=45m --set networks=10.0.0.0/24,192.168.66.0/24 prometheus-net-discovery steinbrueckri/prometheus-net-discovery
```

## Docker

```
docker run -d -e CONFIG_INTERVAL=30m -e CONFIG_NETWORKS=10.0.0.0/24,192.168.66.0/24 steinbrueckri/prometheus-net-discovery:latest
```

## TODO

- Add metrics to prometheus-net-discovery
