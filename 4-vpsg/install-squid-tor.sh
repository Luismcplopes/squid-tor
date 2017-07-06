#!/bin/bash
yum update
yum install epel-release
yum install squid privoxy tor
service squid start
service privoxy start
service tor start