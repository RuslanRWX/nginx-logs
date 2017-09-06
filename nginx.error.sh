#!/bin/sh
### Version 2.0.1
PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
trap "rm $Pid; exit" 1 2 15

# host name 
HostName=$1
# Path to nginx error log 
Path="/var/www/logs/${HostName}.error.log"
#ERROR="404 499 502"
# timeout 
Time="60"
# pid file
Pid="/var/run/nginx.${HostName}.error.pid"



echo "start nginx error log"
echo $$ > $Pid

Start () { 
while true
do
Mark=`date +%s`
read OldMark < /tmp/zabbix.mark.nginx.error.${HostName}.txt
        #echo $Mark
        #echo $OldMark
        grep -A100000000  -w "$OldMark" $Path | sed "/zabbix/d;/^#/d" | wc -l  > /tmp/nginx.${HostName}.errors.log
        #cat /tmp/nginx.errors.log
echo "zabbix mark $Mark" >> $Path
echo "zabbix mark $Mark" > /tmp/zabbix.mark.nginx.error.${HostName}.txt
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

