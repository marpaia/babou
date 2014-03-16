#export PYTHONPATH="/usr/local/lib/python3.3/site-packages/:$PYTHONPATH"
export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python3"
source "/usr/local/bin/virtualenvwrapper.sh"
alias mkenv='mkvirtualenv `basename $PWD` && setvirtualenvproject && add2virtualenv app'
alias va='virtualenv'
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
