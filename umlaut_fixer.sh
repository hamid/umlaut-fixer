#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
DIVIDER="${YELLOW}--------------------------------------------------------------------------------${NC}"

# Function to find combining umlauts
find_combining_umlauts() {
    local directory="$1"
    echo -e "${YELLOW}Searching for Combining Umlauts in ${directory}...${NC}"
    local count=0
    while IFS= read -r line; do
        ((count++))
        echo -e "$DIVIDER"
        echo -e "${GREEN}$line${NC}"
    done < <(find "$directory" -type f ! -path "*node_modules*" -exec grep -Iano $'u\xcc\x88' {} +)
    echo -e "$DIVIDER"
    echo -e "${GREEN}Total appearances found: $count.${NC}"
}

# Function to replace combining umlauts
replace_combining_umlauts() {
    local directory="$1"
    echo -e "${YELLOW}Replacing Combining Umlauts with Precomposed Umlauts in ${directory}...${NC}"
    local count=0
    local modified_count=0
    while IFS= read -r file; do
        # Check for files containing any combining umlaut
        if grep -Iq $'[aou]\xcc\x88' "$file"; then
            # Determine if GNU or BSD version of sed is available for in-place editing
            if sed --version 2>/dev/null | grep -q GNU; then
                # GNU sed (Linux) syntax for in-place editing without backup
                sed -i'' -e $'s/a\xcc\x88/ä/g' -e $'s/o\xcc\x88/ö/g' -e $'s/u\xcc\x88/ü/g' "$file"
            else
                # BSD sed (macOS) syntax for in-place editing without backup
                sed -i '' -e $'s/a\xcc\x88/ä/g' -e $'s/o\xcc\x88/ö/g' -e $'s/u\xcc\x88/ü/g' "$file"
            fi
            ((modified_count++))
            echo -e "${GREEN}Modified: $file${NC}"
        fi
        ((count++))
    done < <(find "$directory" -type f ! -path "*node_modules*" -exec grep -Il $'[aou]\xcc\x88' {} +)
    echo -e "$DIVIDER"
    echo -e "${GREEN}Total files modified: $modified_count.${NC}"
}



# Parse command-line arguments for non-interactive mode
if [[ "$1" == "-r" && -n "$2" ]]; then
    if [[ ! -d "$2" ]]; then
        echo -e "${RED}Directory does not exist. Exiting...${NC}"
        exit 1
    fi
    replace_combining_umlauts "$2"
    exit 0
fi

# Interactive mode for both finding and replacing umlauts
echo -e "${YELLOW}Enter the directory to search (leave blank for current directory):${NC}"
read directory
directory=${directory:-./}

if [[ ! -d $directory ]]; then
    echo -e "${RED}Directory does not exist. Exiting...${NC}"
    exit 1
fi

echo -e "${GREEN}Select an option:${NC}"
echo -e "1. Find usage of Combining Umlauts"
echo -e "2. Replace Combining Umlauts with Precomposed Umlauts"
read option

case $option in
    1)
        find_combining_umlauts "$directory"
        ;;
    2)
        replace_combining_umlauts "$directory"
        ;;
    *)
        echo -e "${RED}Invalid option. Exiting...${NC}"
        ;;
esac
