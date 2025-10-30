# This script provides the variables for get.sh and put.sh
# This scriot also parses the config file (in a somewhat lazy way)

local_folders=()
config_defaults=()
config_default_location="$HOME/.config"
declare -A config_files_custom

# A somewhat lazy way of parsing the configs file
current_option=""
while read -r line; do
    line=${ echo $line | xargs; }
    first_char=${line:0:1}
    length=${#line}

    # skip empty lines
    if [[ "$first_char" == "" ]]; then
        continue
    fi
    
    # detect "headers"
    if [[ "$first_char" == "[" ]]; then
        current_option=${line:1:length-2}
        continue
    fi

    ## Parse for config defaults
    if [[ $current_option == "config_defaults" ]]; then
        TEMP_IFS=$IFS
        IFS="="
        read -ra opts <<< "$line"
        opt_name=${ echo ${opts[0]} | xargs ;}
        opt_value=${ echo ${opts[1]} | xargs ;}
        IFS=" "
        
        if [[ $opt_name == "names" ]]; then
            for n in ${opt_value[@]} ; do
                [[ ! "${local_folders[@]}" =~ "$n" ]] && local_folders+=( $n )
                [[ ! "${config_defaults[@]}" =~ "$n" ]] && config_defaults+=( $n )
            done
        elif [[ $opt_name == "default_location" ]]; then
            config_default_location="${opt_value}"
        fi

        IFS=$TEMP_IFS

    ## Parsing for specific configs
    elif [[ $current_option == "config_custom."* ]]; then
        current_name=${current_option:14:${#current_option}-2}

        TEMP_IFS=$IFS
        IFS="="
        read -ra opts <<< "$line"
        opt_name=${ echo ${opts[0]} | xargs ;}
        opt_value=${ echo ${opts[1]} | xargs ;}
        IFS=$TEMP_IFS

        if [[ $opt_name == "files" ]]; then
           config_files_custom["$current_name"]="$opt_value"
        fi


        # adds the config name if needed
        [[ ! "${local_folders[@]}" =~ "$opt_name" ]] && local_folders+=( $current_name )
    fi

done < "configs.toml"
