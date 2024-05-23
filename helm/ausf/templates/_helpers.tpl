{{/*
Return the proper ausf image name
*/}}
{{- define "ausf.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper ausf config file
*/}}
{{- define "ausf.config" -}}
{{- if .Values.config }}
{{- toYaml .Values.config | nindent 4 }}
{{- else }}
{{ tpl (.Files.Get "configs/ausf.yaml") . | indent 4 }}
{{- end }}
{{- end -}}