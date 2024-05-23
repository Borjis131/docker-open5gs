{{/*
Return the proper db image name
*/}}
{{- define "db.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper db config file
*/}}
{{- define "db.config" -}}
{{- if .Values.config }}
{{- toYaml .Values.config | nindent 4 }}
{{- else }}
{{ tpl (.Files.Get "configs/mongod.conf") . | indent 4 }}
{{- end }}
{{- end -}}