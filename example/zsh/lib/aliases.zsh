# List direcory contents
alias l='ls'
alias la='ls -A'
alias ll='ls -l'
alias lla='ls -lAh'
alias lal='ls -lAh'
alias sl=ls

# Applications
alias chrome="open /Applications/Google\ Chrome.app/"
alias twitter="open /Applications/Tweetbot.app/"
alias firefox="open /Applications/Firefox.app/"
alias mail="open /Applications/Mail.app/"
alias cal="open /Applications/iCal.app/"
alias ical="open /Applications/iCal.app/"
alias lock="/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine"
alias burp="nohup java -jar -Xmx1g ~/Tools/burp.jar > /dev/null&"

# Commands
alias cls="clear"
alias mak="make"

# Python
alias pythong="python"
alias pytho="python"
alias p="ipython"
alias i="ipython"
alias ip="ipython"

# Finder
alias showall="defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder"
alias hideall="defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder"

# Chef
alias ksb="knife spork bump"
alias ksu="knife spork upload"
alias ksp="knife spork promote"
alias role="knife role from file"

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias ...='cd ../..'
alias -- -='cd -'
alias chef="cd ~/github/chef-osx/; ls"

# Super user
alias _='sudo'
alias please='sudo'

# Show history
alias history='fc -l 1'
