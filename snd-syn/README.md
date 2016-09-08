# Tests for Sending TCP Segments Having the SYN-bit Set

This set of tests focuses on the sending of SYN-segments moving to state of the TCP connection from `CLOSED` to `SYN-SENT`
and possibly to `CLOSED` again.

The list of socket options with level `IPPROTO_TCP` affecting this behaviour is:
* `TCP_KEEPINIT`
* `TCP_NOOPT`
* `TCP_MAXSEG`

The list of `sysctl`-variables affecting the sending of SYN-segments is
* `net.inet.tcp.keepinit`
* `net.inet.tcp.rexmit_drop_options`
* `net.inet.tcp.icmp_may_rst`
* `net.inet.tcp.mssdflt`
* `net.inet.tcp.v6mssdflt`
* `net.inet.tcp.sack.enable`
* `net.inet.tcp.rfc1323`
* `kern.ipc.maxsockbuf`
* `net.inet.tcp.ecn.enable`
* `net.inet.tcp.ecn.maxretries`

The following table shows the status of the tests:

| Name                                                                                                                                                                                                                                | Result FreeBSD 11.0 | Result FreeBSD Head |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[snd-syn-with-default-options-ipv4](snd-syn-with-default-options-ipv4.pkt "Ensure that the default options are used")                                                                                                                | Unknown             | Passed              |
|[snd-syn-with-default-options-ipv6](snd-syn-with-default-options-ipv6.pkt "Ensure that the default options are used")                                                                                                                | Unknown             | Passed              |
|[snd-syn-without-options-ipv4](snd-syn-without-options-ipv4.pkt "Ensure that no options are used when using the TCP_NOOPT socket option")                                                                                            | Unknown             | Passed              |
|[snd-syn-without-options-ipv6](snd-syn-without-options-ipv6.pkt "Ensure that no options are used when using the TCP_NOOPT socket option")                                                                                            | Unknown             | Passed              |
|[snd-syn-keepinit-inherited-from-sysctl-ipv4](snd-syn-keepinit-inherited-from-sysctl-ipv4.pkt "Ensure that the keepinit timeout is inherited from the sysctl variable keepinit")                                                     | Unknown             | Passed  (Note 1)    |
|[snd-syn-keepinit-inherited-from-sysctl-ipv6](snd-syn-keepinit-inherited-from-sysctl-ipv6.pkt "Ensure that the keepinit timeout is inherited from the sysctl variable keepinit")                                                     | Unknown             | Passed  (Note 1)    |
|[snd-syn-rtx-keepinit-ipv4](snd-syn-rtx-keepinit-ipv4.pkt "Ensure that the keepinit timer is honored when limiting the retransmissions of SYN-segments")                                                                             | Unknown             | Passed              |
|[snd-syn-rtx-keepinit-ipv6](snd-syn-rtx-keepinit-ipv6.pkt "Ensure that the keepinit timer is honored when limiting the retransmissions of SYN-segments")                                                                             | Unknown             | Passed              |
|[snd-syn-rtx-max-number-ipv4](snd-syn-rtx-max-number-ipv4.pkt "Ensure that the maximum number is honored when limiting the retransmissions of SYN-segments")                                                                         | Unknown             | Passed              |
|[snd-syn-rtx-max-number-ipv6](snd-syn-rtx-max-number-ipv6.pkt "Ensure that the maximum number is honored when limiting the retransmissions of SYN-segments")                                                                         | Unknown             | Passed              |
|[snd-syn-rtx-drop-options-ipv4](snd-syn-rtx-drop-options-ipv4.pkt "Ensure that the options are dropped when the sysctl variable rexmit_drop_options is 1")                                                                           | Unknown             | Passed  (Note 2)    |
|[snd-syn-rtx-drop-options-ipv6](snd-syn-rtx-drop-options-ipv6.pkt "Ensure that the options are dropped when the sysctl variable rexmit_drop_options is 1")                                                                           | Unknown             | Passed  (Note 2)    |
|[snd-syn-icmp-hard-error-proto-unreachable-ipv4](snd-syn-icmp-hard-error-proto-unreachable-ipv4.pkt "Ensure that reception of ICMP Protocol Unreachable message is a hard error when the sysctl variable icmp_may_rst is 1")         | Unknown             | Passed              |
|[snd-syn-icmp-hard-error-proto-unreachable-ipv6](snd-syn-icmp-hard-error-proto-unreachable-ipv6.pkt "Ensure that reception of ICMP Protocol Unreachable message is a hard error when the sysctl variable icmp_may_rst is 1")         | Unknown             | Failed  (Note 5)    |
|[snd-syn-icmp-hard-error-port-unreachable-ipv4](snd-syn-icmp-hard-error-port-unreachable-ipv4.pkt "Ensure that reception of ICMP Port Unreachable message is a hard error when the sysctl variable icmp_may_rst is 1")               | Unknown             | Passed              |
|[snd-syn-icmp-hard-error-port-unreachable-ipv6](snd-syn-icmp-hard-error-port-unreachable-ipv6.pkt "Ensure that reception of ICMP Port Unreachable message is a hard error when the sysctl variable icmp_may_rst is 1")               | Unknown             | Passed              |
|[snd-syn-icmp-hard-error-net-prohibited-ipv4](snd-syn-icmp-hard-error-net-prohibited-ipv4.pkt "Ensure that reception of ICMP Comm. Dest. Net Adm. Prohibited message is a hard error when the sysctl variable icmp_may_rst is 1")    | Unknown             | Passed  (Note 3)    |
|[snd-syn-icmp-hard-error-host-prohibited-ipv4](snd-syn-icmp-hard-error-host-prohibited-ipv4.pkt "Ensure that reception of ICMP Comm. Dest. Host Adm. Prohibited message is a hard error when the sysctl variable icmp_may_rst is 1") | Unknown             | Passed  (Note 3)    |
|[snd-syn-icmp-hard-error-comm-prohibited-ipv4](snd-syn-icmp-hard-error-comm-prohibited-ipv4.pkt "Ensure that reception of ICMP Comm. Adm. Prohibited message is a hard error when the sysctl variable icmp_may_rst is 1")            | Unknown             | Passed  (Note 3)    |
|[snd-syn-icmp-hard-error-comm-prohibited-ipv6](snd-syn-icmp-hard-error-comm-prohibited-ipv6.pkt "Ensure that reception of ICMP Comm. Adm. Prohibited message is a hard error when the sysctl variable icmp_may_rst is 1")            | Unknown             | Failed  (Note 5)    |
|[snd-syn-icmp-hard-error-ttl-exceeded-ipv4](snd-syn-icmp-hard-error-ttl-exceeded-ipv4.pkt "Ensure that reception of ICMP TTL Exceeded in Transit message is a hard error when the sysctl variable icmp_may_rst is 1")                | Unknown             | Passed  (Note 4)    |
|[snd-syn-icmp-hard-error-ttl-exceeded-ipv6](snd-syn-icmp-hard-error-ttl-exceeded-ipv6.pkt "Ensure that reception of ICMP TTL Exceeded in Transit message is a hard error when the sysctl variable icmp_may_rst is 1")                | Unknown             | Failed  (Note 5)    |
|[snd-syn-icmp-hard-error-ignored-ipv4](snd-syn-icmp-hard-error-ignored-ipv4.pkt "Ensure that reception of any ICMP message does not result in a hard error when the sysctl variable icmp_may_rst is 0")                              | Unknown             | Passed  (Note 6)    |
|[snd-syn-icmp-hard-error-ignored-ipv6](snd-syn-icmp-hard-error-ignored-ipv6.pkt "Ensure that reception of any ICMP message does not result in a hard error when the sysctl variable icmp_may_rst is 0")                              | Unknown             | Passed  (Note 6)    |
|[snd-syn-without-sack-ipv4](snd-syn-without-sack-ipv4.pkt "Ensure that the option indicating SACK support is not included when the sysctl variable sack.enable is 0")                                                                | Unknown             | Passed              |
|[snd-syn-without-sack-ipv6](snd-syn-without-sack-ipv6.pkt "Ensure that the option indicating SACK support is not included when the sysctl variable sack.enable is 0")                                                                | Unknown             | Passed              |
|[snd-syn-without-ws-and-ts-ipv4](snd-syn-without-ws-and-ts-ipv4.pkt "Ensure that the options indicating window scaling and time stamp support is not included when the sysctl variable rfc1323 is 0")                                | Unknown             | Passed              |
|[snd-syn-without-ws-and-ts-ipv6](snd-syn-without-ws-and-ts-ipv6.pkt "Ensure that the options indicating window scaling and time stamp support is not included when the sysctl variable rfc1323 is 0")                                | Unknown             | Passed              |
|[snd-syn-with-min-ws-ipv4](snd-syn-with-min-ws-ipv4.pkt "Ensure that the window scale factor of 1 is used when the sysctl variable kern.ipc.maxsockbuf is set to 73728")                                                             | Unknown             | Passed              |
|[snd-syn-with-min-ws-ipv6](snd-syn-with-min-ws-ipv6.pkt "Ensure that the window scale factor of 1 is used when the sysctl variable kern.ipc.maxsockbuf is set to 73728")                                                             | Unknown             | Passed              |
|[snd-syn-with-max-ws-ipv4](snd-syn-with-max-ws-ipv4.pkt "Ensure that the window scale factor of 14 is used when the sysctl variable kern.ipc.maxsockbuf is set to 4294967295")                                                                                                   | Unknown             | Passed              |
|[snd-syn-with-max-ws-ipv6](snd-syn-with-max-ws-ipv6.pkt "Ensure that the window scale factor of 14 is used when the sysctl variable kern.ipc.maxsockbuf is set to 4294967295")                                                                                                   | Unknown             | Passed              |
|[snd-syn-with-ecn-ipv4](snd-syn-with-ecn-ipv4.pkt "Ensure that ECN support is signalled when the sysctl variable ecn.enable is 2")                                                                                                   | Unknown             | Passed              |
|[snd-syn-with-ecn-ipv6](snd-syn-with-ecn-ipv6.pkt "Ensure that ECN support is signalled when the sysctl variable ecn.enable is 2")                                                                                                   | Unknown             | Passed              |
|[snd-syn-with-ecn-alt-maxretries-ipv4](snd-syn-with-ecn-alt-maxretries-ipv4.pkt "Ensure that ECN support is signalled when the sysctl variable ecn.enable is 2 and ecn.maxretries is honored")                                       | Unknown             | Passed              |
|[snd-syn-with-ecn-alt-maxretries-ipv6](snd-syn-with-ecn-alt-maxretries-ipv6.pkt "Ensure that ECN support is signalled when the sysctl variable ecn.enable is 2 and ecn.maxretries is honored")                                       | Unknown             | Passed              |

# Notes
1. When using `getsockopt()` with the level `IPPROTO_TCP` and name `TCP_KEEPINIT`, the value 0 instead of the actual
   value used is returned when the default value inherited from the sysctl variable `net.inet.tcp.keepinit` is used.
   A similar bug exists for using `getsockopt()` with the name `TCP_KEEPIDLE`, `TCP_KEEPINTVL`, and `TCP_KEEPCNT`.
2. The sysctl variable `net.inet.tcp.rexmit_drop_options` is not described in the `TCP(4)` man page. The description
   of the sysctl variable (when displayed with `sysctl -d net.inet.tcp.rexmit_drop_options` states that no options
   will be used from the third and later retransmits of the SYN-segment. However, the MSS option is not dropped.
   Either change the code or change the documentation and add an entry to the man page.
3. The reception is handled by FreeBSD as a hard error, allthough neither specified as a soft or hard error
   [RFC1122](https://tools.ietf.org/html/rfc1122#section-4.2.3.9).
4. The reception is handled by FreeBSD as a hard error, allthough specified in
   [RFC1122](https://tools.ietf.org/html/rfc1122#section-4.2.3.9) as a soft error.
5. The TCP connection stays alive. This should not be the case since [r303626](https://svnweb.freebsd.org/base?view=revision&revision=303626) ([D7272](https://reviews.freebsd.org/D7272)).
6. An incoming PTB packet results in an adapted MSS for IPv6, but not for IPv4.
