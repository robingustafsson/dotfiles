if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

# Load source files in ~/.bash
for file in ~/.bash/{aliases,completions,config,paths,functions,prompt}; do
    [ -r "$file" ] && source "$file"
done
unset file
