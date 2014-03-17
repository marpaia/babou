babou
=====

babou is a Mac OS X configuration management utility. It allows you
to express the configurations of your OS X machine via a simple JSON file
and a directory of flat files.

Simply create a directory at `~/.config` and a master config file at
`~/.config/config.json`. Populate the config file and config directory
with relevant settings and files. Run the `config` binary and off you go!

In the spirit of configuration management, `config` is also completely
idempotent. In other words, you can schedule `config` to run as often as
you want, and it will always leave your machine in the same state. If it
doesn't need to do anything to satisfy state that already exists, it won't!

Beware that this is pretty new technology. I wrote this as a weekend project
because it was something that I really wanted. I think it works well, but there
are many ways in which it can be improved. See the "Contributing" section for
more information!

## Motivation

Not so long ago, I wanted the ability to manage the configurations on my OS X
machines so I started using Opscode's Chef to manage my OS X configs. This
worked pretty well, but doing something simple like adding one file, or one brew
package, forced me to create at least one new file and modify at least one
existing file. It was a lot of work to keep up with to do something that should
be relatively straightforward. This is what I'm going to be using to manage the
configurations of my Mac.

## Examples

Before you get too deep in here, you might want to check out the `example`
directory to see what a basic `~/.config` directory would look like.

## Using `config`

By default, when you run `config`, it will look for a `~/.config` directory
as well as a `~/.config/config.json` file. The `config.json` file is where
you describe your desired configurations. Consider you had the following
`config.json` file;

```json
{
    "file_mappings": {
        "~/.vimrc": "vimrc",
        "~/.zshrc": "zshrc",
        "~/.zsh": "zsh"
    },
    "create_directories": [
        "~/devtools",
        "~/docs",
        "~/git",
        "~/go",
        "~/go/bin",
        "~/go/pkg",
        "~/go/src"
    ],
    "brew_packages": {
        "ack" : {},
        "brew-cask": {},
        "gdbm": {},
        "neo4j": {},
        "node": {},
        "percona-server": {
            "options": "--with-memcached"
        },
        "python": {},
        "python3": {},
        "wget": {}
    },
    "cask_packages": {
        "google-chrome": {},
		"dropbox": {}
    },
    "git": {
        "https://github.com/facebook/folly.git": "~/git/folly"
    },
    "defaults_write": {
        "com.apple.dock": {
            "pinning": "start"
        },
        "com.apple.TimeMachine": {
            "DoNotOfferNewDisksForBackup": true
        }
    }
}
```

### file mappings

The `file_mappings` section of the `config.json` is where you define a mapping
of files on your host to files within the `~/.config` directory. In this
example, I'm telling the `config` tool that the `~/.vimrc` on my host should
be represented by the `vimrc` file in my `~/.config` directory (so the full
path for my managed vimrc would be `~/.config/vimrc`. This also works for
directories such as your `~/.vim` directory or your `~/.zsh` directory.

### create directories

The `create__directories` list with just create directories on your
filesystem. This is really useful for your `$GOPATH` or just normal directories
that you always create.

### brew packages

The `brew_packages` section maps brew packages to a dictionary of options.
If you want your package installed with options, see the `percona-server` entry
above.

### cask packages

Cask is a CLI-workflow for managing graphical applications on your host. There's 
a ton of applications that have cask formulas and I've found it's definitely
the most reliable way to install applications in an automated fashion. The
`Cask` class and the `Brew` class both inherrit from the `Package` class
internally so they behave very similary. 

*It's worth noting that different cask packges behave in different ways. 
I said that cask is the most reliable way to automate the installation of
graphical applications via config management, but the bar was set pretty low
there.*

### git

the `git` section is a mapping of a git remote to where on your filesystem you
want it checked out. Note that `config` won't update pre-existing repositories,
it will only check out ones tha don't exist where you want them to on your
filesystem.

### defaults write

the `defaults_write` section, which is internally backed by the `Settings`
class, allows you to specifcy NSUserDefaults domains and a mapping of Key-Value
pairs that you'd like to be set in that domain. This is good for system
preferences and everything that's managed by propertly lists on your system.

## Installation

Realistically, at this point, you'll need to do the following on your system to get
Babou up and running from a fresh install:

- install the OS X command line tools (mostly for git and gcc)
- `ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" # install homebrew`
- `brew tap phinze/cask && brew install brew-cask && brew cask # install cask and run it to finish installation`
- somehow get your config files to `~/.config` (I do it via git)
- clone this repo install Xcode to build the binary or ask me for a copy
- put the `config` binary somewhere in your path
- run `config` from a terminal

## Customization

If you set a `CONFIGDIR` environment variable, `config` will look for your
`config.json` there instead of in `~/.config`.

## Dependencies

Babou has no external dependencies.

## Contributing

Please contribute and help improve this project!

- Fork the repo
- Improve the code
- Submit a pull request

## Contact

This was written, with love, by Mike Arpaia.
