http://wiki.vpsget.com/index.php/Squid%2BPrivoxy%2BTor

Squid+Privoxy+Tor
How to install squid with tor
[NOTE: According to vpsget.com AUP/TOS you can use private proxy servers with authentication and tor allowed in "client-only" mode.]

You can also configure auth. like specified: http://wiki.vpsget.com/index.php/Squid_with_authentication_on_Centos_6
Tested on Centos 6.8
Installing squid, privoxy and tor
yum update
yum install epel-release
yum install squid privoxy tor
Config files.
Squid: /etc/squid/squid.conf
acl manager proto cache_object
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl ftp proto FTP
acl localnet src 10.0.0.0/8     # RFC1918 possible internal network
acl localnet src 172.16.0.0/12  # RFC1918 possible internal network
acl localnet src 192.168.0.0/16 # RFC1918 possible internal network
acl localnet src fc00::/7       # RFC 4193 local private network range
acl localnet src fe80::/10      # RFC 4291 link-local (directly plugged) machines

acl SSL_ports port 443
acl Safe_ports port 80          # http
acl Safe_ports port 21          # ftp
acl Safe_ports port 443         # https
acl Safe_ports port 70          # gopher
acl Safe_ports port 210         # wais
acl Safe_ports port 1025-65535  # unregistered ports
acl Safe_ports port 280         # http-mgmt
acl Safe_ports port 488         # gss-http
acl Safe_ports port 591         # filemaker
acl Safe_ports port 777         # multiling http
acl Safe_ports port 3128
acl CONNECT method CONNECT

http_access allow manager localhost
http_access deny manager

http_access deny !Safe_ports

http_access deny CONNECT !SSL_ports

http_access allow localhost
http_access allow all

http_port 3128

hierarchy_stoplist cgi-bin ?

cache_peer 127.0.0.1 parent 8118 7 no-query no-digest

coredump_dir /var/spool/squid

refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320


httpd_suppress_version_string on
forwarded_for off
always_direct allow ftp
never_direct allow all
Privoxy: /etc/privoxy/config
forward-socks4a / 127.0.0.1:9050 .
confdir /etc/privoxy
logdir /var/log/privoxy
actionsfile default.action   # Main actions file
actionsfile user.action      # User customizations
filterfile default.filter

logfile logfile

debug   4096 # Startup banner and warnings
debug   8192 # Errors - *we highly recommended enabling this*

user-manual /usr/share/doc/privoxy/user-manual
listen-address  127.0.0.1:8118
toggle  1
enable-remote-toggle 0
enable-edit-actions 0
enable-remote-http-toggle 0
buffer-limit 4096
Tor: /etc/tor/torrc
SocksPort 9050 # what port to open for local application connections
SocksBindAddress 127.0.0.1 # accept connections only from localhost
AllowUnverifiedNodes middle,rendezvous
Log notice syslog
Now start services
service squid start
service privoxy start
service tor start

Make sure you have opened squid port in iptables.
Refer to this guide regarding configuring SQUID Auth. : http://wiki.vpsget.com/index.php/Squid_with_authentication_on_Centos_6
""
