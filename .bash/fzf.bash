# Para incluir los directorios .git
#export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore --files'
# Para excluir los directorios .git
# --follow es para seguir enlaces simbolicos. Da error si encuentra un bucle
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
