{{/*
Expand the name of the chart.
*/}}
{{- define "prometheus-net-discovery.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "prometheus-net-discovery.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "prometheus-net-discovery.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "prometheus-net-discovery.labels" -}}
helm.sh/chart: {{ include "prometheus-net-discovery.chart" . }}
{{ include "prometheus-net-discovery.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "prometheus-net-discovery.selectorLabels" -}}
app.kubernetes.io/name: {{ include "prometheus-net-discovery.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "prometheus-net-discovery.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "prometheus-net-discovery.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create default labels
*/}}
{{- define "prometheus-net-discovery.defaultLabels" -}}
{{- $labelChart := include "prometheus-net-discovery.chart" $ -}}
{{- $labelApp := include "prometheus-net-discovery.name" $ -}}
{{- $labels := dict "app" $labelApp "chart" $labelChart "release" .Release.Name "heritage" .Release.Service -}}
{{ merge .extraLabels $labels | toYaml | indent 4 }}
{{- end -}}