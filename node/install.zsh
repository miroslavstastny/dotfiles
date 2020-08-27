# Check for node
if [[ ! -a $(which node) ]]
then
  echo "  Installing node for you."
  nvm install stable
fi
