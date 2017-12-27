###################################################################
# ~/.zshrc 
#                            Time-stamp: <2017-12-26 20:51:14 minoru>
# $Id: $

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
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

#-----------------------------------------------------------------
# プロンプト
#-----------------------------------------------------------------
# ユーザ名・ホスト名を左プロンプト表示、カレントディレクトリ名は
# 右プロンプト表示する。日本語のディレクトリ名も表示できるように、
# precmd() を使って毎回設定しなおしてみた。
#
# 端末のタイトルに prompt を表示する
case $TERM in
kterm|mlterm|xterm|xterm-color|rxvt|dtterm|vt100|screen|screen-bce|screen-256color|cygwin|xterm-256color)
    export LANG="ja_JP.UTF-8"
    # Windowのタイトルバーにカレントディレクトリ
    # が表示可能な場合のプロンプト設定
    #   表示例→ hoge@host:/usr/X11R6/lib/X11/app-defaults$ _
    #PS1='\u@\h:\w\$ '
    #   表示例→ hoge@host:app-defaults$ _
    #PS1='\u@\h:\W\$ '
    PS1='\h:\w\$ '
    HN="$SCREEN`hostname`:"
    #HN="$SCREEN`hostname -s`:"
    case "$TERM" in
    vt*)
	HN=""
    ;;
    esac
    function mkrmhmpwd () { BSBS_HOME=`echo "/$HOME"|sed -e 's/\//\\\\\//g'` ;
	RMHMPWD=`echo "/$PWD"|sed -e "s/$BSBS_HOME/~/g"` ;
	if [ "$RMHMPWD" = "/$PWD" ] ; then
	    RMHMPWD="$PWD"
	fi
    }
    # 遅いマシンではこの設定の方がいいかも…
    # function mkrmhmpwd () { RMHMPWD="$PWD" ; }
    function termtitle () { echo -ne "\033]0;$*\007" ; }
    function cd () {
	if [ "x.$*" = "x." ] ; then
	    builtin cd $* ;
	else
	    builtin cd "$*" ;
	fi
	mkrmhmpwd ; termtitle "$HN""[$RMHMPWD]" ;
    }
    function popd () {
	if [ "x.$*" = "x." ] ; then
	    builtin popd $* ;
	else
	    builtin popd "$*" ;
	fi
	mkrmhmpwd ; termtitle "$HN""[$RMHMPWD]" ;
    }
    function pushd () {
	if [ "x.$*" = "x." ] ; then
	    builtin pushd $* ;
	else
	    builtin pushd "$*" ;
	fi
	mkrmhmpwd ; termtitle "$HN""[$RMHMPWD]" ;
    }
    function pwd () { builtin pwd ; mkrmhmpwd ; termtitle "$HN""[$RMHMPWD]" ; }
    function su () { mkrmhmpwd ; termtitle "$HN""su $*($RMHMPWD)" ;
	if [ "$1" = "-c" ] ; then command su -c "$2";
	elif [ "$2" = "-c" ] ; then command su $1 -c "$3" 
	elif [ "$3" = "-c" ] ; then command su - $2 -c "$4"
	else command su $* ; fi
	mkrmhmpwd ; termtitle "$HN""[$RMHMPWD]" ; }
    function rsh () {
	termtitle "$HN""rsh $*" 
	command rsh $* 
	mkrmhmpwd ; termtitle "$HN""[$RMHMPWD]"
    }
    function rlogin () { 
	termtitle "$HN""rlogin $*" 
	command rlogin $* 
	mkrmhmpwd ; termtitle "$HN""[$RMHMPWD]" 
    }
    function telnet () { 
	termtitle "$HN""telnet $*" 
	command telnet $* 
	mkrmhmpwd ; termtitle "$HN""[$RMHMPWD]"
    }
    function ssh () { 
	termtitle "$HN""ssh $*" 
	command ssh $* 
	mkrmhmpwd ; termtitle "$HN""[$RMHMPWD]"
    }
    function screen () {
	command screen $*
	mkrmhmpwd ; termtitle "$HN""[$RMHMPWD]"
    }
    mkrmhmpwd ;
    termtitle "$HN""[$RMHMPWD]"
;;
esac

#PROMPT="%B%n@%m[%(?.%!.ERROR:%?)]%b%% "
#precmd() { RPROMPT="[$PWD]" }
PROMPT='%B%n@%m[%(?.%!.ERROR:%?)]%b%(!.#.$) '
RPROMPT='[%~]'
#PROMPT="[%(?.%!.ERROR:%?)]%b%% "
#precmd() { RPROMPT="[$PWD]" }

#-----------------------------------------------------------------
# シェル変数設定
#-----------------------------------------------------------------
#
# シェルの基本的な動作を変更するスイッチは、ほぼシステム非依存。
# 基本的なシェル変数と動作設定は以下の通り。
# 
setopt  always_last_prompt      # 無駄なスクロールを避ける
setopt  append_history          # ヒストリファイルに追加
#setopt  auto_list               # 自動的に候補一覧を表示
#setopt  auto_menu               # 自動的にメニュー補完する
#setopt auto_name_dirs          # "~$var" でディレクトリにアクセス
setopt  auto_param_keys         # 変数名を補完する
setopt  auto_remove_slash       # 接尾辞を削除する
#setopt  bang_hist                       # csh スタイルのヒストリ置換
setopt  brace_ccl                       # {a-za-z} をブレース展開
#setopt  cdable_vars                     # 先頭に "~" を付けたもので展開
#setopt  complete_in_word        # 語の途中でもカーソル位置で補完
setopt  complete_aliases        # 補完動作の解釈前にエイリアス展開
setopt  extended_glob           # "#", "~", "^" を正規表現として扱う
#setopt  extended_history        # 開始/終了タイムスタンプを書き込み
#setopt hist_verify                     # ヒストリ置換を実行前に表示
setopt glob_dots                       # "*" にドットファイルをマッチ
setopt  hist_ignore_dups        # 直前のヒストリと全く同じとき無視
setopt  hist_ignore_space       # 先頭がスペースで始まるとき無視
setopt  list_types                      # ファイル種別を表す記号を末尾に表示
setopt  magic_equal_subst       # "val=expr" でファイル名展開
#setopt menu_complete           # 一覧表示せずに、すぐに最初の候補を補完
setopt  multios                         # 複数のリダイレクトやパイプに対応
#setopt  numeric_glob_sort       # ファイル名を数値的にソート
#setopt  noclobber                       # リダイレクトで上書き禁止
#setopt no_beep                         # ベルを鳴らさない
#setopt no_check_jobs           # シェル終了時にジョブをチェックしない
setopt  no_flow_control         # C-s/C-q によるフロー制御をしない
#setopt  no_hup                          # 走行中のジョブにシグナルを送らない
#setopt  no_list_beep            # 補完の時にベルを鳴らさない
#setopt  notify                          # ジョブの状態をただちに知らせる
setopt  prompt_subst            # プロンプト内で変数展開
setopt  pushd_ignore_dups       # 重複するディレクトリを無視
setopt  rm_star_silent          # "rm * " を実行する前に確認
#setopt  sun_keyboard_hack       # 行末の "` (バッククウォート)" を無視
#setopt  sh_word_split           # 変数内の文字列分解のデリミタ
#setopt  histallowclobber        # ">" を ">!" としてヒストリ保存
#setopt  printeightbit           # 8ビットクリーン表示→うまく動作せず
#setopt  share_history
#setopt autopushd
setopt nonomatch

#-----------------------------------------------------------------
# エイリアス設定
#-----------------------------------------------------------------
#
# UNIX コマンドと Windows 固有のシステムコマンドと区別するために
# 絶対パス指定したり、よく使うコマンドに短い別名を登録したりとか。
# 引数をとるエイリアスは、簡易関数で定義する必要がある点に注意。
#
# tcsh% alias m "mule !* &" → zsh%  m() { mule $* & }
# 
# ls で色をつける
eval $(dircolors ~/lib/dircolors/dircolors.ansi-light)
LS_OPTIONS='-F --color=auto'

alias ls="ls $LS_OPTIONS"
alias dir="dir $LS_OPTIONS"
alias vdir="vdir $LS_OPTIONS"
alias la='ls -a'
alias ll='ls -lF'
alias h='history 20'
alias more='less'
#alias which='type -path'
alias rehash='hash -r'
#alias rmdir='rm -rf'
alias s=source
alias x=start
alias j=jobs
alias reload="source ~/.zshrc"
#alias gd='dirs -v; echo -n "select number: "; read newdir; cd -"$newdir"'
#alias screen="screen -U"
alias hd=hexdump
alias secon='umask 027'
alias secoff='umask 022'
alias cleanup="rm -rf ~/Downloads/* ~/tmp/empty/*"

#-----------------------------------------------------------------
# キーバインド設定
#-----------------------------------------------------------------
#
# ほぼシステム非依存なので、特に変更する必要なし。
#
bindkey -e

# 単語（空白文字で区切られているもの）に対する補完
typeset -A word_abbrev
word_abbrev=(
    $word_abbrev_local
	"tar"	"czvf"
	"le"	"| $PAGER"
	"lg"	"| grep"
	"lw"	"| wc"
	"lh"	"| head"
	"lt"	"| tail"
	"work"	"~/Documents/work"
	"proj"	"~/Documents/work/project"
	"eproj"	"~/Documents/work/external_project"
)

# パイプに対する補完
typeset -A pipe_abbrev
pipe_abbrev=(
	"l"	"$PAGER"
	"g"	"grep"
	"s"	"sort"
	"w"	"wc"
	"h"	"head"
	"t"	"tail"
)

# 単語略語展開
expand-word-abbrev()
{
	local left right abbrev
	# 最後の単語
	right=$(echo -nE "$LBUFFER" | sed -e 's/.*[[:space:]]\([^[:space:]]*\)$/\1/')
	abbrev=$word_abbrev[$right]
	
	if [ -z "$abbrev" ] ; then
		return 1
	fi

	# 残り
	left=$(echo -nE "$LBUFFER" | sed -e 's/[^[:space:]]*$//')
	LBUFFER=$left$abbrev" "
	return 0
}

# パイプ略語展開
expand-pipe-abbrev()
{
	local left right abbrev
	# 最後の | 以降を取得
	right=$(echo -nE "$LBUFFER" | sed -e 's/.*|\([^|]*\)$/\1/')
	abbrev=$pipe_abbrev[$right]
	
	if [ -z "$abbrev" ] ; then
		return 1
	fi

	# 残り
	left=$(echo -nE "$LBUFFER" | sed -e 's/[^|]*$//')
	LBUFFER=$left" "$abbrev" "
	return 0
}

# 略語展開 || complete-word
expand-my-abbrev-or-complete()
{
	expand-pipe-abbrev || expand-word-abbrev || zle complete-word
}

zle -N expand-my-abbrev-or-complete
bindkey "^I" expand-my-abbrev-or-complete

#-----------------------------------------------------------------
# 補完ルール設定
#-----------------------------------------------------------------
# 
# 必要に応じて追加すると良い。基本的な設定は以下の通り。
#
autoload -U compinit
compinit -C

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

zstyle ':completion:*:processes' command 'ps x'

# 補完候補にも色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# dabbrev
HARDCOPYFILE=$HOME/tmp/screen-hardcopy
touch $HARDCOPYFILE

dabbrev-complete () {
        local reply lines=80 # 80行分
        screen -X hardcopy -h $HARDCOPYFILE
        reply=($(sed '/^$/d' $HARDCOPYFILE | sed '$ d' | tail -$lines))
        compadd - "${reply[@]%[*/=@|]}"
}

zle -C dabbrev-complete menu-complete dabbrev-complete
bindkey '^o' dabbrev-complete
bindkey '^o^/' reverse-menu-complete

#__git_files() { _files }

#-----------------------------------------------------------------
# 補完ルール設定
#-----------------------------------------------------------------

#-----------------------------------------------------------------
# システム別設定
#-----------------------------------------------------------------


# 端末をクリアして終了
#builtin cls
# end of ~/.zshrc
#=================================================================
