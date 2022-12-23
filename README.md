# nginx-logs for ZABBIX monitoring Install and Configure

## 1. Install 

### 1.1 git clone 

```
git clone https://github.com/ruslansvs2/nginx-logs.git<br>
cd nginx-logs
```

### 2. Configure Nginx 
#### 2.1 Add log format to nginx.conf

```
log_format  status  '$status';
```

#### 2.2. Add log to your virtual host config 

```
access_log  /run/shm/your_site.access.log status;
```

### 3. systemd

#### 3.1 Change "your_site" to you site name in nginxerror.service and nginxlog.service

```
sed -i "s/your_site/REAL_NAME/" nginxlog.service  
sed -i "s/your_site/REAL_NAME/" nginxerror.service
```

Where REAL_NAME is your site name

### 3.2 Copy to systemd 

Debian: 

```
cp nginxerror.service /etc/systemd/system/
cp nginxlog.service  /etc/systemd/system/
systemctl daemon-reload 
```

RHEL,CentOS:

```
cp nginxerror.service /usr/lib/systemd/system/
cp nginxlog.service  /usr/lib/systemd/system/ 
systemctl daemon-reload 
```

### 4. Zabbix 

#### 4.1 site.txt - file for discovery rule 

```
sed -i "s/your_site/REAL_NAME/" site.txt 
```

#### 4.2 Scripts <br>

```
mkdir /etc/zabbix/init.d/
cp nginx.error.sh /etc/zabbix/init.d/
cp nginx.log.sh /etc/zabbix/init.d/ 
mkdir /etc/zabbix/tmp/ 
cp sites.txt /etc/zabbix/tmp/
```

#### 4.3 Import template 

