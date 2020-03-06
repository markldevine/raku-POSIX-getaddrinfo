#!/usr/bin/env raku

use Data::Dump::Tree;
#use POSIX::getaddrinfo :Get-Addr-Info;
#use POSIX::getaddrinfo :Get-Addr-Info-IPV4-STREAM;
#use POSIX::getaddrinfo :Get-Addr-Info-IPV4-STREAM-IPAddrs;
#use POSIX::getaddrinfo :Get-Addr-Info-IPV4-STREAM-Names;
use POSIX::getaddrinfo :ALL;

unit sub MAIN (
    Str:D   :$host is required,     #= host to resolve
);

put 'Get-Addr-Info'; ddt Get-Addr-Info($host);
put 'Get-Addr-Info-IPV4-STREAM'; ddt Get-Addr-Info-IPV4-STREAM($host);
put 'Get-Addr-Info-IPV4-STREAM-IPAddrs'; ddt Get-Addr-Info-IPV4-STREAM-IPAddrs($host);
put 'Get-Addr-Info-IPV4-STREAM-Names'; ddt Get-Addr-Info-IPV4-STREAM-Names($host);

=finish
