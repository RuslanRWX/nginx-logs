#!/bin/sh
# Version 2.0.1
PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
trap "rm $Pid; exit" 1 2 15

# Host name
HostName=$1
# Path to nginx code log 
Path="/run/shm/${HostName}.access.log"
# Pid file
Pid="/var/run/nginx.${HostName}.log.pid"
# Ningx http monitored codes
CODES="404 499 502 500 504"

Time="60"


cat /dev/null > $Path
echo $$ > $Pid

Start () {
echo "start nginx log"
while true
do
    for Code in $CODES
    do
#	echo $Code
    grep -w $Code $Path | wc -l  > /tmp/${Code}.${HostName}.log
    done
cat /dev/null > $Path
sleep $Time
done
}

Stop () {
kill  `cat $Pid`
rm -f $Pid
echo "Stop !"
}


case $2 in
    start)
           Start >> /dev/null 2>&1  &
           ;;
        stop)
               Stop
           ;;
        restart)
           echo "Restart"
               Stop
               sleep 3
               Start	       
               ;;
       status)  
           cat $Pid || echo not started
           ;;
        *)
	echo "start|stop|restart|status"
	;;
esac
