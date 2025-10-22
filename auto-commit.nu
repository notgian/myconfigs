#!/usr/bin/env nu

def remove_path [target: string] { if ( $target | path exists) {
        rm -r $target
    }
}

# individually handle each one since it may differ from one to another

# nvim
print "Getting neovim configuration files..."
let nvconfig_path = $"($env.HOME)/.config/nvim"
remove_path nvim 
mkdir nvim
cp -r $"($nvconfig_path)/after" ./nvim
cp -r $"($nvconfig_path)/lsp" ./nvim
cp -r $"($nvconfig_path)/lua" ./nvim
cp -r $"($nvconfig_path)/init.lua" ./nvim/

# nushell
print "Getting nushell configuration files..."
let nuconfig_path =  $"($env.HOME)/.config/nushell"
remove_path nushell
mkdir nushell
cp -r $"($nuconfig_path)/config.nu" ./nushell

# tmux
print "Getting tmux configuration file..."
remove_path tmux
mkdir tmux
cp $"($env.HOME)/.tmux.conf" ./tmux/.tmux.conf


print "Successfully copied all config files!"
print "\nCreate a new commit for the files? [N/y]"
let make_commit = (input -n 1)

if ($make_commit != "y" and $make_commit != "Y") {
   print "Not creating a commit! Stopping script..."
   exit
}

print "Creating a new commit..."
print "\nPlease enter a commit message. Press enter for default commit message."
let message = (input --default "automated dev commit")

git add .
git commit -m $message

print "\nCommit successful! Attempt to push to GitHub? [N/y]"
let attempt_push = (input -n 1)

if ($attempt_push != "y" and $attempt_push != "Y") {
    print "Not pushing to GitHub! Stopping script..."
}

git push

