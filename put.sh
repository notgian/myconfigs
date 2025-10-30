# This script can be used to interactively put the configs in the folders.
# Take note that this script must be updated if any new configs are added.

source ./parse_configs.sh

# local_folders=()
# config_defaults=()
# config_default_location="$HOME/.config"
# declare -A config_files_custom

function put_defaults() {
    echo "Putting configs that belong in the default config location ($config_default_location)"
    cwd=${ pwd; }

    [[ ! -d ".backups" ]] && mkdir ".backups"

    for name in "$@"; do 
        if [[ -d $name ]]; then
            echo "backing up $name config..."
            
            echo "- copying $name config to $config_default_location/$name"
            cp -r "$name" "$default_config_location"
        else
            echo "- WARNING: local folder $cwd/$name cannot be found. Skipping this config..."
        fi
    done
}

put_defaults ${config_defaults[@]}
