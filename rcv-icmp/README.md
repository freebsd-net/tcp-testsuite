# Tests for Handling ICMP Messages

## Description

This set of tests focuses on the handling of ICMP messages in the `SYN-SENT` state.

The list of `sysctl`-variables affecting the sending of SYN-segments is
* `net.inet.tcp.icmp_may_rst`

## Status

| Name                                                                                                                                                                                                                                  | Result FreeBSD 11.0 | Result FreeBSD Head |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-icmp-hard-error-proto-unreachable-ipv4](rcv-icmp-hard-error-proto-unreachable-ipv4.pkt "Ensure that reception of ICMP Protocol Unreachable message is a hard error when the sysctl variable icmp_may_rst is 1")                   | Unknown             | Passed              |
|[rcv-icmp-hard-error-proto-unreachable-ipv6](rcv-icmp-hard-error-proto-unreachable-ipv6.pkt "Ensure that reception of ICMP Protocol Unreachable message is a hard error when the sysctl variable icmp_may_rst is 1")                   | Unknown             | Passed  (Note 1)    |
|[rcv-icmp-hard-error-port-unreachable-ipv4](rcv-icmp-hard-error-port-unreachable-ipv4.pkt "Ensure that reception of ICMP Port Unreachable message is a hard error when the sysctl variable icmp_may_rst is 1")                         | Unknown             | Passed              |
|[rcv-icmp-hard-error-port-unreachable-ipv6](rcv-icmp-hard-error-port-unreachable-ipv6.pkt "Ensure that reception of ICMP Port Unreachable message is a hard error when the sysctl variable icmp_may_rst is 1")                         | Unknown             | Passed              |
|[rcv-icmp-hard-error-net-prohibited-ipv4](rcv-icmp-hard-error-net-prohibited-ipv4.pkt "Ensure that reception of ICMP Comm. Dest. Net Adm. Prohibited message is a hard error when the sysctl variable icmp_may_rst is 1")              | Unknown             | Passed  (Note 2)    |
|[rcv-icmp-hard-error-host-prohibited-ipv4](rcv-icmp-hard-error-host-prohibited-ipv4.pkt "Ensure that reception of ICMP Comm. Dest. Host Adm. Prohibited message is a hard error when the sysctl variable icmp_may_rst is 1")           | Unknown             | Passed  (Note 2)    |
|[rcv-icmp-hard-error-comm-prohibited-ipv4](rcv-icmp-hard-error-comm-prohibited-ipv4.pkt "Ensure that reception of ICMP Comm. Adm. Prohibited message is a hard error when the sysctl variable icmp_may_rst is 1")                      | Unknown             | Passed  (Note 2)    |
|[rcv-icmp-hard-error-comm-prohibited-ipv6](rcv-icmp-hard-error-comm-prohibited-ipv6.pkt "Ensure that reception of ICMP Comm. Adm. Prohibited message is a hard error when the sysctl variable icmp_may_rst is 1")                      | Unknown             | Passed  (Note 1)    |
|[rcv-icmp-hard-error-ttl-exceeded-ipv4](rcv-icmp-hard-error-ttl-exceeded-ipv4.pkt "Ensure that reception of ICMP TTL Exceeded in Transit message is a hard error when the sysctl variable icmp_may_rst is 1")                          | Unknown             | Passed  (Note 3)    |
|[rcv-icmp-hard-error-ttl-exceeded-ipv6](rcv-icmp-hard-error-ttl-exceeded-ipv6.pkt "Ensure that reception of ICMP TTL Exceeded in Transit message is a hard error when the sysctl variable icmp_may_rst is 1")                          | Unknown             | Passed  (Note 1)    |
|[rcv-icmp-hard-error-ignored-ipv4](rcv-icmp-hard-error-ignored-ipv4.pkt "Ensure that reception of any ICMP message does not result in a hard error when the sysctl variable icmp_may_rst is 0")                                        | Unknown             | Passed  (Note 4)    |
|[rcv-icmp-hard-error-ignored-ipv6](rcv-icmp-hard-error-ignored-ipv6.pkt "Ensure that reception of any ICMP message does not result in a hard error when the sysctl variable icmp_may_rst is 0")                                        | Unknown             | Passed  (Note 4)    |

## Notes
1. The TCP connection stays alive. This should not be the case since
   [r303626](https://svnweb.freebsd.org/base?view=revision&revision=303626) ([D7272](https://reviews.freebsd.org/D7272)).
   Fixed in [r307726](https://svnweb.freebsd.org/changeset/base/307726) ([D7904](https://reviews.freebsd.org/D7904)).
2. The reception is handled by FreeBSD as a hard error, allthough neither specified as a soft or hard error
   [RFC1122](https://tools.ietf.org/html/rfc1122#section-4.2.3.9).
3. The reception is handled by FreeBSD as a hard error, allthough specified in
   [RFC1122](https://tools.ietf.org/html/rfc1122#section-4.2.3.9) as a soft error.
4. An incoming PTB packet results in an adapted MSS for IPv6, but not for IPv4.
