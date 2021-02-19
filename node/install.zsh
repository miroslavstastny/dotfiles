# Check for node
if [[ ! -d ~/.nvm/versions/node ]]
then
  echo "  Installing node for you."
  nvm install stable
fi

