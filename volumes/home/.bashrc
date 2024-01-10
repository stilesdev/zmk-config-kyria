export LS_OPTIONS='-F --color=auto'
alias ls='ls $LS_OPTIONS'
alias ll='ll -lah'

if [ -f "/workspaces/zmk/zephyr/zephyr-env.sh" ]; then
  source "/workspaces/zmk/zephyr/zephyr-env.sh"
fi

if [ -d "/workspaces/zmk/tools/bsim" ]; then
  export BSIM_OUT_PATH="/workspaces/zmk/tools/bsim/"
  export BSIM_COMPONENTS_PATH="/workspaces/zmk/tools/bsim/components/"
fi
