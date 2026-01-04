# ClickHouse Helm Chart

A Helm chart for deploying ClickHouse on Kubernetes. ClickHouse is an open-source column-oriented database management system capable of real-time generation of analytical data reports using SQL queries.

## Features

- **High Availability**: Supports multi-replica deployments with StatefulSet
- **Persistent Storage**: Configurable persistent volumes for data and logs
- **Metrics & Monitoring**: Built-in Prometheus metrics exporter with optional ServiceMonitor support
- **Web Interface**: Optional Tabix web UI for managing ClickHouse
- **Flexible Configuration**: Extensive configuration options via values.yaml
- **ZooKeeper Support**: Optional ZooKeeper integration for replicated tables
- **Ingress Support**: Configurable ingress for HTTP access
- **Resource Management**: Configurable resource limits and requests

## Chart Details

- **Chart Version**: 25.12
- **App Version**: 25.12
- **Maintainer**: thiagoloureiro

## Installation

### Add the Helm repository

```bash
helm repo add clickhouse https://thiagoloureiro.github.io/clickhouse.chart/
helm repo update
```

### Install the chart

```bash
helm install my-clickhouse clickhouse/clickhouse
```

### Install with custom values

```bash
helm install my-clickhouse clickhouse/clickhouse -f my-values.yaml
```

## Configuration

The following table lists the most important configurable parameters and their default values:

| Parameter | Description | Default |
|-----------|-------------|---------|
| `clickhouse.replicas` | Number of ClickHouse replicas | `3` |
| `clickhouse.image` | ClickHouse image | `clickhouse/clickhouse-server` |
| `clickhouse.imageVersion` | ClickHouse image version | `25.12` |
| `clickhouse.persistentVolumeClaim.enabled` | Enable persistent volumes | `true` |
| `clickhouse.persistentVolumeClaim.dataPersistentVolume.storage` | Data volume size | `100Gi` |
| `clickhouse.metrics.enabled` | Enable Prometheus metrics | `true` |
| `clickhouse.metrics.port` | Metrics port | `9116` |
| `tabix.enabled` | Enable Tabix web UI | `false` |
| `timezone` | Timezone for the cluster | `UTC` |

For a complete list of configuration options, see [values.yaml](clickhouse/values.yaml).

## Examples

### Basic Installation

```bash
helm install clickhouse clickhouse/clickhouse
```

### Installation with Custom Replicas

```bash
helm install clickhouse clickhouse/clickhouse \
  --set clickhouse.replicas=5
```

### Installation with Tabix UI

```bash
helm install clickhouse clickhouse/clickhouse \
  --set tabix.enabled=true
```

### Installation with Custom Storage

```bash
helm install clickhouse clickhouse/clickhouse \
  --set clickhouse.persistentVolumeClaim.dataPersistentVolume.storage=500Gi
```

### Installation with Prometheus ServiceMonitor

```bash
helm install clickhouse clickhouse/clickhouse \
  --set clickhouse.metrics.serviceMonitor.enabled=true
```

## Accessing ClickHouse

### HTTP Interface

The HTTP interface is available on port `8123`:

```bash
# Port forward to access locally
kubectl port-forward svc/clickhouse 8123:8123

# Query via HTTP
curl 'http://localhost:8123/?query=SELECT%201'
```

### Native TCP Interface

The native TCP interface is available on port `9000`:

```bash
# Port forward to access locally
kubectl port-forward svc/clickhouse 9000:9000
```

### Tabix Web UI

If Tabix is enabled, you can access it via port forwarding or ingress:

```bash
# Port forward to access locally
kubectl port-forward svc/clickhouse-tabix 8080:80
```

Then open `http://localhost:8080` in your browser.

## Upgrading

```bash
helm upgrade clickhouse clickhouse/clickhouse
```

## Uninstalling

```bash
helm uninstall clickhouse
```

**Note**: This will delete all resources including persistent volumes. Make sure to backup your data before uninstalling.

## Development

### Building and Publishing

To create a new version of the chart:

```bash
./create-version.sh
```

This script will:
1. Package the Helm chart
2. Update the repository index
3. Prepare the chart for publishing to GitHub Pages

## Resources

- [ClickHouse Documentation](https://clickhouse.com/docs/)
- [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse)
- [Helm Documentation](https://helm.sh/docs/)

## License

This Helm chart is provided as-is. Please refer to the ClickHouse license for the database software itself.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For issues and questions, please open an issue on the [GitHub repository](https://github.com/thiagoloureiro/clickhouse.chart).

