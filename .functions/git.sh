# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#
#!/usr/bin/env bash

git_prompt() {
  RED=$(tput setaf 1)
  YELLOW="$(tput setaf 3)"
  GREEN="\033[0;32m"
  RESET=$(tput sgr0)
  BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')

  if [ ! -z $BRANCH ]; then
    printf "$YELLOW($BRANCH"

    if [ ! -z "$(git status --short)" ]; then
      printf " ${RED}✗"
    else
      printf " ${GREEN}✔"
    fi

    printf "${YELLOW} )\n${RESET}"
  fi
}

# Alias the git command to hub if it exists
if [ -f /usr/local/bin/hub ]
then
  alias git='hub'
fi

gitgood() {
  cd ~/source
  RED=$(tput setaf 1)
  GREEN="\033[0;32m"
  RESET=$(tput sgr0)
  for git_repo in `ls -1 -d */*`;
  do
  BRANCH=$(git --git-dir=./$git_repo/.git --work-tree=./$git_repo branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')
  printf "%-40s %-10s %-4s" "$git_repo" "$BRANCH"
  if [ ! -z "$(git --git-dir=./$git_repo/.git --work-tree=./$git_repo status --short)" ]; then
      printf " ${RED}✗"
    else
      printf " ${GREEN}✔"
    fi
  printf "\n${RESET}"
  done
  cd -
}
