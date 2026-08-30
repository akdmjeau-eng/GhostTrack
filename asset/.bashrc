cat << 'EOF' > ~/.bashrc
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Variables de entorno
export NEXMON_ROOT=$HOME/nexmon
export PATH=$NEXMON_ROOT/buildtools/arm-none-eabi-gcc/bin:$PATH

# Control de Historial
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Ajuste de ventana y coincidencia de patrones
shopt -s checkwinsize

# Visualización de almacenamiento al iniciar
df -h
du -h -d 1 "$HOME" 2>/dev/null | sort -h

# Color prompt (Red theme)
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes

if [ "$color_prompt" = yes ]; then
    VIRTUAL_ENV_DISABLE_PROMPT=1

    # Prompt Rojo
    prompt_color='\[\033[1;31m\]'
    info_color='\[\033[1;31m\]'
    prompt_symbol=㉿

    case "$PROMPT_ALTERNATIVE" in
        twoline)
            PS1=$prompt_color'┌──${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'$prompt_color')}('$info_color'\u'$prompt_symbol'\h'$prompt_color')-[\[\033[0;1m\]\w'$prompt_color']\n'$prompt_color'└─'$info_color'\$\[\033[0m\] ';;
        oneline)
            PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}'$info_color'\u@\h\[\033[00m\]:'$prompt_color'\[\033[01m\]\w\[\033[00m\]\$ ';;
        backtrack)
            PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ';;
    esac
    unset prompt_color
    unset info_color
    unset prompt_symbol
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

[ "$NEWLINE_BEFORE_PROMPT" = yes ] && PROMPT_COMMAND="PROMPT_COMMAND=echo"

# Soporte de colores para utilidades de lectura/listado
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:"

    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'
fi

# Aliases estándar
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# --- FUNCIONES DE TRABAJO (Ejecutar bajo demanda) ---

# Función para compilar el parche de Nexmon
build_nexmon() {
    local patch_dir="$NEXMON_ROOT/patches/bcm43438/7_19_7_2/nexmon_debugger"
    if [ -d "$patch_dir" ]; then
        cd "$patch_dir" && make clean && make
    else
        echo "[!] El directorio $patch_dir no existe."
    fi
}

# Función para copiar rish desde almacenamiento de Android
import_rish() {
    if [ -f /sdcard/Download/rish ]; then
        cp /sdcard/Download/rish* ~/ && chmod +x ~/rish
        echo "[+] rish copiado e instalado en ~/"
    else
        echo "[!] No se encontró rish en /sdcard/Download/"
    fi
}

# Función para iniciar Transition Player mediante ADB
run_transition_player() {
    adb shell app_process '-Djava.class.path=$(pm path top.canyie.transitionplayer | cut -c9-) /system/bin top.canyie.transitionplayer.Main'
}

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
EOF
