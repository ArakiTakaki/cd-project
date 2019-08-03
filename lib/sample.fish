#!/usr/local/bin/fish
set FILE_ROOT $HOME"/.config/sample.z"
set TMP $HOME"/.config/sample.tmpl.z"

echo $argv | awk '{ print $1 }' | read PARAM
switch (echo $PARAM)
# ADD COMMAND
case add
  echo $argv | awk '{ print $2 }' | read label
  echo $label
  if test $label
  else
    set -x label 'NOT_LABEL'
  end
  echo "LABEL:$label  dir $PWD" >> $FILE_ROOT

# DELETE COMMAND
case delete
  cat $FILE_ROOT | grep --line-number $PWD | cut -b 1 | awk '{ print $1"d" }' | read line
  sed "$line" $FILE_ROOT > $TMP
  cat $TMP > $FILE_ROOT
  rm $TMP

# CD COMMAND
case '*'
  cat $FILE_ROOT | peco | awk '{ print $3 }' | read position
  cd $position
  ls
end