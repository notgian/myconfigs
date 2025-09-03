# config.nu
#
# Installed by:
# version = "0.106.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

# adding homebrew paths manually because idk nu shell doesn't have them

$env.Path = ($env.Path | prepend "/home/linuxbrew/.linuxbrew/bin/")
$env.Path = ($env.Path | prepend "/home/linuxbrew/.linuxbrew/sbin")

# nu shell custom options

$env.config.edit_mode = "vi"

# my command aliases
alias nv = nvim

alias cdcode = cd '/home/notgian/Documents/Coding Projs Linux'
alias cdschool = cd '/var/home/notgian/Nextcloud/School Files/'
alias cdcloud = cd '/var/home/notgian/Nextcloud/'
