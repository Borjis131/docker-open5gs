{{/*
Return the proper nrf image name
*/}}
{{- define "nrf.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper nrf config file
*/}}
{{- define "nrf.config" -}}
{{- if .Values.config }}
{{- toYaml .Values.config | nindent 4 }}
{{- else }}
{{ tpl (.Files.Get "configs/nrf.yaml") . | indent 4 }}
{{- end }}
{{- end -}}