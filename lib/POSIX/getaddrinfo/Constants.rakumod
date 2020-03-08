unit    module POSIX::getaddrinfo::Contants:api<1>:auth<Mark Devine (mark@markdevine.com)>;
 
constant \INET_ADDRSTRLEN       is export = 16;
constant \INET6_ADDRSTRLEN      is export = 46;
 
enum addrinfo-Family is export (
    AF_UNSPEC                   => 0;
    AF_INET                     => 2;
    AF_INET6                    => 10;
);
 
enum addrinfo-Socktype is export (
    SOCK_STREAM                 => 1;
    SOCK_DGRAM                  => 2;
    SOCK_RAW                    => 3;
    SOCK_RDM                    => 4;
    SOCK_SEQPACKET              => 5;
    SOCK_DCCP                   => 6;
    SOCK_PACKET                 => 10;
);
 
enum addrinfo-Flags is export (
    AI_PASSIVE                  => 0x0001;
    AI_CANONNAME                => 0x0002;
    AI_NUMERICHOST              => 0x0004;
    AI_V4MAPPED                 => 0x0008;
    AI_ALL                      => 0x0010;
    AI_ADDRCONFIG               => 0x0020;
    AI_IDN                      => 0x0040;
    AI_CANONIDN                 => 0x0080;
    AI_IDN_ALLOW_UNASSIGNED     => 0x0100;
    AI_IDN_USE_STD3_ASCII_RULES => 0x0200;
    AI_NUMERICSERV              => 0x0400;
);

=finish
