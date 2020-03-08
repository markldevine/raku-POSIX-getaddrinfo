NAME
====
POSIX::getaddrinfo

Description
===========
The POSIX getaddrinfo() function resolves host names into IP addresses & canonical names, among other things.

[Short tutorial on calling a C function](https://docs.raku.org/language/nativecall#Short_tutorial_on_calling_a_C_function)
demonstrates the creation of an interface to this standard library function using NativeCall.

This module extends that idea by adding raku-friendly interfaces.

Synopsis
========

Get-Addr-Info()
---------------
```raku
use POSIX::getaddrinfo  :Get-Addr-Info;

Get-Addr-Info('localhost');

#   [6] @0
#   ├ 0 = .POSIX::getaddrinfo::Get-Addr-Info-Record @1
#   │ ├ $.cannonname = localhost.Str
#   │ ├ $.family = AF_INET6.Str
#   │ ├ $.socktype = SOCK_STREAM.Str
#   │ └ $.address = ::1.Str
#   ├ 1 = .POSIX::getaddrinfo::Get-Addr-Info-Record @2
#   │ ├ $.cannonname = localhost.Str
#   │ ├ $.family = AF_INET6.Str
#   │ ├ $.socktype = SOCK_DGRAM.Str
#   │ └ $.address = ::1.Str
#   ├ 2 = .POSIX::getaddrinfo::Get-Addr-Info-Record @3
#   │ ├ $.cannonname = localhost.Str
#   │ ├ $.family = AF_INET6.Str
#   │ ├ $.socktype = SOCK_RAW.Str
#   │ └ $.address = ::1.Str
#   ├ 3 = .POSIX::getaddrinfo::Get-Addr-Info-Record @4
#   │ ├ $.cannonname = localhost.Str
#   │ ├ $.family = AF_INET.Str
#   │ ├ $.socktype = SOCK_STREAM.Str
#   │ └ $.address = 127.0.0.1.Str
#   ├ 4 = .POSIX::getaddrinfo::Get-Addr-Info-Record @5
#   │ ├ $.cannonname = localhost.Str
#   │ ├ $.family = AF_INET.Str
#   │ ├ $.socktype = SOCK_DGRAM.Str
#   │ └ $.address = 127.0.0.1.Str
#   └ 5 = .POSIX::getaddrinfo::Get-Addr-Info-Record @6
#     ├ $.cannonname = localhost.Str
#     ├ $.family = AF_INET.Str
#     ├ $.socktype = SOCK_RAW.Str
#   └ $.address = 127.0.0.1.Str
```

Get-Addr-Info-IPV4-STREAM()
---------------------------
```raku
use POSIX::getaddrinfo :Get-Addr-Info-IPV4-STREAM;

Get-Addr-Info-IPV4-STREAM('services');

#   [1] @0
#   └ 0 = .POSIX::getaddrinfo::Get-Addr-Info-Record @1
#     ├ $.cannonname = services.Str
#     ├ $.family = AF_INET.Str
#     ├ $.socktype = SOCK_STREAM.Str
#     └ $.address = 192.168.1.159.Str
```

Get-Addr-Info-IPV4-STREAM-IPAddrs()
-----------------------------------
```raku
use POSIX::getaddrinfo :Get-Addr-Info-IPV4-STREAM-IPAddrs;

Get-Addr-Info-IPV4-STREAM-IPAddrs('services');

#   1] @0
#   └ 0 = 192.168.1.159.Str
```

Get-Addr-Info-IPV4-STREAM-Names()
---------------------------------
```raku
use POSIX::getaddrinfo :Get-Addr-Info-IPV4-STREAM-Names;

Get-Addr-Info-IPV4-STREAM-Names('myserver'); # DNS serving 'mydomain.com'

#   1] @0
#   └ 0 = myserver.mydomain.com.Str
```

Citation
========
Taken almost verbatim (and augmented) from raku.org documentation, [Short tutorial on calling a C function](https://docs.raku.org/language/nativecall#Short_tutorial_on_calling_a_C_function).

AUTHOR
======
Mark Devine <mark@markdevine.com>
