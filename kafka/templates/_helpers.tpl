{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kafka.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kafka.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kafka.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create kafka path. 
if .Values.kafka.path is empty, default value "/var/lib/kafka/data".
*/}}
{{- define "kafka.fullpath" -}}
{{- if .Values.kafka.path -}}
{{- .Values.kafka.path | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s" "/var/lib/kafka/data" -}}
{{- end -}}
{{- end -}}

{{/*
Create the Kafka broker ID from pod ordinal
*/}}
{{- define "kafka.brokerId" -}}
{{- if eq .Values.kafka.configmap.broker_id "auto" -}}
{{- printf "${HOSTNAME##*-}" -}}
{{- else -}}
{{- .Values.kafka.configmap.broker_id -}}
{{- end -}}
{{- end -}}

{{/*
Create the Kafka advertised listeners
*/}}
{{- define "kafka.advertisedListeners" -}}
{{- $fullname := include "kafka.fullname" . -}}
{{- printf "PLAINTEXT://%s-${POD_ORDINAL}.%s-headless.%s.svc.%s:%s,PLAINTEXT_INTERNAL://%s-${POD_ORDINAL}.%s-headless.%s.svc.%s:%s" $fullname $fullname .Release.Namespace .Values.clusterDomain .Values.kafka.client_port $fullname $fullname .Release.Namespace .Values.clusterDomain .Values.kafka.internal_port -}}
{{- end -}}

{{/*
Create the Kafka listeners
*/}}
{{- define "kafka.listeners" -}}
{{- printf "PLAINTEXT://0.0.0.0:%s,PLAINTEXT_INTERNAL://0.0.0.0:%s" .Values.kafka.client_port .Values.kafka.internal_port -}}
{{- end -}}

