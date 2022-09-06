# DNS Performance Test

Shell script to test the performance of the most popular DNS resolvers from your location. 
Modified slightly to better test resolvers in Australia, for popular sites in Australia.

Includes by default:
 * CloudFlare 1.1.1.3
 * Google 8.8.8.8
 * Quad9 9.9.9.9
 * OpenDNS
 * Norton
 * CleanBrowsing
 * Neustar
 * Comodo
 * NextDNS
 * TPG
 * Telstra
 * Microplex
 * Sprintlink
 * Verizon
 * Controld
 * dnsfilter
 * safedns

# Required 

You need to install bc and dig. 

For Ubuntu:

```
 $ sudo apt-get install bc dnsutils
```

For macOS using homebrew:

```
 $ brew install bc bind
```

# Utilization

``` 
 $ git clone --depth=1 https://github.com/greeneroutlook/dnsperftest/ --branch resolveAU
 $ cd dnsperftest
 $ bash ./dnstest.sh 
DNS Name / Tests >   1       2       3       4       5       6       7       8       9       10      Average	IP Address
cloudflare           20 ms   20 ms   20 ms   33 ms   19 ms   23 ms   20 ms   20 ms   20 ms   21 ms     21.60	1.1.1.3
google               18 ms   19 ms   17 ms   17 ms   18 ms   18 ms   17 ms   23 ms   18 ms   16 ms     18.10	8.8.8.8
quad9                17 ms   30 ms   131 ms  18 ms   18 ms   18 ms   17 ms   197 ms  18 ms   17 ms     48.10	9.9.9.9
opendns              111 ms  18 ms   17 ms   17 ms   18 ms   31 ms   17 ms   42 ms   30 ms   30 ms     33.10	208.67.222.123
norton               18 ms   117 ms  319 ms  19 ms   18 ms   21 ms   114 ms  20 ms   18 ms   18 ms     68.20	199.85.126.20
cleanbrowsing        17 ms   18 ms   19 ms   19 ms   18 ms   17 ms   18 ms   17 ms   18 ms   17 ms     17.80	185.228.168.168
neustar              18 ms   24 ms   165 ms  22 ms   18 ms   20 ms   18 ms   18 ms   19 ms   17 ms     33.90	156.154.70.3
comodo-nuse          18 ms   18 ms   18 ms   18 ms   112 ms  20 ms   18 ms   18 ms   25 ms   18 ms     28.30	8.26.56.26
nextds               17 ms   17 ms   17 ms   18 ms   17 ms   18 ms   18 ms   26 ms   17 ms   17 ms     18.20	45.90.28.202
tpg                  18 ms   22 ms   25 ms   17 ms   18 ms   19 ms   18 ms   18 ms   181 ms  123 ms    45.90	203.12.160.35
telstra              127 ms  18 ms   212 ms  168 ms  17 ms   149 ms  147 ms  144 ms  17 ms   87 ms     108.60	139.130.4.4
microplex            142 ms  165 ms  157 ms  151 ms  161 ms  162 ms  160 ms  165 ms  47 ms   30 ms     134.00	211.31.132.28
sprintlink           17 ms   17 ms   18 ms   17 ms   17 ms   259 ms  17 ms   17 ms   259 ms  17 ms     65.50	204.97.212.10
verizon              19 ms   19 ms   19 ms   19 ms   22 ms   20 ms   19 ms   18 ms   33 ms   18 ms     20.60	203.2.193.67
controld             111 ms  29 ms   120 ms  20 ms   19 ms   134 ms  20 ms   112 ms  20 ms   244 ms    82.90	76.76.2.0
dnsfilter            18 ms   17 ms   18 ms   17 ms   18 ms   17 ms   17 ms   18 ms   17 ms   17 ms     17.40	103.247.36.36
safedns              112 ms  34 ms   335 ms  36 ms   17 ms   33 ms   33 ms   47 ms   18 ms   125 ms    79.00	195.46.39.39
```

To sort with the fastest first, add `sort -k 22 -n` at the end of the command:

```
  $ bash ./dnstest.sh |sort -k 22 -n
DNS Name / Tests >   1       2       3       4       5       6       7       8       9       10      Average	IP Address
telstra              17 ms   16 ms   17 ms   17 ms   17 ms   17 ms   17 ms   21 ms   17 ms   17 ms     17.30	139.130.4.4
nextdns              17 ms   18 ms   17 ms   17 ms   17 ms   19 ms   17 ms   18 ms   18 ms   17 ms     17.50	45.90.28.202
cleanbrowsing        18 ms   17 ms   17 ms   17 ms   19 ms   19 ms   19 ms   20 ms   19 ms   18 ms     18.30	185.228.168.168
comodo-nuse          20 ms   22 ms   18 ms   17 ms   19 ms   21 ms   20 ms   49 ms   22 ms   18 ms     22.60	8.26.56.26
verizon              46 ms   18 ms   18 ms   18 ms   23 ms   24 ms   20 ms   22 ms   20 ms   27 ms     23.60	203.2.193.67
cloudflare           20 ms   19 ms   20 ms   32 ms   18 ms   21 ms   21 ms   24 ms   19 ms   122 ms    31.60	1.1.1.3
quad9                17 ms   24 ms   17 ms   18 ms   18 ms   30 ms   19 ms   46 ms   18 ms   120 ms    32.70	9.9.9.9
neustar              18 ms   18 ms   18 ms   19 ms   19 ms   20 ms   19 ms   156 ms  26 ms   17 ms     33.00	156.154.70.3
google               157 ms  20 ms   17 ms   20 ms   18 ms   21 ms   17 ms   22 ms   20 ms   19 ms     33.10	8.8.8.8
tpg                  20 ms   19 ms   18 ms   18 ms   18 ms   17 ms   19 ms   18 ms   181 ms  18 ms     34.60	203.12.160.35
norton               18 ms   18 ms   17 ms   18 ms   17 ms   19 ms   148 ms  55 ms   20 ms   17 ms     34.70	199.85.126.20
opendns              110 ms  18 ms   18 ms   17 ms   17 ms   43 ms   22 ms   53 ms   30 ms   31 ms     35.90	208.67.222.123
microplex            29 ms   31 ms   29 ms   29 ms   32 ms   48 ms   33 ms   53 ms   48 ms   29 ms     36.10	211.31.132.28
controld             18 ms   19 ms   25 ms   23 ms   18 ms   113 ms  193 ms  115 ms  21 ms   173 ms    71.80	76.76.2.0
safedns              149 ms  18 ms   147 ms  18 ms   146 ms  144 ms  19 ms   246 ms  20 ms   26 ms     93.30	195.46.39.39
dnsfilter            18 ms   146 ms  153 ms  149 ms  18 ms   94 ms   146 ms  18 ms   150 ms  150 ms    104.20	103.247.36.36
sprintlink           17 ms   18 ms   18 ms   17 ms   18 ms   259 ms  354 ms  291 ms  259 ms  19 ms     127.00	204.97.212.10
```

To test using the IPv6 addresses, add the IPv6 option:

```
  $ bash ./dnstest.sh ipv6| sort -k 22 -n
                     test1   test2   test3   test4   test5   test6   test7   test8   test9   test10  Average 
cleanbrowsing-v6     1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.00
cloudflare-v6        1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    5 ms    1 ms    1 ms    1 ms      1.40
quad9-v6             1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    21 ms     3.00
8.8.8.8              7 ms    1 ms    16 ms   1 ms    1 ms    24 ms   1 ms    8 ms    1 ms    7 ms      6.70
neustar-v6           1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    60 ms     6.90
opendns-v6           1 ms    1 ms    1 ms    1 ms    1 ms    62 ms   1 ms    1 ms    29 ms   1 ms      9.90
google-v6            8 ms    8 ms    7 ms    8 ms    14 ms   67 ms   1 ms    7 ms    8 ms    61 ms     18.90
```

To test both IPv6 and IPv4, add the "all" option:
```
  $ bash ./dnstest.sh all| sort -k 22 -n
                     test1   test2   test3   test4   test5   test6   test7   test8   test9   test10  Average 
cleanbrowsing        1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.00
cleanbrowsing-v6     1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.00
cloudflare-v6        1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.00
neustar              1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.00
nextdns              1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.00
quad9-v6             1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.00
cloudflare           1 ms    1 ms    1 ms    1 ms    1 ms    2 ms    1 ms    1 ms    1 ms    1 ms      1.10
quad9                1 ms    1 ms    1 ms    2 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.10
google               1 ms    1 ms    6 ms    1 ms    1 ms    6 ms    1 ms    7 ms    9 ms    7 ms      4.00
8.8.8.8              6 ms    1 ms    25 ms   1 ms    1 ms    6 ms    1 ms    7 ms    1 ms    7 ms      5.60
neustar-v6           1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    64 ms     7.30
opendns-v6           7 ms    1 ms    21 ms   8 ms    1 ms    1 ms    1 ms    6 ms    1 ms    29 ms     7.60
opendns              1 ms    1 ms    27 ms   27 ms   1 ms    67 ms   1 ms    6 ms    1 ms    27 ms     15.90
comodo               1 ms    1 ms    1 ms    1 ms    4 ms    1 ms    1 ms    1 ms    1 ms    150 ms    16.20
google-v6            7 ms    6 ms    33 ms   7 ms    7 ms    87 ms   7 ms    8 ms    8 ms    25 ms     19.50
level3               27 ms   26 ms   25 ms   27 ms   27 ms   25 ms   27 ms   27 ms   25 ms   28 ms     26.40
norton               28 ms   26 ms   28 ms   26 ms   26 ms   28 ms   27 ms   27 ms   27 ms   27 ms     27.00
adguard-v6           52 ms   54 ms   55 ms   56 ms   52 ms   52 ms   52 ms   53 ms   53 ms   54 ms     53.30
adguard              58 ms   58 ms   58 ms   58 ms   60 ms   58 ms   60 ms   60 ms   58 ms   60 ms     58.80
freenom              140 ms  140 ms  140 ms  145 ms  135 ms  140 ms  140 ms  140 ms  140 ms  134 ms    139.40
yandex-v6            178 ms  179 ms  178 ms  179 ms  178 ms  178 ms  178 ms  179 ms  179 ms  205 ms    181.10
yandex               178 ms  178 ms  177 ms  179 ms  178 ms  174 ms  180 ms  178 ms  179 ms  222 ms    182.30

```


# For Windows users using the Linux subsystem

If you receive an error `$'\r': command not found`, convert the file to a Linux-compatible line endings using:

    tr -d '\15\32' < dnstest.sh > dnstest-2.sh
    
Then run `bash ./dnstest-2.sh`
