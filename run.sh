#!/usr/bin/env bash

# Feel free to redistribute parts and/or concept/code in any form/fork leave credits or not :)
# by <imhunterand@wearehackerone.com> < https://github.com/imhunterand/shoscan.git>
# ------------------------------------------------------------------------------------------------

#A badass banner
    clear
    export BLUE='\033[1;94m'
    export GREEN='\033[1;92m'
    export RED='\033[1;91m'
    export RESETCOLOR='\033[1;00m'
    echo -e "${RED}"
    echo " "
    echo "   ██████  ██░ ██  ▒█████    ██████  ▄████▄   ▄▄▄       ███▄    █ 
▒██    ▒ ▓██░ ██▒▒██▒  ██▒▒██    ▒ ▒██▀ ▀█  ▒████▄     ██ ▀█   █ 
░ ▓██▄   ▒██▀▀██░▒██░  ██▒░ ▓██▄   ▒▓█    ▄ ▒██  ▀█▄  ▓██  ▀█ ██▒
  ▒   ██▒░▓█ ░██ ▒██   ██░  ▒   ██▒▒▓▓▄ ▄██▒░██▄▄▄▄██ ▓██▒  ▐▌██▒
▒██████▒▒░▓█▒░██▓░ ████▓▒░▒██████▒▒▒ ▓███▀ ░ ▓█   ▓██▒▒██░   ▓██░
▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░░ ░▒ ▒  ░ ▒▒   ▓▒█░░ ▒░   ▒ ▒ 
░ ░▒  ░ ░ ▒ ░▒░ ░  ░ ▒ ▒░ ░ ░▒  ░ ░  ░  ▒     ▒   ▒▒ ░░ ░░   ░ ▒░
░  ░  ░   ░  ░░ ░░ ░ ░ ▒  ░  ░  ░  ░          ░   ▒      ░   ░ ░ 
      ░   ░  ░  ░    ░ ░        ░  ░ ░            ░  ░         ░ 
                                   ░                             "
    echo " "
    echo " "
    echo "                 -By imhunterand  "
    echo " "
    echo " a bash script to automate shodan-cli functions "
    echo -e "${BLUE} [queries/suggestions: imhunterand@cyberservices.com]"
    echo -e "${RESETCOLOR}"


#function to display warnings
warnings(){
            echo -e "${RED}"
            echo "  "
            echo "                          ⚠ IMPORTANT⚠ "
            echo "➤ FOR YOUR OWN LEGAL BENEFIT, DO NOT ATTEMPT TO LOGIN (EVEN WITH DEFAULT PASSWORDS)."
            echo "  "
            sleep 6
            echo "➤ THE AUTHOUR OF THIS SCRIPT DOESN'T ENCOURAGE ILLEGAL/UNETHIACAL ACTIVITIES."
            sleep 6
            echo "  "
            echo "➤ ANY ACTIONS YOU TAKE UPON USING THE SCRIPT IS STRICTLY AT YOUR OWN RISK."
            echo "  "
            sleep 6
            echo "➤ DON'T OVERUSE THIS SCRIPT USING TOR, WHICH WILL AFFECT THE EXPERINCE OF THE FELLOW TOR USERS!!"
            echo "  "
            sleep 6
            echo "➤ ENABLE YOUR FAVORITE VPN SERVICE OR USE TOR BROWSER(YOU GOTTA!! IF YOU WANT TO REMAIN SLIGHTLY ANONYMOUS)."
            echo "  "
            sleep 6
            echo "➤ DON'T GET INTO TROUBLE, USE IT WISELY AND BE RESPONIBLE."
            sleep 15
            clear
main_menu
}

#function to search
function search(){
    echo -e ${BLUE}
    read -p "Enter the search term(query) :  " b
    if [[ -z "$b" ]]; then
        select_task
    else
        read -p "Save as[file name] : " n
        shodan download $n $b #this will download save a file with a given name and extension .json.gz
        echo " $n is saved in : ↶"
        pwd
        read -p "Do you wanna search again?[Y/n] : " re
        if [[ "$re" == "Y" ||  "$re" = "y"   ]]; then
            clear
            search
        else
            echo -e "${NC}"
            sleep 1
            main_menu
        fi
    fi
}

#function to open 10[hey you!! if you want to increase the number, sure do)addresses in web-browser
function open_em(){
    echo -e ${BLUE}
    yes_no "open the results in a web-browser?" &&
    if [[ "$1" ==  "y" || "Y" ]]; then
        echo " "
        echo "list of downloade files: "
        echo -e ${RED}
        ls | grep .json.gz
        echo " "
        echo "Type in the name of the downloaded file(don't include the file extension)↶"
        echo -e ${BLUE}
        read -p "file name  :" q # reads the file name
        read -p "Enter the full name of your favorite web browser:↶
        $(echo "➤ firefox")
        $(echo "➤ brave-browser --incognito" )
        $(echo "➤ chrome-browser..etc")  : "  br
        echo "  "
        echo "opening ten tabs at once, close those tabs to open the next ten."
        echo "saving results in [filename].txt ;)"
        shodan parse --fields ip_str,port,org --separator : $q.json.gz >> $q.txt
        ((shodan parse --fields ip_str,port --separator : $q.json.gz) | xargs -n 10 $br) > /dev/null 2>&1
        clear
        select_task
    fi
}

#scan a host using host address[IPv4]
function scan() {
    echo -e "${BLUE} ➥ Enter the IP of the host : "
    read -p "[IPv4 format x . x . x . x] ➠ " ip_4

    shodan host $ip_4 | tee $ip_4".txt"

    select_task
}

#function to ask yes or no
function yes_no(){
    while true; do
        read -p "Do you really want to $* [y/n]: " yn

        case $yn in
            [Yy]*) return 0
         ;;
            [Nn]*) main_menu ; return  1
         ;;
        esac
    done
}

#general exit function
function exit_script() {
    yes_no "exit shoscan" &&
    echo -e ${RED} "➥ Thank you for using shoscan ❤ "
    sleep  1.5
    clear
    exit 0
}

#menu dialogues
function print_tasks(){
    echo -e "${RED}➥ task menu"
    echo -e "${GREEN} 1. Search and download results from Shodan using the same query syntax as the website. "
    echo -e " 2. open obtained results in a web browser."
    echo -e " 3. Gather host Information using host IP[IPv4]."
    echo -e " 4. Go back to main menu."
    echo -e " 5. Exit script.  "
    echo -e "${RED} ➘"
}

function print_menu() {
    echo -e "${RED}"
    echo "➥ main menu "
    echo -e "${GREEN}"
    echo " 1. Select a task. "
    echo " 2. Display user disclaimer/warnings."
    echo " 3. Exit script." "${NC}"
    echo -e  "${RED} ➘"
 }


#task select menu
function select_task(){
    print_tasks
    read -rp "shoscan↠ task menu➜ " select_task
    clear
        case ${select_task} in
            1)
                search
            ;;
            2)
                open_em
            ;;
            3)
                scan
            ;;
            4)
                main_menu
            ;;
            5)
                exit_script
            ;;
            *)
                select_task
            ;;
    esac
}

#main menu
function main_menu() {
    print_menu
    read -rp "shoscan↠ main menu➜ " main_option
    clear
        case ${main_option} in
            1)
                select_task
            ;;
            2)
                warnings
            ;;
            3)
                exit_script
            ;;
            *)
                main_menu
            ;;
    esac
}
main_menu #main function invocation
