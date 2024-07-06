{{/*
Expand the name of the chart.
*/}}
{{- define "GroceryStore.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a fullname using the release name and the chart name.
*/}}
{{- define "GroceryStore.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "GroceryStore.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "GroceryStore.labels" -}}
app.kubernetes.io/name: {{ include "GroceryStore.name" . }}
helm.sh/chart: {{ include "GroceryStore.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "GroceryStore.selectorLabels" -}}
app.kubernetes.io/name: {{ include "GroceryStore.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Service account name
*/}}
{{- define "GroceryStore.serviceAccountName" -}}
{{- if .Values.serviceAccount.name -}}
{{- .Values.serviceAccount.name -}}
{{- else -}}
{{ include "GroceryStore.fullname" . }}-sa
{{- end -}}
{{- end -}}
