# Bashrc folder
#
# 1. This folder will be mounted to /etc/bashrc-devilbox.d
# 2. All files ending by *.sh will be sourced by bash automatically
#    for the devilbox and root user.
#


# Add your custom vimrc and always load it with vim.
# Also make sure you add vimrc to this folder.
alias vim='vim -u /etc/bashrc-devilbox.d/vimrc'
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
