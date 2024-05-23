{{/*
Return the proper bsf image name
*/}}
{{- define "bsf.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper bsf config file
*/}}
{{- define "bsf.config" -}}
{{- if .Values.config }}
{{- toYaml .Values.config | nindent 4 }}
{{- else }}
{{ tpl (.Files.Get "configs/bsf.yaml") . | indent 4 }}
{{- end }}
{{- end -}}