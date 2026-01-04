# Helm Charts Repository

This repository contains Helm charts for deploying various applications on Kubernetes.

## Available Charts

### [ClickHouse](./clickhouse/)

A Helm chart for deploying ClickHouse on Kubernetes. ClickHouse is an open-source column-oriented database management system capable of real-time generation of analytical data reports using SQL queries.

**Chart Details:**
- **Chart Version**: 25.21
- **App Version**: 25.12
- **Repository**: `kafka-charts/clickhouse`

**Quick Start:**
```bash
helm repo add kafka-charts https://thiagoloureiro.github.io/kafka.chart/
helm repo update
helm install my-clickhouse kafka-charts/clickhouse
```

For more information, see the [ClickHouse Chart README](./clickhouse/README.md).

### [Kafka](./kafka/)

A Helm chart for deploying Apache Kafka on Kubernetes. Apache Kafka is a distributed event streaming platform capable of handling trillions of events a day.

**Chart Details:**
- **Chart Version**: 0.1.0
- **App Version**: 4.1.1
- **Repository**: `kafka-charts/kafka`

**Quick Start:**
```bash
helm repo add kafka-charts https://thiagoloureiro.github.io/kafka.chart/
helm repo update
helm install my-kafka kafka-charts/kafka
```

For more information, see the [Kafka Chart README](./kafka/README.md).

## Repository Setup

### Add the Helm repository

```bash
helm repo add kafka-charts https://thiagoloureiro.github.io/kafka.chart/
helm repo update
```

### List available charts

```bash
helm search repo kafka-charts
```

## Installation Examples

### Install ClickHouse

```bash
helm install my-clickhouse kafka-charts/clickhouse
```

### Install Kafka

```bash
helm install my-kafka kafka-charts/kafka
```

### Install with custom values

```bash
helm install my-kafka kafka-charts/kafka -f my-kafka-values.yaml
```

## Development

### Building and Publishing

To create a new version of a chart:

```bash
./create-version.sh
```

This script will:
1. Package the Helm chart
2. Update the repository index
3. Prepare the chart for publishing to GitHub Pages

### Chart Structure

```
.
├── clickhouse/          # ClickHouse Helm chart
│   ├── Chart.yaml
│   ├── values.yaml
│   ├── README.md
│   └── templates/
├── kafka/               # Kafka Helm chart
│   ├── Chart.yaml
│   ├── values.yaml
│   ├── README.md
│   └── templates/
├── index.yaml          # Helm repository index
└── README.md           # This file
```

## Resources

- [Helm Documentation](https://helm.sh/docs/)
- [ClickHouse Documentation](https://clickhouse.com/docs/)
- [Apache Kafka Documentation](https://kafka.apache.org/documentation/)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For issues and questions, please open an issue on the [GitHub repository](https://github.com/thiagoloureiro/kafka.chart).

## License

These Helm charts are provided as-is. Please refer to the respective software licenses for the applications themselves.
