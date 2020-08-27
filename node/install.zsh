# Check for node
if [[ ! -d /Users/mistastn/.nvm/versions/node ]]
then
  echo "  Installing node for you."
  nvm install stable
fi

