{ writeScriptBin, bash }:

writeScriptBin "draw-in-palette" ''
  #!${bash}/bin/bash

  text="''${@:-今後の履歴の変更}"

  echo "light0 + gray"
  echo -en "\e[38;5;0m";  echo -n $text
  echo -e "\e[39m"
  echo -en "\e[38;5;8m";  echo -n $text
  echo -e "\e[39m"

  echo "neutral_red + faded_red"
  echo -en "\e[38;5;1m";  echo -n $text
  echo -e "\e[39m"
  echo -en "\e[38;5;9m";  echo -n $text
  echo -e "\e[39m"

  echo "neutral_green + faded_green"
  echo -en "\e[38;5;2m";  echo -n $text
  echo -e "\e[39m"
  echo -en "\e[38;5;10m"; echo -n $text
  echo -e "\e[39m"

  echo "neutral_yellow + faded_yellow"
  echo -en "\e[38;5;3m";  echo -n $text
  echo -e "\e[39m"
  echo -en "\e[38;5;11m"; echo -n $text
  echo -e "\e[39m"

  echo "neutral_blue + faded_blue"
  echo -en "\e[38;5;4m";  echo -n $text
  echo -e "\e[39m"
  echo -en "\e[38;5;12m"; echo -n $text
  echo -e "\e[39m"

  echo "neutral_purple + faded_purple"
  echo -en "\e[38;5;5m";  echo -n $text
  echo -e "\e[39m"
  echo -en "\e[38;5;13m"; echo -n $text
  echo -e "\e[39m"

  echo "neutral_aqua + faded_aqua"
  echo -en "\e[38;5;6m";  echo -n $text
  echo -e "\e[39m"
  echo -en "\e[38;5;14m"; echo -n $text
  echo -e "\e[39m"

  echo "dark4 + dark1"
  echo -en "\e[38;5;7m";  echo -n $text
  echo -e "\e[39m"
  echo -en "\e[38;5;15m"; echo -n $text
  echo -e "\e[39m"

  exit 0
''
