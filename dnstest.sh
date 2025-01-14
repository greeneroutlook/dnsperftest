#!/usr/bin/env bash


command -v bc > /dev/null || { echo "error: bc was not found. Please install bc."; exit 1; }
{ command -v drill > /dev/null && dig=drill; } || { command -v dig > /dev/null && dig=dig; } || { echo "error: dig was not found. Please install dnsutils."; exit 1; }


NAMESERVERS=$(grep ^nameserver /etc/resolv.conf | cut -d " " -f 2 | sed 's/\(.*\)/&#&/')

PROVIDERSV4="
1.1.1.3#cloudflare 
4.2.2.1#level3
8.8.8.8#google
9.9.9.9#quad9
80.80.80.80#freenom
208.67.222.123#opendns
199.85.126.20#norton
185.228.168.168#cleanbrowsing
77.88.8.7#yandex
176.103.130.132#adguard
156.154.70.3#neustar
8.26.56.26#comodo
45.90.28.202#nextdns
"

PROVIDERSV6="
2606:4700:4700::1113#cloudflare-v6
2001:4860:4860::8888#google-v6
2620:fe::fe#quad9-v6
2620:119:35::35#opendns-v6
2a0d:2a00:1::1#cleanbrowsing-v6
2a02:6b8::feed:0ff#yandex-v6
2a00:5a60::ad1:0ff#adguard-v6
2610:a1:1018::3#neustar-v6
"

# Testing for IPv6
if $dig +short +tries=1 +time=2 +stats @2a0d:2a00:1::1 dns.google |grep 8.8.8.8 >/dev/null 2>&1; then
    hasipv6="true"
fi

providerstotest=$PROVIDERSV4

if [ "$1" = "ipv6" ]; then
    if [ -z "$hasipv6" ]; then
        echo "error: IPv6 support not found. Unable to do the ipv6 test."; exit 1;
    fi
    providerstotest=$PROVIDERSV6

elif [ "$1" = "ipv4" ]; then
    providerstotest=$PROVIDERSV4

elif [ "$1" = "all" ]; then
    if [ "$hasipv6" = "" ]; then
        providerstotest=$PROVIDERSV4
    else
        providerstotest="$PROVIDERSV4 $PROVIDERSV6"
    fi
else
    providerstotest=$PROVIDERSV4
fi


# Domains to test. Duplicated domains are ok
DOMAINS2TEST="www.google.com amazon.com facebook.com www.youtube.com www.reddit.com wikipedia.org twitter.com gmail.com www.google.com whatsapp.com"


totaldomains=0
printf "%-21s" "DNS Name / Tests >"
for d in $DOMAINS2TEST; do
    totaldomains=$((totaldomains + 1))
    printf "%-8s" "$totaldomains"
done
printf "%-8s" "Average	IP Address"
echo ""


for p in $NAMESERVERS $providerstotest; do
    pip=${p%%#*}
    pname=${p##*#}
    ftime=0

    printf "%-21s" "$pname"
    for d in $DOMAINS2TEST; do
      ttime=$($dig +tries=1 +time=2 +stats "@$pip" "$d" |grep "Query time:" | cut -d : -f 2- | cut -d " " -f 2)
        if [ -z "$ttime" ]; then
	        #let's have time out be 1s = 1000ms
	        ttime=1000
        elif [ "$ttime" = "0" ]; then
	        ttime=1
	    fi

        printf "%-8s" "$ttime ms"
        ftime=$((ftime + ttime))
    done
    avg=$(bc -lq <<< "scale=2; $ftime/$totaldomains")

    echo "  $avg	$pip"
done


exit 0;
