use     NativeCall;
use     POSIX::getaddrinfo::Constants;
unit    module POSIX::getaddrinfo:api<0.1.0>:auth<Mark Devine (mark@markdevine.com)>;
 
class sockaddr is repr('CStruct') {
    has uint16 $.sa_family;
}
 
class sockaddr-in is repr('CStruct') {
    has int16  $.sin_family;
    has uint16 $.sin_port;
    has uint32 $.sin_addr;
 
    method address {
        my $buf = buf8.allocate(INET_ADDRSTRLEN);
        inet_ntop(AF_INET, Pointer.new(nativecast(Pointer,self)+4), $buf, INET_ADDRSTRLEN)
    }
}
 
class sockaddr-in6 is repr('CStruct') {
    has uint16 $.sin6_family;
    has uint16 $.sin6_port;
    has uint32 $.sin6_flowinfo;
    has uint64 $.sin6_addr0;
    has uint64 $.sin6_addr1;
    has uint32 $.sin6_scope_id;
 
    method address {
        my $buf = buf8.allocate(INET6_ADDRSTRLEN);
        inet_ntop(AF_INET6, Pointer.new(nativecast(Pointer,self)+8), $buf, INET6_ADDRSTRLEN)
    }
}
 
class addrinfo is repr('CStruct') {
    has int32    $.ai_flags;
    has int32    $.ai_family;
    has int32    $.ai_socktype;
    has int32    $.ai_protocol;
    has uint32   $.ai_addrNativeCalllen;
    has sockaddr $.ai_addr is rw;
    has Str      $.ai_canonname is rw;
    has addrinfo $.ai_next is rw;
 
    method flags {
        do for addrinfo-Flags.enums { .key if $!ai_flags +& .value }
    }
 
    method family {
        addrinfo-Family($!ai_family)
    }
 
    method socktype {
        addrinfo-Socktype($!ai_socktype)
    }
 
    method address {
        given $.family {
            when AF_INET {
                nativecast(sockaddr-in, $!ai_addr).address
            }
            when AF_INET6 {
                nativecast(sockaddr-in6, $!ai_addr).address
            }
        }
    }
}

sub inet_ntop (int32, Pointer, Blob, int32 --> Str)
    is native {}
 
sub getaddrinfo (Str $node, Str $service, addrinfo $hints, Pointer $res is rw --> int32)
    is native is export(:getaddrinfo) {};
 
sub freeaddrinfo (Pointer)
    is native is export(:getaddrinfo) {};

#   Perl 6 convenience interfaces

class Get-Addr-Info-Record {
    has Str $.canonname;
    has Str $.family;
    has Str $.socktype;
    has Str $.address;
}
 
sub Get-Addr-Info (Str:D $node is required, addrinfo :$hint is copy --> Array:D) is export(:Get-Addr-Info) {
    my @Get-Addr-Info-Records;
    $hint = addrinfo.new(:ai_flags(AI_CANONNAME)) unless $hint ~~ addrinfo:D;
    my Pointer  $res  .= new;
    if &getaddrinfo($node, Str, $hint, $res) {
        freeaddrinfo($res);
        return Array.new();
    }
    my $addr = nativecast(addrinfo, $res);
    my ($canonname, $family, $socktype, $address);
    while $addr {
        with $addr {
            $canonname = $_ with .ai_canonname;
            $family     = .family.Str;
            $socktype   = .socktype.Str;
            $address    = .address;
            $addr       = .ai_next;
            @Get-Addr-Info-Records.push: Get-Addr-Info-Record.new(:$canonname, :$family, :$socktype, :$address);
        }
    }
    freeaddrinfo($res);
    return @Get-Addr-Info-Records;
}

sub Get-Addr-Info-IPV4-STREAM (Str:D $host is required --> Array) is export(:Get-Addr-Info-IPV4-STREAM) {
    my addrinfo $hint .= new(
        :ai_flags(AI_CANONNAME),
        :ai_family(AF_INET),
        :ai_socktype(SOCK_STREAM),
    );
    &Get-Addr-Info($host, :$hint);
}

sub Get-Addr-Info-IPV4-STREAM-IPAddrs (Str:D $host is required --> Array) is export(:Get-Addr-Info-IPV4-STREAM-IPAddrs) {
    my addrinfo $hint .= new(
        :ai_flags(AI_CANONNAME),
        :ai_family(AF_INET),
        :ai_socktype(SOCK_STREAM),
    );
    my @gai = &Get-Addr-Info($host, :$hint);
    my @ipaddrs;
    for @gai -> $gai {
        @ipaddrs.push: $gai.address;
    }
    return @ipaddrs;
}

sub Get-Addr-Info-IPV4-STREAM-Names (Str:D $host is required --> Array) is export(:Get-Addr-Info-IPV4-STREAM-Names) {
    my addrinfo $hint .= new(
        :ai_flags(AI_CANONNAME),
        :ai_family(AF_INET),
        :ai_socktype(SOCK_STREAM),
    );
    my @gai = &Get-Addr-Info($host, :$hint);
    my @canonnames;
    for @gai -> $gai {
        @canonnames.push: $gai.canonname;
    }
    return @canonnames;
}

=finish
