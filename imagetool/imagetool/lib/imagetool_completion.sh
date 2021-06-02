#!/usr/bin/env bash
#
# imagetool Bash Completion
# =======================
#
# Bash completion support for the `imagetool` command,
# generated by [picocli](http://picocli.info/) version 4.3.2.
#
# Installation
# ------------
#
# 1. Source all completion scripts in your .bash_profile
#
#   cd $YOUR_APP_HOME/bin
#   for f in $(find . -name "*_completion"); do line=". $(pwd)/$f"; grep "$line" ~/.bash_profile || echo "$line" >> ~/.bash_profile; done
#
# 2. Open a new bash console, and type `imagetool [TAB][TAB]`
#
# 1a. Alternatively, if you have [bash-completion](https://github.com/scop/bash-completion) installed:
#     Place this file in a `bash-completion.d` folder:
#
#   * /etc/bash-completion.d
#   * /usr/local/etc/bash-completion.d
#   * ~/bash-completion.d
#
# Documentation
# -------------
# The script is called by bash whenever [TAB] or [TAB][TAB] is pressed after
# 'imagetool (..)'. By reading entered command line parameters,
# it determines possible bash completions and writes them to the COMPREPLY variable.
# Bash then completes the user input if only one entry is listed in the variable or
# shows the options if more than one is listed in COMPREPLY.
#
# References
# ----------
# [1] http://stackoverflow.com/a/12495480/1440785
# [2] http://tiswww.case.edu/php/chet/bash/FAQ
# [3] https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
# [4] http://zsh.sourceforge.net/Doc/Release/Options.html#index-COMPLETE_005fALIASES
# [5] https://stackoverflow.com/questions/17042057/bash-check-element-in-array-for-elements-in-another-array/17042655#17042655
# [6] https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion.html#Programmable-Completion
# [7] https://stackoverflow.com/questions/3249432/can-a-bash-tab-completion-script-be-used-in-zsh/27853970#27853970
#

if [ -n "$BASH_VERSION" ]; then
  # Enable programmable completion facilities when using bash (see [3])
  shopt -s progcomp
elif [ -n "$ZSH_VERSION" ]; then
  # Make alias a distinct command for completion purposes when using zsh (see [4])
  setopt COMPLETE_ALIASES
  alias compopt=complete

  # Enable bash completion in zsh (see [7])
  autoload -U +X compinit && compinit
  autoload -U +X bashcompinit && bashcompinit
fi

# CompWordsContainsArray takes an array and then checks
# if all elements of this array are in the global COMP_WORDS array.
#
# Returns zero (no error) if all elements of the array are in the COMP_WORDS array,
# otherwise returns 1 (error).
function CompWordsContainsArray() {
  declare -a localArray
  localArray=("$@")
  local findme
  for findme in "${localArray[@]}"; do
    if ElementNotInCompWords "$findme"; then return 1; fi
  done
  return 0
}
function ElementNotInCompWords() {
  local findme="$1"
  local element
  for element in "${COMP_WORDS[@]}"; do
    if [[ "$findme" = "$element" ]]; then return 1; fi
  done
  return 0
}

# The `currentPositionalIndex` function calculates the index of the current positional parameter.
#
# currentPositionalIndex takes three parameters:
# the command name,
# a space-separated string with the names of options that take a parameter, and
# a space-separated string with the names of boolean options (that don't take any params).
# When done, this function echos the current positional index to std_out.
#
# Example usage:
# local currIndex=$(currentPositionalIndex "mysubcommand" "$ARG_OPTS" "$FLAG_OPTS")
function currentPositionalIndex() {
  local commandName="$1"
  local optionsWithArgs="$2"
  local booleanOptions="$3"
  local previousWord
  local result=0

  for i in $(seq $((COMP_CWORD - 1)) -1 0); do
    previousWord=${COMP_WORDS[i]}
    if [ "${previousWord}" = "$commandName" ]; then
      break
    fi
    if [[ "${optionsWithArgs}" =~ ${previousWord} ]]; then
      ((result-=2)) # Arg option and its value not counted as positional param
    elif [[ "${booleanOptions}" =~ ${previousWord} ]]; then
      ((result-=1)) # Flag option itself not counted as positional param
    fi
    ((result++))
  done
  echo "$result"
}

# Bash completion entry point function.
# _complete_imagetool finds which commands and subcommands have been specified
# on the command line and delegates to the appropriate function
# to generate possible options and subcommands for the last specified subcommand.
function _complete_imagetool() {
  local cmds0=(cache)
  local cmds1=(create)
  local cmds2=(update)
  local cmds3=(rebase)
  local cmds4=(inspect)
  local cmds5=(help)
  local cmds6=(cache listItems)
  local cmds7=(cache addInstaller)
  local cmds8=(cache addPatch)
  local cmds9=(cache addEntry)
  local cmds10=(cache deleteEntry)
  local cmds11=(cache help)

  if CompWordsContainsArray "${cmds11[@]}"; then _picocli_imagetool_cache_help; return $?; fi
  if CompWordsContainsArray "${cmds10[@]}"; then _picocli_imagetool_cache_deleteEntry; return $?; fi
  if CompWordsContainsArray "${cmds9[@]}"; then _picocli_imagetool_cache_addEntry; return $?; fi
  if CompWordsContainsArray "${cmds8[@]}"; then _picocli_imagetool_cache_addPatch; return $?; fi
  if CompWordsContainsArray "${cmds7[@]}"; then _picocli_imagetool_cache_addInstaller; return $?; fi
  if CompWordsContainsArray "${cmds6[@]}"; then _picocli_imagetool_cache_listItems; return $?; fi
  if CompWordsContainsArray "${cmds5[@]}"; then _picocli_imagetool_help; return $?; fi
  if CompWordsContainsArray "${cmds4[@]}"; then _picocli_imagetool_inspect; return $?; fi
  if CompWordsContainsArray "${cmds3[@]}"; then _picocli_imagetool_rebase; return $?; fi
  if CompWordsContainsArray "${cmds2[@]}"; then _picocli_imagetool_update; return $?; fi
  if CompWordsContainsArray "${cmds1[@]}"; then _picocli_imagetool_create; return $?; fi
  if CompWordsContainsArray "${cmds0[@]}"; then _picocli_imagetool_cache; return $?; fi

  # No subcommands were specified; generate completions for the top-level command.
  _picocli_imagetool; return $?;
}

# Generates completions for the options and subcommands of the `imagetool` command.
function _picocli_imagetool() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}

  local commands="cache create update rebase inspect help"
  local flag_opts="-h --help -V --version"
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `cache` subcommand.
function _picocli_imagetool_cache() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}

  local commands="listItems addInstaller addPatch addEntry deleteEntry help"
  local flag_opts=""
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `create` subcommand.
function _picocli_imagetool_create() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="--skipcleanup --dryRun --latestPSU --recommendedPatches --strictPatchOrdering --pull --skipOpatchUpdate --wdtRunRCU --wdtModelOnly --wdtStrictValidation"
  local arg_opts="--tag --user --password --passwordEnv --passwordFile --httpProxyUrl --httpsProxyUrl --docker --chown --additionalBuildCommands --additionalBuildFiles --patches --opatchBugNumber --buildNetwork --packageManager --builder -b --type --version --jdkVersion --fromImage --installerResponseFile --inventoryPointerFile --inventoryPointerInstallLoc --wdtModel --wdtArchive --wdtVariables --wdtVersion --wdtDomainType --wdtDomainHome --wdtJavaOptions --wdtModelHome --wdtEncryptionKey --wdtEncryptionKeyEnv --wdtEncryptionKeyFile --resourceTemplates"
  local packageManager_option_args="OS_DEFAULT NONE YUM DNF MICRODNF APTGET APK ZYPPER" # --packageManager values
  local installerType_option_args="WLS WLSSLIM WLSDEV FMW OSB SOA SOA_OSB SOA_OSB_B2B IDM IDM_WLS OAM OIG OUD OUD_WLS WCC WCP WCS" # --type values

  compopt +o default

  case ${prev_word} in
    --tag)
      return
      ;;
    --user)
      return
      ;;
    --password)
      return
      ;;
    --passwordEnv)
      return
      ;;
    --passwordFile)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --httpProxyUrl)
      return
      ;;
    --httpsProxyUrl)
      return
      ;;
    --docker)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --chown)
      return
      ;;
    --additionalBuildCommands)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --additionalBuildFiles)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --patches)
      return
      ;;
    --opatchBugNumber)
      return
      ;;
    --buildNetwork)
      return
      ;;
    --packageManager)
      COMPREPLY=( $( compgen -W "${packageManager_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --builder|-b)
      return
      ;;
    --type)
      COMPREPLY=( $( compgen -W "${installerType_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --version)
      return
      ;;
    --jdkVersion)
      return
      ;;
    --fromImage)
      return
      ;;
    --installerResponseFile)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --inventoryPointerFile)
      return
      ;;
    --inventoryPointerInstallLoc)
      return
      ;;
    --wdtModel)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --wdtArchive)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --wdtVariables)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --wdtVersion)
      return
      ;;
    --wdtDomainType)
      return
      ;;
    --wdtDomainHome)
      return
      ;;
    --wdtJavaOptions)
      return
      ;;
    --wdtModelHome)
      return
      ;;
    --wdtEncryptionKey)
      return
      ;;
    --wdtEncryptionKeyEnv)
      return
      ;;
    --wdtEncryptionKeyFile)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --resourceTemplates)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `update` subcommand.
function _picocli_imagetool_update() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="--skipcleanup --dryRun --latestPSU --recommendedPatches --strictPatchOrdering --pull --skipOpatchUpdate --wdtRunRCU --wdtModelOnly --wdtStrictValidation"
  local arg_opts="--tag --user --password --passwordEnv --passwordFile --httpProxyUrl --httpsProxyUrl --docker --chown --additionalBuildCommands --additionalBuildFiles --patches --opatchBugNumber --buildNetwork --packageManager --builder -b --fromImage --wdtOperation --wdtModel --wdtArchive --wdtVariables --wdtVersion --wdtDomainType --wdtDomainHome --wdtJavaOptions --wdtModelHome --wdtEncryptionKey --wdtEncryptionKeyEnv --wdtEncryptionKeyFile --resourceTemplates"
  local packageManager_option_args="OS_DEFAULT NONE YUM DNF MICRODNF APTGET APK ZYPPER" # --packageManager values
  local wdtOperation_option_args="CREATE UPDATE DEPLOY" # --wdtOperation values

  compopt +o default

  case ${prev_word} in
    --tag)
      return
      ;;
    --user)
      return
      ;;
    --password)
      return
      ;;
    --passwordEnv)
      return
      ;;
    --passwordFile)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --httpProxyUrl)
      return
      ;;
    --httpsProxyUrl)
      return
      ;;
    --docker)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --chown)
      return
      ;;
    --additionalBuildCommands)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --additionalBuildFiles)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --patches)
      return
      ;;
    --opatchBugNumber)
      return
      ;;
    --buildNetwork)
      return
      ;;
    --packageManager)
      COMPREPLY=( $( compgen -W "${packageManager_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --builder|-b)
      return
      ;;
    --fromImage)
      return
      ;;
    --wdtOperation)
      COMPREPLY=( $( compgen -W "${wdtOperation_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --wdtModel)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --wdtArchive)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --wdtVariables)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --wdtVersion)
      return
      ;;
    --wdtDomainType)
      return
      ;;
    --wdtDomainHome)
      return
      ;;
    --wdtJavaOptions)
      return
      ;;
    --wdtModelHome)
      return
      ;;
    --wdtEncryptionKey)
      return
      ;;
    --wdtEncryptionKeyEnv)
      return
      ;;
    --wdtEncryptionKeyFile)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --resourceTemplates)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `rebase` subcommand.
function _picocli_imagetool_rebase() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="--skipcleanup --dryRun --latestPSU --recommendedPatches --strictPatchOrdering --pull --skipOpatchUpdate"
  local arg_opts="--tag --user --password --passwordEnv --passwordFile --httpProxyUrl --httpsProxyUrl --docker --chown --additionalBuildCommands --additionalBuildFiles --patches --opatchBugNumber --buildNetwork --packageManager --builder -b --type --version --jdkVersion --sourceImage --targetImage --installerResponseFile --fromImage --inventoryPointerFile --inventoryPointerInstallLoc"
  local packageManager_option_args="OS_DEFAULT NONE YUM DNF MICRODNF APTGET APK ZYPPER" # --packageManager values
  local installerType_option_args="WLS WLSSLIM WLSDEV FMW OSB SOA SOA_OSB SOA_OSB_B2B IDM IDM_WLS OAM OIG OUD OUD_WLS WCC WCP WCS" # --type values

  compopt +o default

  case ${prev_word} in
    --tag)
      return
      ;;
    --user)
      return
      ;;
    --password)
      return
      ;;
    --passwordEnv)
      return
      ;;
    --passwordFile)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --httpProxyUrl)
      return
      ;;
    --httpsProxyUrl)
      return
      ;;
    --docker)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --chown)
      return
      ;;
    --additionalBuildCommands)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --additionalBuildFiles)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --patches)
      return
      ;;
    --opatchBugNumber)
      return
      ;;
    --buildNetwork)
      return
      ;;
    --packageManager)
      COMPREPLY=( $( compgen -W "${packageManager_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --builder|-b)
      return
      ;;
    --type)
      COMPREPLY=( $( compgen -W "${installerType_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --version)
      return
      ;;
    --jdkVersion)
      return
      ;;
    --sourceImage)
      return
      ;;
    --targetImage)
      return
      ;;
    --installerResponseFile)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --fromImage)
      return
      ;;
    --inventoryPointerFile)
      return
      ;;
    --inventoryPointerInstallLoc)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `inspect` subcommand.
function _picocli_imagetool_inspect() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="--patches"
  local arg_opts="--image -i --builder -b --format"
  local FORMAT_option_args="JSON" # --format values

  compopt +o default

  case ${prev_word} in
    --image|-i)
      return
      ;;
    --builder|-b)
      return
      ;;
    --format)
      COMPREPLY=( $( compgen -W "${FORMAT_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `help` subcommand.
function _picocli_imagetool_help() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}

  local commands="cache create update rebase inspect"
  local flag_opts="-h --help"
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `listItems` subcommand.
function _picocli_imagetool_cache_listItems() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts=""
  local arg_opts="--key"

  compopt +o default

  case ${prev_word} in
    --key)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `addInstaller` subcommand.
function _picocli_imagetool_cache_addInstaller() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="--force"
  local arg_opts="--path --type --version"
  local type_option_args="wlsdev wlsslim wls fmw soa osb b2b idm oam oud wcc wcp wcs jdk wdt" # --type values

  compopt +o default

  case ${prev_word} in
    --path)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --type)
      COMPREPLY=( $( compgen -W "${type_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --version)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `addPatch` subcommand.
function _picocli_imagetool_cache_addPatch() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="--force"
  local arg_opts="--path --patchId"

  compopt +o default

  case ${prev_word} in
    --path)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --patchId)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `addEntry` subcommand.
function _picocli_imagetool_cache_addEntry() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts=""
  local arg_opts="--key --value"

  compopt +o default

  case ${prev_word} in
    --key)
      return
      ;;
    --value)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `deleteEntry` subcommand.
function _picocli_imagetool_cache_deleteEntry() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts=""
  local arg_opts="--key"

  compopt +o default

  case ${prev_word} in
    --key)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `help` subcommand.
function _picocli_imagetool_cache_help() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}

  local commands="listItems addInstaller addPatch addEntry deleteEntry"
  local flag_opts="-h --help"
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Define a completion specification (a compspec) for the
# `imagetool`, `imagetool.sh`, and `imagetool.bash` commands.
# Uses the bash `complete` builtin (see [6]) to specify that shell function
# `_complete_imagetool` is responsible for generating possible completions for the
# current word on the command line.
# The `-o default` option means that if the function generated no matches, the
# default Bash completions and the Readline default filename completions are performed.
complete -F _complete_imagetool -o default imagetool imagetool.sh imagetool.bash