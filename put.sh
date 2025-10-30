# This script can be used to interactively put the configs in the folders.

source ./parse_configs.sh

# The function that puts all the configs that belong to the default
# location, typically at ~/.config
function put_defaults() {
    echo -e "Putting configs that belong in the default config location \033[0m(\033[36m$config_default_location\033[0m)"
    cwd=${ pwd; }

    [[ ! -d ".backups" ]] && mkdir ".backups"

    for name in "$@"; do 
        if [[ -d $name ]]; then
            echo -e "\033[33mPreparing to put $name config\033[0m"
            echo -e "- backing up \033[36m $config_default_location/$name\033[0m"
            cp -r $config_default_location/$name ./.backups/

            echo -e "- copying $name config to \033[36m$config_default_location"
            echo -e "  \033[33mIs this correct? [y/n]"

            valid_inp=false
            correct=true
            until [[ $valid_inp == true ]]; do
                read -n 1 inp
                [[ $inp == "Y" || $inp == "y" ]] && valid_inp=true && correct=true
                [[ $inp == "N" || $inp == "n" ]] && valid_inp=true && correct=false
            done

            echo ""

            [[ $correct == false ]] && echo -e "\033[0mSkipping putting $name config...\n" && continue
    
            echo -e "\033[37m"
            echo "$config_default_location"
            cp -r -v "$name" "$config_default_location/"
            echo -e "\033[0m\033[1j"
        else
            echo "-\033[31mWARNING: local folder $cwd/$name cannot be found. Skipping this config...\033[0m"
        fi
    done
}

function put_others() {
    echo -e "\033[0mPutting configs with special file locations..."
    local -n config_files_ref=$1 

    for key in ${!config_files_ref[@]}; do
        files=${ ls -a $key; }

        for put_file in ${files[@]}; do
            if [[ $put_file != "." && $put_file != ".." ]]; then
                IFS_TEMP=$IFS
                IFS=";"
                
                echo -e "\033[33mInferring put destination of $put_file..."

                file_dest=""
                for file_item in ${config_files_custom[$key]}; do
                    
                    match=${ echo $file_item | grep $put_file ; }
                    
                    [[ ! -z $match ]] && file_dest=$match
                done

                echo -e "\033[0m- Found $put_file destination: \033[36m$file_dest"
                echo -e "  \033[33mIs this correct? [y/n]"

                valid_inp=false
                correct=true
                until [[ $valid_inp == true ]]; do
                    read -n 1 inp
                    [[ $inp == "Y" || $inp == "y" ]] && valid_inp=true && correct=true
                    [[ $inp == "N" || $inp == "n" ]] && valid_inp=true && correct=false
                done
                
                IFS=$IFS_TEMP
                echo ""

                if [[ $correct == false ]]; then
                    echo -e "\033[0mSkipping putting $put_file..."
                    continue
                fi

                echo -e "- \033[0mcopying \033[36m$key/$put_file \033[0mto \033[36m$file_dest\033[0m..." 
                echo -e "\033[37m"
                cp -v $key/$put_file $file_dest
            fi
        done
    done
}


if [ "$EUID" -ne 0 ]; then 
    echo "This script needs elevated permissions. Please run it as root (sudo ./put.sh)"
    exit
fi

put_defaults ${config_defaults[@]}
put_others config_files_custom

echo -e "\n\033[92;1mPutting configs complete!\033[0m"
