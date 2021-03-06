
Screenplay:
The user is connected to Squid3 server.
Squid3 server is connected to 8 Privoxy server instances.
Each instances of Privoxy server is connected to 1 of 8 instances of Tor.
Tor is connected to the internet.
squid3-tor-privoxy

 
### 1. Updating Debian.
'sudo apt-get update'
'sudo apt-get upgrade'
'apt-get dist-upgrade'
 
### 2. Install Squid3 server proxy.
http://terminal28.com/how-to-install-and-configure-squid-proxy-server-clamav-squidclamav-c-icap-server-debian-linux/
 
### 3. Install Privoxy server and Tor.
'sudo apt-get install tor privoxy'
 
### 4. Stop all servers after instalation.
'sudo /etc/init.d/squid3 stop'
'sudo /etc/init.d/privoxy stop'
'sudo /etc/init.d/tor stop'
 
### 5. Configure Tor.
Create 8 separated Tor configfiles .
# torrc-1
sudo cat << EOT > /etc/tor/torrc-1
SocksBindAddress 127.0.0.1
SocksPort 10010
SocksPolicy accept *
AllowUnverifiedNodes middle,rendezvous
Log notice syslog
RunAsDaemon 1
User debian-tor
CircuitBuildTimeout 30
NumEntryGuards 6
KeepalivePeriod 60
NewCircuitPeriod 15
DataDirectory /var/lib/tor1
PidFile /var/run/tor/tor-1.pid
EOT
# torrc-2
sudo cat << EOT > /etc/tor/torrc-2
SocksBindAddress 127.0.0.1
SocksPort 10020
SocksPolicy accept *
AllowUnverifiedNodes middle,rendezvous
Log notice syslog
RunAsDaemon 1
User debian-tor
CircuitBuildTimeout 30
NumEntryGuards 6
KeepalivePeriod 60
NewCircuitPeriod 15
DataDirectory /var/lib/tor2
PidFile /var/run/tor/tor-2.pid
EOT
# torrc-3
sudo cat << EOT > /etc/tor/torrc-3
SocksBindAddress 127.0.0.1
SocksPort 10030
SocksPolicy accept *
AllowUnverifiedNodes middle,rendezvous
Log notice syslog
RunAsDaemon 1
User debian-tor
CircuitBuildTimeout 30
NumEntryGuards 6
KeepalivePeriod 60
NewCircuitPeriod 15
DataDirectory /var/lib/tor3
PidFile /var/run/tor/tor-3.pid
EOT
# torrc-4
sudo cat << EOT > /etc/tor/torrc-4
SocksBindAddress 127.0.0.1
SocksPort 10040
SocksPolicy accept *
AllowUnverifiedNodes middle,rendezvous
Log notice syslog
RunAsDaemon 1
User debian-tor
CircuitBuildTimeout 30
NumEntryGuards 6
KeepalivePeriod 60
NewCircuitPeriod 15
DataDirectory /var/lib/tor4
PidFile /var/run/tor/tor-4.pid
EOT
# torrc-5
sudo cat << EOT > /etc/tor/torrc-5
SocksBindAddress 127.0.0.1
SocksPort 10050
SocksPolicy accept *
AllowUnverifiedNodes middle,rendezvous
Log notice syslog
RunAsDaemon 1
User debian-tor
CircuitBuildTimeout 30
NumEntryGuards 6
KeepalivePeriod 60
NewCircuitPeriod 15
DataDirectory /var/lib/tor5
PidFile /var/run/tor/tor-5.pid
EOT
# torrc-6
sudo cat << EOT > /etc/tor/torrc-6
SocksBindAddress 127.0.0.1
SocksPort 10060
SocksPolicy accept *
AllowUnverifiedNodes middle,rendezvous
Log notice syslog
RunAsDaemon 1
User debian-tor
CircuitBuildTimeout 30
NumEntryGuards 6
KeepalivePeriod 60
NewCircuitPeriod 15
DataDirectory /var/lib/tor6
PidFile /var/run/tor/tor-6.pid
EOT
# torrc-7
sudo cat << EOT > /etc/tor/torrc-7
SocksBindAddress 127.0.0.1
SocksPort 10070
SocksPolicy accept *
AllowUnverifiedNodes middle,rendezvous
Log notice syslog
RunAsDaemon 1
User debian-tor
CircuitBuildTimeout 30
NumEntryGuards 6
KeepalivePeriod 60
NewCircuitPeriod 15
DataDirectory /var/lib/tor7
PidFile /var/run/tor/tor-7.pid
EOT
# torrc-8
sudo cat << EOT > /etc/tor/torrc-8
SocksBindAddress 127.0.0.1
SocksPort 10080
SocksPolicy accept *
AllowUnverifiedNodes middle,rendezvous
Log notice syslog
RunAsDaemon 1
User debian-tor
CircuitBuildTimeout 30
NumEntryGuards 6
KeepalivePeriod 60
NewCircuitPeriod 15
DataDirectory /var/lib/tor8
PidFile /var/run/tor/tor-8.pid
EOT
6. Create 8 Tor library folders and change permission.
sudo install -o debian-tor -g debian-tor -m 700 -d /var/lib/tor1
sudo install -o debian-tor -g debian-tor -m 700 -d /var/lib/tor2
sudo install -o debian-tor -g debian-tor -m 700 -d /var/lib/tor3
sudo install -o debian-tor -g debian-tor -m 700 -d /var/lib/tor4
sudo install -o debian-tor -g debian-tor -m 700 -d /var/lib/tor5
sudo install -o debian-tor -g debian-tor -m 700 -d /var/lib/tor6
sudo install -o debian-tor -g debian-tor -m 700 -d /var/lib/tor7
sudo install -o debian-tor -g debian-tor -m 700 -d /var/lib/tor8
 
### 7. Download new startup script for  8 instances of Tor and change permission.
sudo mv /etc/init.d/tor /etc/init.d/tor.orig
sudo wget http://terminal28.com/wp-content/uploads/2015/12/tor -O /etc/init.d/tor
sudo chmod +x /etc/init.d/tor
 
Start Tor.
sudo /etc/init.d/tor start
Usage: /etc/init.d/tor {start|stop|restart|reload|force-reload|status}
You should see 8 instances of Tor.
Raising maximum number of filedescriptors (ulimit -n) to 32768.
Starting tor daemon: tor...
tor 1 done.
tor 2 done.
tor 3 done.
tor 4 done.
tor 5 done.
tor 6 done.
tor 7 done.
tor 8 done.
 
Checking Listening Ports:
netstat -tap | grep tor
tcp        0      0 localhost:10060         *:*                     LISTEN      4037/tor
tcp        0      0 localhost:10030         *:*                     LISTEN      4028/tor
tcp        0      0 localhost:10070         *:*                     LISTEN      4040/tor
tcp        0      0 localhost:10040         *:*                     LISTEN      4031/tor
tcp        0      0 localhost:10010         *:*                     LISTEN      4022/tor
tcp        0      0 localhost:10020         *:*                     LISTEN      4025/tor
tcp        0      0 localhost:10080         *:*                     LISTEN      4027/tor
tcp        0      0 localhost:10050         *:*                     LISTEN      4035/tor
 
### 8. Configure Privoxy server.
Create 8 separated Privoxy server configfiles .
# privoxy_1.conf
sudo cat << EOT > /etc/privoxy/privoxy_1.conf
user-manual /usr/share/doc/privoxy/user-manual
confdir /etc/privoxy
actionsfile match-all.action
actionsfile default.action
actionsfile user.action
filterfile default.filter
logfile logfile
toggle 1
enable-remote-toggle 0
enable-remote-http-toggle 0
enable-edit-actions 0
enforce-blocks 0
buffer-limit 4096
forwarded-connect-retries 0
accept-intercepted-requests 0
allow-cgi-request-crunching 0
split-large-forms 0
keep-alive-timeout 5
socket-timeout 300
handle-as-empty-doc-returns-ok 1
logdir /var/log/privoxy_1
listen-address localhost:11010
forward-socks5t / 127.0.0.1:10010 .
forward         192.168.*.*/ .
forward         127.*.*.*/ .
forward         localhost/ .
EOT
# privoxy_2.conf
sudo cat << EOT > /etc/privoxy/privoxy_2.conf
user-manual /usr/share/doc/privoxy/user-manual
confdir /etc/privoxy
actionsfile match-all.action
actionsfile default.action
actionsfile user.action
filterfile default.filter
logfile logfile
toggle 1
enable-remote-toggle 0
enable-remote-http-toggle 0
enable-edit-actions 0
enforce-blocks 0
buffer-limit 4096
forwarded-connect-retries 0
accept-intercepted-requests 0
allow-cgi-request-crunching 0
split-large-forms 0
keep-alive-timeout 5
socket-timeout 300
handle-as-empty-doc-returns-ok 1
logdir /var/log/privoxy_2
listen-address localhost:11020
forward-socks5t / 127.0.0.1:10020 .
forward         192.168.*.*/ .
forward         127.*.*.*/ .
forward         localhost/ .
EOT
# privoxy_3.conf
sudo cat << EOT > /etc/privoxy/privoxy_3.conf
user-manual /usr/share/doc/privoxy/user-manual
confdir /etc/privoxy
actionsfile match-all.action
actionsfile default.action
actionsfile user.action
filterfile default.filter
logfile logfile
toggle 1
enable-remote-toggle 0
enable-remote-http-toggle 0
enable-edit-actions 0
enforce-blocks 0
buffer-limit 4096
forwarded-connect-retries 0
accept-intercepted-requests 0
allow-cgi-request-crunching 0
split-large-forms 0
keep-alive-timeout 5
socket-timeout 300
handle-as-empty-doc-returns-ok 1
logdir /var/log/privoxy_3
listen-address localhost:11030
forward-socks5t / 127.0.0.1:10030 .
forward         192.168.*.*/ .
forward         127.*.*.*/ .
forward         localhost/ .
EOT
# privoxy_4.conf
sudo cat << EOT > /etc/privoxy/privoxy_4.conf
user-manual /usr/share/doc/privoxy/user-manual
confdir /etc/privoxy
actionsfile match-all.action
actionsfile default.action
actionsfile user.action
filterfile default.filter
logfile logfile
toggle 1
enable-remote-toggle 0
enable-remote-http-toggle 0
enable-edit-actions 0
enforce-blocks 0
buffer-limit 4096
forwarded-connect-retries 0
accept-intercepted-requests 0
allow-cgi-request-crunching 0
split-large-forms 0
keep-alive-timeout 5
socket-timeout 300
handle-as-empty-doc-returns-ok 1
logdir /var/log/privoxy_4
listen-address localhost:11040
forward-socks5t / 127.0.0.1:10040 .
forward         192.168.*.*/ .
forward         127.*.*.*/ .
forward         localhost/ .
EOT
# privoxy_5.conf
sudo cat << EOT > /etc/privoxy/privoxy_5.conf
user-manual /usr/share/doc/privoxy/user-manual
confdir /etc/privoxy
actionsfile match-all.action
actionsfile default.action
actionsfile user.action
filterfile default.filter
logfile logfile
toggle 1
enable-remote-toggle 0
enable-remote-http-toggle 0
enable-edit-actions 0
enforce-blocks 0
buffer-limit 4096
forwarded-connect-retries 0
accept-intercepted-requests 0
allow-cgi-request-crunching 0
split-large-forms 0
keep-alive-timeout 5
socket-timeout 300
handle-as-empty-doc-returns-ok 1
logdir /var/log/privoxy_5
listen-address localhost:11050
forward-socks5t / 127.0.0.1:10050 .
forward         192.168.*.*/ .
forward         127.*.*.*/ .
forward         localhost/ .
EOT
# privoxy_6.conf
sudo cat << EOT > /etc/privoxy/privoxy_6.conf
user-manual /usr/share/doc/privoxy/user-manual
confdir /etc/privoxy
actionsfile match-all.action
actionsfile default.action
actionsfile user.action
filterfile default.filter
logfile logfile
toggle 1
enable-remote-toggle 0
enable-remote-http-toggle 0
enable-edit-actions 0
enforce-blocks 0
buffer-limit 4096
forwarded-connect-retries 0
accept-intercepted-requests 0
allow-cgi-request-crunching 0
split-large-forms 0
keep-alive-timeout 5
socket-timeout 300
handle-as-empty-doc-returns-ok 1
logdir /var/log/privoxy_6
listen-address localhost:11060
forward-socks5t / 127.0.0.1:10060 .
forward         192.168.*.*/ .
forward         127.*.*.*/ .
forward         localhost/ .
EOT
# privoxy_7.conf
sudo cat << EOT > /etc/privoxy/privoxy_7.conf
user-manual /usr/share/doc/privoxy/user-manual
confdir /etc/privoxy
actionsfile match-all.action
actionsfile default.action
actionsfile user.action
filterfile default.filter
logfile logfile
toggle 1
enable-remote-toggle 0
enable-remote-http-toggle 0
enable-edit-actions 0
enforce-blocks 0
buffer-limit 4096
forwarded-connect-retries 0
accept-intercepted-requests 0
allow-cgi-request-crunching 0
split-large-forms 0
keep-alive-timeout 5
socket-timeout 300
handle-as-empty-doc-returns-ok 1
logdir /var/log/privoxy_7
listen-address localhost:11070
forward-socks5t / 127.0.0.1:10070 .
forward         192.168.*.*/ .
forward         127.*.*.*/ .
forward         localhost/ .
EOT
# privoxy_8.conf
sudo cat << EOT > /etc/privoxy/privoxy_8.conf
user-manual /usr/share/doc/privoxy/user-manual
confdir /etc/privoxy
actionsfile match-all.action
actionsfile default.action
actionsfile user.action
filterfile default.filter
logfile logfile
toggle 1
enable-remote-toggle 0
enable-remote-http-toggle 0
enable-edit-actions 0
enforce-blocks 0
buffer-limit 4096
forwarded-connect-retries 0
accept-intercepted-requests 0
allow-cgi-request-crunching 0
split-large-forms 0
keep-alive-timeout 5
socket-timeout 300
handle-as-empty-doc-returns-ok 1
logdir /var/log/privoxy_8
listen-address localhost:11080
forward-socks5t / 127.0.0.1:10080 .
forward         192.168.*.*/ .
forward         127.*.*.*/ .
forward         localhost/ .
EOT
### 9. Create 8 log folders for Privoxy server.
'sudo install -o privoxy -g nogroup -m 750 -d /var/log/privoxy_1'
'sudo install -o privoxy -g nogroup -m 750 -d /var/log/privoxy_2'
'sudo install -o privoxy -g nogroup -m 750 -d /var/log/privoxy_3'
'sudo install -o privoxy -g nogroup -m 750 -d /var/log/privoxy_4'
'sudo install -o privoxy -g nogroup -m 750 -d /var/log/privoxy_5'
'sudo install -o privoxy -g nogroup -m 750 -d /var/log/privoxy_6'
'sudo install -o privoxy -g nogroup -m 750 -d /var/log/privoxy_7'
'sudo install -o privoxy -g nogroup -m 750 -d /var/log/privoxy_8'
 
### 10. Download new startup script for 8 instances of Privoxy server and change permission.
'sudo mv /etc/init.d/privoxy /etc/init.d/privoxy.orig'
'sudo wget http://raw/privoxy -O /etc/init.d/privoxy'
'sudo chmod +x /etc/init.d/privoxy'
'sudo update-rc.d privoxy defaults'
 
Start Privoxy server.
'sudo /etc/init.d/privoxy start'
Usage: /etc/init.d/privoxy {start|stop|restart|force-reload|status}
 
Checking Listening Ports
netstat -tap | grep privoxy
tcp        0      0 localhost:11010          *:*                     LISTEN      1968/privoxy
tcp        0      0 localhost:11050          *:*                     LISTEN      2072/privoxy
tcp        0      0 localhost:11040          *:*                     LISTEN      1431/privoxy
tcp        0      0 localhost:11080          *:*                     LISTEN      1543/privoxy
tcp        0      0 localhost:11070          *:*                     LISTEN      1484/privoxy
tcp        0      0 localhost:11060          *:*                     LISTEN      1558/privoxy
tcp        0      0 localhost:11020          *:*                     LISTEN      1512/privoxy
tcp        0      0 localhost:10030          *:*                     LISTEN      1590/privoxy
 
### 11. Configure Squid3 server
Edit configfile: /etc/squid/squid3.conf and add these records:
'sudo nano /etc/squid3/squid.conf'

cache_peer localhost parent 11010 0 default no-query no-delay no-digest no-netdb-exchange round-robin'
cache_peer localhost_2 parent 11020 0 default no-query no-delay no-digest no-netdb-exchange round-robin'
cache_peer localhost_3 parent 11030 0 default no-query no-delay no-digest no-netdb-exchange round-robin'
cache_peer localhost_4 parent 11040 0 default no-query no-delay no-digest no-netdb-exchange round-robin'
cache_peer localhost_5 parent 11050 0 default no-query no-delay no-digest no-netdb-exchange round-robin'
cache_peer localhost_6 parent 11060 0 default no-query no-delay no-digest no-netdb-exchange round-robin'
cache_peer localhost_7 parent 11070 0 default no-query no-delay no-digest no-netdb-exchange round-robin'
cache_peer localhost_8 parent 11080 0 default no-query no-delay no-digest no-netdb-exchange round-robin'
always_direct deny all
 
Start Squid3 server.
Rebuild Squid3 server cache.
'sudo /etc/init.d/squid3 stop'
'sudo squid3 -f /etc/squid3/squid.conf -z'
'sudo /etc/init.d/squid3 start'
 
### 12. Configure hosts file.
Configure host file and add  these records:
'sudo nano /etc/hosts'
127.0.0.1 localhost # 
127.0.0.1 localhost_2
127.0.0.1 localhost_3
127.0.0.1 localhost_4
127.0.0.1 localhost_5
127.0.0.1 localhost_6
127.0.0.1 localhost_7
127.0.0.1 localhost_8
 
13. Restart networking service.
Restart networking service to apply new records in hosts file.
sudo service networking restart


#### From http://terminal28.com/anonymity-online-how-to-install-and-configure-squid3-tor-privoxy-debian-ubuntu-linux/
