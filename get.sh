#!/bin/bash

source ./parse_configs.sh

# =================================
#           Script proper
# =================================

# Remakes the folders in the local directory.
# Serves to clean up the old files and replace them with the new ones.
# Takes $local_folders
function remake_folders() {
    echo "Remaking the following folders:"
    for folder in "$@"; do
        echo "  - $folder"
    done

    for folder in "$@"; do
        if [[ -d $folder ]]; then
            yes | rm -r $folder
        fi
        mkdir $folder
    done
    echo "Finished remaking folders!"
    echo ""
}

# Gets the configs from the default ~/.config directory. 
# Takes $config_defaults
# Assumed that the folders have been remade and local folder
# names are the same as the ones in the ~./config directory.
function get_default_configs() {
    for folder in "$@"; do 
        local config_folder="$HOME/.config/$folder" 
        if [[ -d $config_folder ]]; then
            echo "  - copying config files from $config_folder..." 
            cp -r $config_folder/* "$folder"
        else    
            echo "  - WARNING: $config_folder is not a directory!"
        fi
    done
    echo "" 
}

# Manually obtains the config files using an associative array
# Defined at the start of the script.
# Takes config_files (as a reference)
function get_manual_configs() {
    local -n config_files_ref=$1
    for key in ${!config_files_ref[@]}; do 
        local files=${config_files_ref[$key]}
        local local_dir="./$key"

        # using semicolon as separator to get each file
        local temp_ifs=$IFS
        IFS=";"
        for file in ${files[@]}; do
            if [[ -d $file ]]; then
                echo "  - $key: copying folder $file..."
                cp -r $file $local_dir
            elif [[ -f $file ]]; then
                echo "  - $key: copying file $file..."
                cp $file $local_dir
            else 
                echo "  - $key: file or folder $file does not exist..."
            fi
        done
        IFS=$temp_ifs
    done
    echo ""
}

# Running the functions in order.

remake_folders ${local_folders[@]}
#
# echo "Getting configs from default config directory ~/.config" 
# get_default_configs ${config_defaults[@]}
#
echo "Getting other configs manually..."
get_manual_configs config_files_custom
