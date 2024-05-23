{{/*
Return the proper amf image name
*/}}
{{- define "amf.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper amf config file
*/}}
{{- define "amf.config" -}}
{{- if .Values.config }}
{{- toYaml .Values.config | nindent 4 }}
{{- else }}
{{ tpl (.Files.Get "configs/amf.yaml") . | indent 4 }}
{{- end }}
{{- end -}}