{{- define "payflow-pro.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "payflow-pro.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "payflow-pro.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "payflow-pro.labels" -}}
helm.sh/chart: {{ include "payflow-pro.chart" . }}
{{ include "payflow-pro.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
pci-scope: "true"
{{- end }}

{{- define "payflow-pro.selectorLabels" -}}
app.kubernetes.io/name: {{ include "payflow-pro.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "payflow-pro.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "payflow-pro.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
