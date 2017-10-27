#-----------------------------------------------------------------
# 基本設定
#-----------------------------------------------------------------
WORDCHARS="*?_-.[]~=&;\!#$%^(){}<>"
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=$HOME/.zsh_history
umask 022
#-----------------------------------------------------------------
# 環境変数
#-----------------------------------------------------------------
# setup shell dir
SHELL=/bin/zsh
export SHELL

# set path
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# less で行番号をつけ，終了後に画面を残す
export LESS='-i -M -X -R'
#export PAGER=less
export PAGER="lv -Ou8 -c -s"

#-----------------------------------------------------------------
# ローカル設定の読み込み
#-----------------------------------------------------------------
[ -f ~/.zshenv.local ] && source ~/.zshenv.local

