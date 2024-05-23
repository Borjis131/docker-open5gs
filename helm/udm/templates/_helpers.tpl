{{/*
Return the proper udm image name
*/}}
{{- define "udm.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper udm config file
*/}}
{{- define "udm.config" -}}
{{- if .Values.config }}
{{- toYaml .Values.config | nindent 4 }}
{{- else }}
{{ tpl (.Files.Get "configs/udm.yaml") . | indent 4 }}
{{- end }}
{{- end -}}