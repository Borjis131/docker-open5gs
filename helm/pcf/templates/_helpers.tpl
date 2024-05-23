{{/*
Return the proper pcf image name
*/}}
{{- define "pcf.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper pcf config file
*/}}
{{- define "pcf.config" -}}
{{- if .Values.config }}
{{- toYaml .Values.config | nindent 4 }}
{{- else }}
{{ tpl (.Files.Get "configs/pcf.yaml") . | indent 4 }}
{{- end }}
{{- end -}}