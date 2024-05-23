{{/*
Return the proper udr image name
*/}}
{{- define "udr.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper udr config file
*/}}
{{- define "udr.config" -}}
{{- if .Values.config }}
{{- toYaml .Values.config | nindent 4 }}
{{- else }}
{{ tpl (.Files.Get "configs/udr.yaml") . | indent 4 }}
{{- end }}
{{- end -}}