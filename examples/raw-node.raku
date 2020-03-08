#!/usr/bin/env raku

use NativeCall;
use POSIX::getaddrinfo :getaddrinfo;
use POSIX::getaddrinfo::Constants;

sub MAIN(Str:D $node is required) {
    my POSIX::getaddrinfo::addrinfo $hint .= new(:ai_flags(AI_CANONNAME));
    my Pointer $res .= new;
    my $rv = getaddrinfo($node, Str, $hint, $res);
    say "return val: $rv";
    if ! $rv {
        my $addr = nativecast(POSIX::getaddrinfo::addrinfo, $res);
        while $addr {
            with $addr {
                say "Name: ", $_ with .ai_canonname;
                say .family, ' ', .socktype;
                say .address;
                $addr = .ai_next;
            }
        }
    }
    freeaddrinfo($res);
}
