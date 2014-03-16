#
# Color grep results
# Examples: http://rubyurl.com/ZXv
#
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

gg(){ eval 'grep -irnI --color "'"$@"'" ./ 2> /dev/null'; }
