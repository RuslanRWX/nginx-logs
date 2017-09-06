# nginx-logs <br>
# Install and Configure <br>

1. Install  <br>
1.1 git clone <br>
git clone https://github.com/ruslansvs2/nginx-logs.git
<br>
1.2 cd nginx-logs
<br>

2. Nginx  <br>
2.1 Add log format to nginx.conf  <br>
log_format  status  '$status'; <br>

2.2. Add log to your virtual host config <br>
access_log  /run/shm/your_site.access.log status;
<br>

3. systemd <br>
3.1 Change "your_site" to you site name in nginxerror.service and nginxlog.service <br>
sed -i "s/your_site/REAL_NAME/" nginxlog.service  <br>
sed -i "s/your_site/REAL_NAME/" nginxerror.service <br>
Where REAL_NAME is your site name  <br>
3.2 copy to systemd directory<br>
Debian: <br>
cp nginxerror.service /etc/systemd/system/ <br>
cp nginxlog.service  /etc/systemd/system/ <br>
systemctl daemon-reload <br>
RHEL,CentOS:<br>
cp nginxerror.service /usr/lib/systemd/system/ <br>
cp nginxlog.service  /usr/lib/systemd/system/ <br>
systemctl daemon-reload <br>

<br>
4. Zabbix <br>
4.1 site.txt - file for discovery rule  <br>
sed -i "s/your_site/REAL_NAME/" site.txt <br>
4.2 Scripts 
mkdir /etc/zabbix/init.d/<br>
cp nginx.error.sh /etc/zabbix/init.d/<br>
cp nginx.log.sh /etc/zabbix/init.d/ <br>
mkdir /etc/zabbix/tmp/ <br>
cp sites.txt /etc/zabbix/tmp/
4.2 Import template 

