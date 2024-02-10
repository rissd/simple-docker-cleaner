#!/bin/ash
set -e

if df -h | grep -q overlay; then
    SIZE=$(df -h | grep overlay | grep -Eo '[0-9]+%')
    SIZE=$(echo "$SIZE" | tr -d ' %')
    if [ "$SIZE" -ge $@ ]; then
        date
        df -h | grep overlay                                                                         
        docker system prune -af
    else                                                                                     
        exit 0
    fi
else                    
    echo "no overlay fs"
fi

exec "$@"