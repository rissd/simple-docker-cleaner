#!/bin/ash
set -e

if [[ "$@" == "--help" ]]; then
    echo "A simple docker cleaner. Executes docker system prune -af by cron job. Available scripts:"
    echo "day, week, month, month-2, month-3"
    echo "Аlso available to run on occupied disk space. Specify the number%"
    exit 0
fi

if [[ "$@" == "defautl" ]]; then
    crontab  /cron/default
    echo "Docker system prune -af starts when the disk is 95% full"
    echo "Docker system prune -af starts every month at 4:00."
    crond -l 0 -f
fi

if [[ "$@" == *% ]]; then
    NUMBER_WITHOUT_PERCENT="${@%\%}"
    
    if [[ $NUMBER_WITHOUT_PERCENT -le 100 ]]; then
        crontab  /cron/free-space
        echo "Docker system prune -af starts when the disk is $@ full"
        PROCENT=$NUMBER_WITHOUT_PERCENT crond -l 0 -f
    else
        echo "The number is greater than 100. Please enter a number not greater than 100."
        exit 1
    fi
fi

crontab /cron/$@
echo "Docker system prune -af starts every $@ at 4:00."
crond -l 0 -f

exec "$@"