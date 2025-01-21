#!/bin/bash

create_worktree() {
    read -p "Nome da nova worktree: " NEW_WORKTREE_NAME

    if [ -n "$NEW_WORKTREE_NAME" ]; then
        echo "Criando worktree '$NEW_WORKTREE_NAME'..."
        git worktree add "$NEW_WORKTREE_NAME"
        sleep 1
    else
        echo "Nenhum nome de worktree fornecido. Abortando."
        return
    fi
}

delete_worktree() {
    WORKTREE_TO_DELETE=$(git worktree list | fzf --prompt="Selecione o worktree para deletar: " | awk '{print $1}')

    if [ -n "$WORKTREE_TO_DELETE" ]; then
        echo "Tem certeza que deseja deletar a worktree '$WORKTREE_TO_DELETE'? (y/n)"
        read -r CONFIRM_DELETE
        if [ "$CONFIRM_DELETE" != "y" ]; then
            echo "Operação cancelada."
            sleep 2
            return
        fi
        git worktree remove "$WORKTREE_TO_DELETE"
        delete_worktree
    else
        echo "Nenhuma worktree selecionada. Abortando."
        return
    fi
}

select_worktree() {
    WORKTREE_DIR=$(git worktree list | fzf --prompt="Escolha um worktree: " | awk '{print $1}')

    if [ -n "$WORKTREE_DIR" ]; then
        tmux send-keys "cd $WORKTREE_DIR" C-m
        echo "Worktree selecionada: $WORKTREE_DIR"
    else
        echo "Nenhuma worktree selecionada."
    fi
}

ACTION=$(echo -e "Select (cd into worktree)\nCreate (git worktree add)\nDelete (git worktree remove)" | fzf --prompt="Selecione uma ação: ")

case "$ACTION" in
    "Create (git worktree add)")
        create_worktree
        ;;
    "Delete (git worktree remove)")
        delete_worktree
        ;;
    "Select (cd into worktree)")
        select_worktree
        ;;
    *)
        echo "Nenhuma ação selecionada."
        ;;
esac
