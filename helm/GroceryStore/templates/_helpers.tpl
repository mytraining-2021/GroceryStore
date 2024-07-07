{{/*
Expand the name of the chart.
*/}}
{{- define "grocerystore.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" | replace "+" "-" | lower -}}
{{- end -}}

{{/*
Create a fullname using the release name and the chart name.
*/}}
{{- define "grocerystore.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" | replace "+" "-" | lower -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" | replace "+" "-" | lower -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "grocerystore.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | lower -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "grocerystore.labels" -}}
app.kubernetes.io/name: {{ include "grocerystore.name" . }}
helm.sh/chart: {{ include "grocerystore.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name | replace "+" "-" | lower }}
app.kubernetes.io/managed-by: {{ .Release.Service | lower }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "grocerystore.selectorLabels" -}}
app: {{ include "grocerystore.name" . }}
app.kubernetes.io/instance: {{ .Release.Name | replace "+" "-" | lower }}
{{- end -}}

{{/*
Service account name
*/}}
{{- define "grocerystore.serviceAccountName" -}}
{{- if .Values.serviceAccount.name -}}
{{- .Values.serviceAccount.name | lower -}}
{{- else -}}
{{ include "grocerystore.fullname" . }}-sa
{{- end -}}
{{- end -}}