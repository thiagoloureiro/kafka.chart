#!/bin/bash

# Package both charts
echo "Packaging ClickHouse chart..."
helm package clickhouse

echo "Packaging Kafka chart..."
helm package kafka

# Update the repository index
echo "Updating repository index..."
helm repo index --url https://thiagoloureiro.github.io/kafka.chart/ .

echo "Done! Charts packaged and index updated."  