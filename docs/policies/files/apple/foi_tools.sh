#!/bin/bash

printf '\033[8;30;130t'

FV_UNLOCK_USER="unlock"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'


echo_lb() {
    echo "__________________________________________________"
}

echo_header() {
    echo -e "${BOLD}$1${RESET}"
}

echo_error() {
    echo -e "${RED}ERROR: $1${RESET}"
}

echo_log() {
    echo -e "${BLUE}$1${RESET}"
}

echo_success() {
    echo -e "${GREEN}$1${RESET}"
}

display_banner() {
    clear
    echo -e "$RESET"
    cat << "EOF"
 (    (   (
 )\ ) )\ ))\ )
(()/((()/(()/((
 /(_))/(_))(_))\     _____ ___    _____ _   _ _____    ___  _     ___ ____    _    ____   ____ _   ___   __
(_))_(_))(_))((_)   |_   _/ _ \  |_   _| | | | ____|  / _ \| |   |_ _/ ___|  / \  |  _ \ / ___| | | \ \ / /
| |_ |_ _| _ \ __|    | || | | |   | | | |_| |  _|   | | | | |    | | |  _  / _ \ | |_) | |   | |_| |\ V /
| __| | ||   / _|     | || |_| |   | | |  _  | |___  | |_| | |___ | | |_| |/ ___ \|  _ <| |___|  _  | | |
|_|  |___|_|_\___|    |_| \___/    |_| |_| |_|_____|  \___/|_____|___\____/_/   \_\_| \_\\____|_| |_| |_|
___________________________________________________________________________________________________
Copyright (C) 2024 FOI Georgia https://security.foi.ge
___________________________________________________________________________________________________

EOF

}


main_menu() {
    display_banner
    echo -e "$BOLD" "FOI Tools - Main Menu"
    echo -e "$RESET"
    echo_lb
    echo
    echo -e "$YELLOW"
    echo "    [1] Enforce FileVault User"
    echo "    [2] Exit"
    echo_lb
    echo
    echo -n "    Enter your choice: "
    read choice

    case "$choice" in
        1) enforce_filevault_user ;;
        2) exit 0 ;;
        *) echo "Invalid choice." ; pause ;;
    esac
}

pause() {
    echo "Press any key to continue..."
    read -n 1
}

_check_filevault_status() {
    if sudo fdesetup status | grep -iq "FileVault is On"; then
        echo_success "Check passed! FileVault is enabled."
    else
        echo_error "Check failed! FileVault is disabled. You have to enable FileVault first.\n\n"
        pause
        main_menu
    fi
}

_check_run_as_user() {
    user=$1
    if [[ "$(whoami | tr '[:upper:]' '[:lower:]')" == "$user" ]]; then
        echo_success "Check passed! Running as $(whoami)"
    else
        echo_error "Check failed! Login from the '$user' user and run this script from there\n"
        pause
        main_menu
    fi
}

_check_icloud_key() {
    if sudo fdesetup list -extended | grep -iq "iCloud"; then
        echo_error "FileVault key is backed up to iCloud! Disable FileVault, re-enable it and save recovery key in a Password Manager!.\n"
        pause
        main_menu
    else
        echo_success "Check passed! No iCloud key detected."
    fi
}

enforce_filevault_user() {
    clear
    display_banner

    echo_header "Enforcing FileVault User"
    echo_lb

    echo_log "Checking if logged in with $FV_UNLOCK_USER user..."
    sleep 1
    _check_run_as_user "$FV_UNLOCK_USER"

    echo_log "\nChecking if FileVault is Enabled..."
    echo_log "\n    If prompted, enter password for the '$FV_UNLOCK_USER' user"
    echo_log "\n    You will not be able to see the password while typing\n"
    sleep 1
    _check_filevault_status

    echo_log "Checking if FileVault key is backed up to iCloud..."
    sleep 1
    _check_icloud_key

    echo_log "Disabling FileVault permissions for all users except '$FV_UNLOCK_USER'..."
    sleep 1
    all_users=$(sudo fdesetup list | awk -F',' '{print $1}')
    other_users=$(echo "$all_users" | grep -v "$FV_UNLOCK_USER")
    if [[ "$all_users" == "$FV_UNLOCK_USER" ]]; then
        echo_success "SUCCESS: '$FV_UNLOCK_USER' is already the only user with FileVault access.\n"
        pause
        main_menu
    fi

    echo_log "Other users with FileVault access:"
    echo_header "$other_users"
    echo_log "Removing FileVault permissions for all users except '$FV_UNLOCK_USER'..."
    for user in $other_users; do
        sleep 1
        echo_log "Removing FileVault access for user: $user"
        sudo fdesetup remove -user "$user"
    done

    remaining_users=$(sudo fdesetup list | awk -F',' '{print $1}')
    if [[ "$remaining_users" == "$FV_UNLOCK_USER" ]]; then
        echo_success "SUCCESS: All users except '$FV_UNLOCK_USER' have been removed from FileVault access.\n"
    else
        echo_error "There are still other users with FileVault access:"
        echo_error "$remaining_users"
    fi
}


main_menu
