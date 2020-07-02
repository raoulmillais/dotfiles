#!/usr/bin/env bash

#
# Prelude - make bash behave sanely
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
#
set -Eeuo pipefail
IFS=$'\n\t'

# Beware of CDPATH gotchas causing cd not to work correctly when a user has
# set this in their environment
# https://bosker.wordpress.com/2012/02/12/bash-scripters-beware-of-the-cdpath/
unset CDPATH

main() {
  local REPO_DIR="${1}"
	pushd "${REPO_DIR}"

	if [[ -n "$(git status -s)" ]]; then
	  git add -A
    git commit --no-gpg-sign -nm "Autocommited $(date -u)"
    git push origin master
  fi
	popd
}

die() {
  local msg="$*"
  if [[ -t 2 ]] ; then
    [[ -z "${msg}" ]] || {
      tput setaf 1  # red
      tput bold
      echo "${msg}" 1>&2
      tput sgr0     # reset
    }
  else
    echo "${msg}" 1>&2
  fi

  exit 1
}
readonly -f die

exit_if_not_git_repo() {
  local gitroot
  gitroot="$(git rev-parse --show-toplevel 2> /dev/null)"

  [[ "${gitroot}" == "" ]] && die 'Current directory is not in a repository'
  return 0
}
readonly -f exit_if_not_git_repo

main "$@"
