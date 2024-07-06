{{- define "GroceryStore.serviceAccountName" -}}
{{- if .Values.serviceAccount.name -}}
{{- .Values.serviceAccount.name -}}
{{- else -}}
{{ include "GroceryStore.fullname" . }}-sa
{{- end -}}
{{- end -}}
