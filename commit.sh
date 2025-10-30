# This script provides an interactive way to commit changes for this repositoryA

echo "Adding files to commit..."
git add .

echo ""
echo "Enter commit message (leave blank for default message): "
message="Updating my config files"
read inp

if [[ ! -z $inp ]]; then
    message=$inp
fi

echo ""
echo "Enter commit description (leave blank for no description)"
description=""
read inp

if [[ ! -z $inp ]]; then
    description=$inp
fi

echo ""
echo "Making new commit..."

# Making the commit
if [[ -z $description ]]; then # no description
    git commit -m "$message"
else # with description
    git commit -m "$message" -m "$description"
fi

echo ""
echo "Finished creating commit!"

looping=true
echo "Push to github? [y/n]"
while [[ $looping = true ]]; do
    read -r -n 1 response
    case "$response" in
        y | Y) 
            looping=false
            git push 
            ;;
        n | N )
            looping=false
            ;;
        *) 
            ;;
    esac
done

