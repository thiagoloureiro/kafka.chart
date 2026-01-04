# Kafka Helm Chart

A Helm chart for deploying Apache Kafka on Kubernetes. Apache Kafka is a distributed event streaming platform capable of handling trillions of events a day.

## Features

- **High Availability**: Supports multi-broker deployments with StatefulSet
- **Persistent Storage**: Configurable persistent volumes for Kafka logs
- **Automatic Broker ID**: Broker IDs automatically assigned from pod ordinal
- **Kubernetes-Aware**: Proper advertised listeners for Kubernetes DNS discovery
- **Flexible Configuration**: Extensive configuration options via values.yaml
- **ZooKeeper Support**: Optional ZooKeeper integration (or use KRaft mode)
- **Health Probes**: Startup, liveness, and readiness probes configured
- **Resource Management**: Configurable resource limits and requests

## Chart Details

- **Chart Version**: 0.1.0
- **App Version**: 4.1.1
- **Maintainer**: thiagoloureiro

## Installation

### Add the Helm repository

```bash
helm repo add kafka https://thiagoloureiro.github.io/kafka.chart/
helm repo update
```

### Install the chart

```bash
helm install my-kafka kafka/kafka
```

### Install with custom values

```bash
helm install my-kafka kafka/kafka -f my-values.yaml
```

## Configuration

The following table lists the most important configurable parameters and their default values:

| Parameter | Description | Default |
|-----------|-------------|---------|
| `kafka.replicas` | Number of Kafka brokers | `3` |
| `kafka.image` | Kafka image | `apache/kafka` |
| `kafka.imageVersion` | Kafka image version | `4.1.1` |
| `kafka.persistentVolumeClaim.enabled` | Enable persistent volumes | `true` |
| `kafka.persistentVolumeClaim.dataPersistentVolume.storage` | Data volume size | `100Gi` |
| `kafka.client_port` | Client connection port | `9092` |
| `kafka.internal_port` | Internal broker communication port | `9093` |
| `kafka.configmap.num_partitions` | Default number of partitions per topic | `3` |
| `kafka.configmap.offsets_topic_replication_factor` | Offsets topic replication factor | `3` |
| `kafka.configmap.zookeeper_connect` | ZooKeeper connection string (optional) | `""` |
| `timezone` | Timezone for the cluster | `UTC` |

For a complete list of configuration options, see [values.yaml](values.yaml).

## Examples

### Basic Installation

```bash
helm install kafka kafka/kafka
```

### Installation with Custom Replicas

```bash
helm install kafka kafka/kafka \
  --set kafka.replicas=5
```

### Installation with Custom Storage

```bash
helm install kafka kafka/kafka \
  --set kafka.persistentVolumeClaim.dataPersistentVolume.storage=500Gi
```

### Installation with ZooKeeper

```bash
helm install kafka kafka/kafka \
  --set kafka.configmap.zookeeper_connect=zookeeper:2181
```

### Installation with Custom Partitions

```bash
helm install kafka kafka/kafka \
  --set kafka.configmap.num_partitions=6
```

## Accessing Kafka

### Client Port

The client port is available on port `9092`:

```bash
# Port forward to access locally
kubectl port-forward svc/kafka 9092:9092
```

### Using Kafka CLI Tools

You can use the Kafka CLI tools from within a pod:

```bash
# List topics
kubectl exec -it kafka-0 -- /opt/kafka/bin/kafka-topics.sh \
  --bootstrap-server localhost:9092 --list

# Create a topic
kubectl exec -it kafka-0 -- /opt/kafka/bin/kafka-topics.sh \
  --bootstrap-server localhost:9092 \
  --create --topic test-topic \
  --partitions 3 --replication-factor 3

# Describe a topic
kubectl exec -it kafka-0 -- /opt/kafka/bin/kafka-topics.sh \
  --bootstrap-server localhost:9092 \
  --describe --topic test-topic

# Produce messages
kubectl exec -it kafka-0 -- /opt/kafka/bin/kafka-console-producer.sh \
  --bootstrap-server localhost:9092 --topic test-topic

# Consume messages
kubectl exec -it kafka-0 -- /opt/kafka/bin/kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 --topic test-topic --from-beginning
```

### Connecting from Applications

Connect to Kafka using the service name:

```yaml
# Example: bootstrap.servers=kafka:9092
```

Or connect to individual brokers:

```yaml
# Example: bootstrap.servers=kafka-0.kafka-headless.default.svc.cluster.local:9092,kafka-1.kafka-headless.default.svc.cluster.local:9092,kafka-2.kafka-headless.default.svc.cluster.local:9092
```

## Broker Discovery

Kafka brokers are automatically configured with proper advertised listeners for Kubernetes:

- **Client listeners**: `PLAINTEXT://kafka-{ordinal}.kafka-headless.{namespace}.svc.{clusterDomain}:9092`
- **Internal listeners**: `PLAINTEXT_INTERNAL://kafka-{ordinal}.kafka-headless.{namespace}.svc.{clusterDomain}:9093`

Broker IDs are automatically assigned from the pod ordinal (0, 1, 2, ...).

## Upgrading

```bash
helm upgrade kafka kafka/kafka
```

## Uninstalling

```bash
helm uninstall kafka
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

- [Apache Kafka Documentation](https://kafka.apache.org/documentation/)
- [Apache Kafka GitHub](https://github.com/apache/kafka)
- [Helm Documentation](https://helm.sh/docs/)

## License

This Helm chart is provided as-is. Please refer to the Apache Kafka license for the software itself.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For issues and questions, please open an issue on the [GitHub repository](https://github.com/thiagoloureiro/kafka.chart).

