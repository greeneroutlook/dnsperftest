#!/usr/bin/env bash

command -v expr > /dev/null || { echo "expr was not found. Please install expr."; exit 1; }
{ command -v drill > /dev/null && dig=drill; } || { command -v dig > /dev/null && dig=dig; } || { echo "dig was not found. Please install dnsutils."; exit 1; }


# Local DNS resolvers
NAMESERVERS=`cat /etc/resolv.conf | grep ^nameserver | cut -d " " -f 2 | sed 's/\(.*\)/&#&/'`

# Upstream DNS resolvers
# Non-standard ports may be specified e.g. 127.0.0.1:5353#mydns
PROVIDERS="
103.247.36.36#dnsfilter
1.1.1.3#cloudflare
9.9.9.9#quad9
208.67.222.123#opendns
199.85.126.20#norton
185.228.168.168#cleanbrowsing
156.154.70.3#neustar
8.26.56.26#comodo-nuse
45.90.28.202#nextdns
203.12.160.35#tpg
139.130.4.4#telstra
211.31.132.28#microplex
204.97.212.10#sprintlink
203.2.193.67#verizon
76.76.2.0#controld
195.46.39.39#safedns
8.8.8.8#google
"

# Number of domains to test
NUM_DOMAINS2TEST=20

# Random domains to choose from
#RANDOM_DOMAINS=(
#`curl -sS https://raw.githubusercontent.com/opendns/public-domain-lists/master/opendns-top-domains.txt`
#`curl -sS https://raw.githubusercontent.com/opendns/public-domain-lists/master/opendns-random-domains.txt`
#)

RANDOM_DOMAINS=(
    `shuf -n 20 AU.txt`
)
echo "$RANDOM_DOMAINS"
heading="DOMAINS TO TEST: "; echo -n "$heading"
results_indent=$((${#heading} - 3))
results_tempfile=`mktemp`
domains2test=""
num_random_domains=${#RANDOM_DOMAINS[*]}

for ((i=1; i <= $NUM_DOMAINS2TEST; i++)); do
    if [ $i -gt 1 ]; then
        printf "%-${#heading}s" ""
    fi

    domain_id=`printf "%5s" "($i) "`; echo -n "$domain_id"
    domain_heading="   $domain_id"
    results_header="$results_header$domain_heading"
    random_domain=${RANDOM_DOMAINS[$RANDOM % num_random_domains]}; echo $random_domain
    domains2test="$domains2test $random_domain"
done

avg_heading="  AVERAGE"
results_header="$results_header$avg_heading"
printf "\n%-${results_indent}s" ""
echo "$results_header"

for p in $PROVIDERS $NAMESERVERS; do
    pip=${p%%#*}
    [[ "$pip" =~ [:] ]] && pip="${pip%%:*} -p ${pip##*:}"
    pname=${p##*#}
    ftime=0

    printf "%-${results_indent}s" "$pname"
    for d in $domains2test; do
        ttime=`$dig +tries=1 +time=2 +stats @${pip/:/" -p"} $d | grep "Query time:" | cut -d : -f 2- | cut -d " " -f 2`
        if [ -z "$ttime" ]; then
            #let's have time out be 1s = 1000ms
            ttime=100 #eliminate bias of shitty webpages noone will visit anyway
        elif [ "x$ttime" = "x0" ]; then
            ttime=1
        fi

        printf "%${#domain_heading}s" "$ttime ms"
        ftime=$((ftime + ttime))
    done
    avg=$(expr $ftime / $NUM_DOMAINS2TEST)

    printf "%${#avg_heading}s" $avg | tee -a $results_tempfile
    printf "\n"
    printf "ms ........................... $pname\n" >> $results_tempfile
done

echo -e "\n$(date) TOP:" | tee -a /reports/${0##*/}.log
#echo "$results_header"
sort -n $results_tempfile | tee -a /reports/${0##*/}.log
rm $results_tempfile