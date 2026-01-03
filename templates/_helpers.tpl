{{/*
Expand the name of the chart.
*/}}
{{- define "livellm-browser.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "livellm-browser.fullname" -}}
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
{{- define "livellm-browser.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "livellm-browser.labels" -}}
helm.sh/chart: {{ include "livellm-browser.chart" . }}
{{ include "livellm-browser.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "livellm-browser.selectorLabels" -}}
app.kubernetes.io/name: {{ include "livellm-browser.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "livellm-browser.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "livellm-browser.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create PVC name for chrome-profile
*/}}
{{- define "livellm-browser.chromeProfilePvcName" -}}
{{- if .Values.persistence.chromeProfile.existingClaim }}
{{- .Values.persistence.chromeProfile.existingClaim }}
{{- else }}
{{- printf "%s-chrome-profile" (include "livellm-browser.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Create PVC name for firefox-profile
*/}}
{{- define "livellm-browser.firefoxProfilePvcName" -}}
{{- if .Values.persistence.firefoxProfile.existingClaim }}
{{- .Values.persistence.firefoxProfile.existingClaim }}
{{- else }}
{{- printf "%s-firefox-profile" (include "livellm-browser.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Create PVC name for downloads
*/}}
{{- define "livellm-browser.downloadsPvcName" -}}
{{- if .Values.persistence.downloads.existingClaim }}
{{- .Values.persistence.downloads.existingClaim }}
{{- else }}
{{- printf "%s-downloads" (include "livellm-browser.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Create PVC name for documents
*/}}
{{- define "livellm-browser.documentsPvcName" -}}
{{- if .Values.persistence.documents.existingClaim }}
{{- .Values.persistence.documents.existingClaim }}
{{- else }}
{{- printf "%s-documents" (include "livellm-browser.fullname" .) }}
{{- end }}
{{- end }}
