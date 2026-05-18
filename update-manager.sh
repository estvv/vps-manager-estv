#!/bin/bash

CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
RESET='\033[0m'

URL_UPDATE_MANAGER="https://raw.githubusercontent.com/estvv/vps-manager-estv/main/update-manager.sh"
DEST_UPDATE_MANAGER="$HOME/update-manager.sh"

echo -e "----------------------------------------------"
echo -e "[1/3] Downloading the latest ${YELLOW}update-manager.sh${RESET} from GitHub..."

if curl -s -f -o "$DEST_UPDATE_MANAGER" "$URL_UPDATE_MANAGER"; then
    echo -e "Main ${YELLOW}update-manager.sh${RESET} updated ${GREEN}successfully${RESET} !"
else
    echo -e "${RED}Unable${RESET} to download the ${YELLOW}update-manager.sh${RESET}. Check the URL."
    exit 1
fi
echo -e "----------------------------------------------\n"

URL_MAKEFILE="https://raw.githubusercontent.com/estvv/vps-manager-estv/main/Makefile.main.template"
DEST_MAKEFILE="$HOME/Makefile"

echo -e "----------------------------------------------"
echo -e "[2/3] Downloading the latest ${YELLOW}Makefile${RESET} from GitHub..."
if curl -s -f -o "$DEST_MAKEFILE" "$URL_MAKEFILE"; then
    echo -e "Main ${YELLOW}Makefile${RESET} updated ${GREEN}successfully${RESET} !"
else
    echo -e "${RED}Unable${RESET} to download the ${YELLOW}Makefile${RESET}. Check the URL."
    exit 1
fi
echo -e "----------------------------------------------\n"

URL_SUB_MAKEFILE="https://raw.githubusercontent.com/estvv/vps-manager-estv/main/Makefile.subfolder.template"
PROJECTS_DIR="$HOME/projects"

echo -e "----------------------------------------------"
echo -e "[3/3] Updating ${YELLOW}sub-Makefiles${RESET} in projects..."
echo -e "----------------------------------------------\n"

for DIR in "$PROJECTS_DIR"/*/; do
    if [ -d "$DIR" ]; then
        PROJECT_NAME=$(basename "$DIR")
        echo -e "----------------------------------------------"
        echo -e "${YELLOW}Processing${RESET} project: ${CYAN}$PROJECT_NAME${RESET}"

        if curl -s -f -o "${DIR}Makefile" "$URL_SUB_MAKEFILE"; then
            echo -e "   -> ${YELLOW}sub-Makefile${RESET} for ${CYAN}$PROJECT_NAME${RESET} updated ${GREEN}successfully${RESET} !"
            echo -e "----------------------------------------------\n"
            continue
        else
            echo -e "   -> ${RED}Unable${RESET} to download the ${YELLOW}sub-Makefile${RESET} for ${CYAN}$PROJECT_NAME.${RESET}"
            echo -e "----------------------------------------------\n"
        fi
    fi
done

echo -e "\nGlobal infrastructure update completed ${GREEN}successfully${RESET} !"
