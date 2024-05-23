{{/*
Return the proper nssf image name
*/}}
{{- define "nssf.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper nssf config file
*/}}
{{- define "nssf.config" -}}
{{- if .Values.config }}
{{- toYaml .Values.config | nindent 4 }}
{{- else }}
{{ tpl (.Files.Get "configs/nssf.yaml") . | indent 4 }}
{{- end }}
{{- end -}}