#!/bin/bash
# Este script observa cambios en el directorio actual de manera recursiva.
# Cuando detecta un cambio (creación, modificación o eliminación), realiza:
#   git add -A, git commit con un mensaje automático y git push.

# Configura el mensaje de commit, por ejemplo usando la fecha/hora
AUTO_MESSAGE="Autocommit: $(date +'%Y-%m-%d %H:%M:%S')"

while inotifywait -r -e modify,create,delete,move .; do
    # Agrega todos los cambios
    git add -A

    # Realiza un commit solo si hay cambios nuevos
    if ! git diff-index --quiet HEAD --; then
        git commit -m "$AUTO_MESSAGE"
        git push
    fi
done
