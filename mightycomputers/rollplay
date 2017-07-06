https://mightycomputers.wordpress.com/2012/09/10/recently-i-foun/
Recently I found a great blogpost that describes this how to however unfortunately this guide was made for gentoo linux. I have been using debian for my personal sever uses for some time. So I took the steps from the blog post and modified the configuration files to match current versions in apt-get and to be compatible with debian. Since debian is pretty popular especially since its the base for the successful Ubuntu distro I thought it was a good post for the first of many MightyComputers tutorials

 

Versions/Requirements at time of writing.

O/S: Debian v6.03 (I assume Ubuntu will also work)
Tor: 0.2.2.35
Privoxy: 3.0.16
bash: any version I have 4.1.5
python: any version I have 2.6.6
Squid Cache: Version 2.7.STABLE9


A diagram of our goal

The easiest way to get started is to run apt-get install tor privoxy squid this will install all three programs. Also it will start them right away so you’ll need to stop/kill them before starting the new versions you will setup. It’s a good idea to go ahead and elevate to root level permissions so you can easily create/modify the files you need.

Next we will make the /etc/tor/torrc-1 to /etc/tor/torrc-8 configuration files

This is the code they all have in common


SocksBindAddress 127.0.0.1 # accept connections only from localhost
AllowUnverifiedNodes middle,rendezvous
Log notice syslog
RunAsDaemon 1
User debian-tor
CircuitBuildTimeout 30
NumEntryGuards 6
KeepalivePeriod 60
NewCircuitPeriod 15

and these are the options that differ

torrc-1
SocksPort 9050 # what port to open for local application connections
DataDirectory /var/lib/tor1
PidFile /var/run/tor/tor-1.pid

torrc-2
SocksPort 9150
ControlPort 9151
DataDirectory /var/lib/tor2
PidFile /var/run/tor/tor-2.pid

torrc-3
SocksPort 9250
ControlPort 9251
DataDirectory /var/lib/tor3
PidFile /var/run/tor/tor-3.pid

torrc-4
SocksPort 9350
ControlPort 9351
DataDirectory /var/lib/tor4
PidFile /var/run/tor/tor-4.pid

torrc-5
SocksPort 9450
ControlPort 9451
DataDirectory /var/lib/tor5
PidFile /var/run/tor/tor-5.pid

torrc-6
SocksPort 9550
ControlPort 9551
DataDirectory /var/lib/tor6
PidFile /var/run/tor/tor-6.pid

torrc-7
SocksPort 9650
ControlPort 9651
DataDirectory /var/lib/tor7
PidFile /var/run/tor/tor-7.pid

torrc-8
SocksPort 9750
ControlPort 9751
DataDirectory /var/lib/tor8
PidFile /var/run/tor/tor-8.pid
Next make the lib directories by running install -o debian-tor -g debian-tor -m 700 -d /var/lib/tor1 through install -o debian-tor -g debian-tor -m 700 -d /var/lib/tor8

now you’ll want to overwrite your /etc/init.d/tor file with the one linked here (of course you’ll need to remove the .txt)

now that tor is done go ahead and run /etc/init.d/tor start to ensure everything is up and running.

With tor up and running we can move onto privoxy which will be used as a middle man for squid and tor allowing squid to connect to tor’s socks proxy

as with tor we will be using 8 config files for privoxy to use for its 8 instances the file names should be /etc/privoxy/config-1 through /etc/privoxy/config-8

The following is the code they all have in common


user-manual /usr/share/doc/privoxy/user-manual
confdir /etc/privoxy
actionsfile match-all.action # Actions that are applied to all sites and maybe overruled later on.
actionsfile default.action # Main actions file
actionsfile user.action # User customizations
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

I went ahead and enabled logging just in case something didn’t work and the directory’s are listed in the different lines below

config-1
logdir /var/log/privoxy1
listen-address localhost:8118
forward-socks5 / 127.0.0.1:9050 .

config-2
logdir /var/log/privoxy2
listen-address localhost:8129
forward-socks5 / 127.0.0.1:9150 .

config-3
logdir /var/log/privoxy3
listen-address localhost:8230
forward-socks5 / 127.0.0.1:9250 .

torrc-4
logdir /var/log/privoxy4
listen-address localhost:8321
forward-socks5 / 127.0.0.1:9350 .

config-5
logdir /var/log/privoxy5
listen-address localhost:8421
forward-socks5 / 127.0.0.1:9450 .

config-6
logdir /var/log/privoxy6
listen-address localhost:8522
forward-socks5 / 127.0.0.1:9550 .

config-7
logdir /var/log/privoxy7
listen-address localhost:8623
forward-socks5 / 127.0.0.1:9650 .

config-8
logdir /var/log/privoxy8
listen-address localhost:8724
forward-socks5 / 127.0.0.1:9750 .
Next make the log directories by running install -o privoxy -g nogroup -m 750 -d /var/log/privoxy1 through install -o privoxy -g nogtoup -m 750 -d /var/lib/privoxy8

now you’ll want to overwrite your /etc/init.d/tor file with the one linked here(of course you’ll need to remove the .txt from this one as well)

Now that privoxy is done go ahead and run /etc/init.d/privoxy start and ensure it worked by using netstat –listen and look for the open ports.

Now for the “easy” part squid

next configure squid with the following config file located in /etc/squid/squid.conf


acl all src all
acl manager proto cache_object
acl localhost src 127.0.0.1/32
acl home_network src 192.168.2.0/24
acl to_localhost dst 127.0.0.0/8
acl SSL_ports port 443
acl Safe_ports port 80 # http
acl Safe_ports port 21 # ftp
acl Safe_ports port 443 # https
acl Safe_ports port 70 # gopher
acl Safe_ports port 210 # wais
acl Safe_ports port 1025-65535 # unregistered ports
acl Safe_ports port 280 # http-mgmt
acl Safe_ports port 488 # gss-http
acl Safe_ports port 591 # filemaker
acl Safe_ports port 777 # multiling http
acl Safe_ports port 901 # SWAT
acl purge method PURGE
acl CONNECT method CONNECT
http_access allow home_network
http_access allow manager localhost
http_access deny manager
http_access allow purge localhost
http_access deny purge
http_access deny !Safe_ports
http_access deny CONNECT !SSL_ports
acl malware_domains url_regex '/etc/squid/Malware-domains.txt'
http_access deny malware_domains
http_access allow localhost
http_access deny all
icp_access deny all
http_port 3400
icp_port 0
hierarchy_stoplist cgi-bin ?
refresh_pattern ^ftp: 1440 20% 10080
refresh_pattern ^gopher: 1440 0% 1440
refresh_pattern -i (/cgi-bin/|\?) 0 0% 0
refresh_pattern . 0 20% 4320
cache_peer localhost parent 8118 0 round-robin no-query
cache_peer localhost2 parent 8129 0 round-robin no-query
cache_peer localhost3 parent 8230 0 round-robin no-query
cache_peer localhost4 parent 8321 0 round-robin no-query
cache_peer localhost5 parent 8421 0 round-robin no-query
cache_peer localhost6 parent 8522 0 round-robin no-query
cache_peer localhost7 parent 8623 0 round-robin no-query
cache_peer localhost8 parent 8724 0 round-robin no-query
never_direct allow all
always_direct deny all
acl apache rep_header Server ^Apache
broken_vary_encoding allow apache
forwarded_for off
coredump_dir /home/squid-cache # where squid stores the cache
cache_dir ufs /home/squid-cache 20000 16 256 # cache-size in MB, Directory-Structure 1, Directory-Structure below 1
pid_filename /var/run/squid-in.pid
access_log /var/log/squid/access.squid-in.log
cache_store_log /var/log/squid/store.squid-in.log
cache_log /var/log/squid/cache.squid-in.log

Next make the squid cache directory by running the following command install -o proxy -g proxy -m 755 -d /home/squid-cache

Next we want to check on the squid logdir mine was all setup but to be sure ensure /var/log/squid exists and has proxy:proxy ownership

Now we need to add some lines to /etc/hosts, so that squid can be fooled with eight entities of privoxy
127.0.0.1 localhost
127.0.0.1 localhost2
127.0.0.1 localhost3
127.0.0.1 localhost4
127.0.0.1 localhost5
127.0.0.1 localhost6
127.0.0.1 localhost7
127.0.0.1 localhost8

Next I am sure you noticed the squid.conf file used something called Malware-domains.txt this file just adds a little extra protection to our proxy you are on the evil internet after all

go ahead and run touch /etc/squid/Malware-domains.txt

next download the following file update-domains.tar.gz
perform the following to extract and initialize this file with a bunch of bad domains

# tar -xzvf update-domains.tar.gz -C /usr/local/bin
# cd /usr/local/bin
# chmod +x update-domains.sh
# ./update-domains.sh

Now that everything is done you should be all set go ahead and startup squid which will bind to port 3400. You’ll need to configure your browser to connect to port 3400 I find foxyproxy to be a really good tool to allow me to switch between the open net and my proxy server.