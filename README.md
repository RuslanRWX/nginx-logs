# nginx-logs <br>
# Install and Configure <br>

1. Install 
1,1 git 


1. Nginx 
1.1 Add log format to nginx.conf  <br>

log_format  status  '$status'; <br>

1,2. Add log to your virtual host config <br>
access_log  /run/shm/your_site.access.log status;
<br>
2 systemd <br>




