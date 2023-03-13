#! /bin/bash
clear
echo -e "\n\n\n=================================================="
echo -e "#                                                #"
echo -e "#                                                #"
echo -e "#        Geek Bench Script Installation          #"
echo -e "#        made by RigiBody since 2023.03          #"
echo -e "#                                                #"
echo -e "#         for the Eternity of FREE OCI           #"
echo -e "#                                                #"
echo -e "#                                                #"
echo -e "==================================================\n\n\n"



read -p "Warn: You need to login as ROOT to get things done properly before going further. y(yes/just enter) / n(no) : " loginstat

[ -z "$loginstat" ] && loginstat="y"

if [ "$loginstat" = "y" ]; then

    mkdir -p ~/download/geekbench; cd ~/download/geekbench
    read -p "Select your system between 1(ARM(OCI AMPERE)) and 2(INTEL/AMD) : " cond
    if [ "$cond" = 1 ]; then 
        wget https://cdn.geekbench.com/Geekbench-5.4.0-LinuxARMPreview.tar.gz
        tar xvf Geekbench-5.4.0-LinuxARMPreview.tar.gz
        cd Geekbench-5.4.0-LinuxARMPreview
        rm geekbench5 geekbench_armv7
        mkdir /opt/Geekbench-5.4.0
        cp ~/download/geekbench/Geekbench-5.4.0-LinuxARMPreview/* /opt/Geekbench-5.4.0
        touch /etc/cron.daily/geekbench
        echo -e "#! /bin/bash\n/usr/bin/killall geekbench_aarch64\n/usr/bin/rm -f /tmp/Result 2> /dev/null\n/opt/Geekbench-5.4.0/geekbench_aarch64 2>&1 > /tmp/Result" > /etc/cron.daily/geekbench
    
    elif [ "$cond" = 2 ]; then
        wget https://cdn.geekbench.com/Geekbench-6.0.1-Linux.tar.gz
        tar xvf Geekbench-6.0.1-Linux.tar.gz
        cd Geekbench-6.0.1-Linux
        # rm geekbench5 geekbench_armv7
        mkdir /opt/Geekbench-6.0.1-Linux
        cp ~/download/geekbench/Geekbench-6.0.1-Linux/* /opt/Geekbench-6.0.1-Linux
        touch /etc/cron.daily/geekbench
        echo -e "#! /bin/bash\n/usr/bin/killall geekbench_x86_64\n/usr/bin/rm -f /tmp/Result 2> /dev/null\n/opt/Geekbench-6.0.1-Linux/geekbench_x86_64 2>&1 > /tmp/Result" > /etc/cron.daily/geekbench
    
    else
        echo "Wrong Answer! Retry from the begining ~"
        exit
    fi

    

    
    read -p "Do you want to receive a Telegram message every geekbench execution? if so, enter y(yes) or n(no/just ENTER) : " ans
    [ -z "$ans" ]  && ans="n"
    if [ "$ans" = "y" ]; then
        read -p "Enter your Telegram Chat_id : " chat_id
        read -p "Enter your Telegram TOKEN : " token
        read -p "Enter your Server's Name : " sname
        echo -e "if [ '\$?' = 0 ]; then\ncurl -k -d 'chat_id="$chat_id"' --data-urlencode 'text=GeekBench in "$sname" has been loaded successfully now.' https://api.telegram.org/bot"$token"/sendMessage" >> /etc/cron.daily/geekbench
        echo -e "elif [ '\$?' = 1 ]; then\ncurl -k -d 'chat_id="$chat_id"' --data-urlencode 'text=It has failed to load GeekBench in "$sname" now. Chek out your configuration.' https://api.telegram.org/bot"$token"/sendMessage\nfi" >> /etc/cron.daily/geekbench   
    else
        echo "no message function"
    fi

    chmod +x /etc/cron.daily/geekbench
    rm -rf ~/download/geekbench
    echo -e "\n\nGeekBench SCRIPT has successfully installed on your system on the daily basis crontab.\n\n"

else
    echo "You SHOULD login with ROOT before proceeding"
fi

