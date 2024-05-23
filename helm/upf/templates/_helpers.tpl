{{/*
Return the proper upf image name
*/}}
{{- define "upf.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper upf config file
*/}}
{{- define "upf.config" -}}
{{- if .Values.config }}
{{- toYaml .Values.config | nindent 4 }}
{{- else }}
{{ tpl (.Files.Get "configs/upf.yaml") . | indent 4 }}
{{- end }}
{{- end -}}