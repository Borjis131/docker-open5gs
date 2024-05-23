{{/*
Return the proper smf image name
*/}}
{{- define "smf.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper smf config file
*/}}
{{- define "smf.config" -}}
{{- if .Values.config }}
{{- toYaml .Values.config | nindent 4 }}
{{- else }}
{{ tpl (.Files.Get "configs/smf.yaml") . | indent 4 }}
{{- end }}
{{- end -}}