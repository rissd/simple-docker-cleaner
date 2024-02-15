### Simple docker cleaner

Executes docker system prune -af by cron job. Available scripts:

day, week, month, month-2, month-3

Аlso available to run on occupied disk space. Specify the number%

Cli start

`docker run -d -v /var/run/docker.sock:/var/run/docker.sock --name docker-cleaner --restart always ghcr.io/rissd/simple-docker-cleaner:latest`
