{{/*
Return the proper webui image name
*/}}
{{- define "webui.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}