# Tests for Sending TCP Segments Having the SYN-bit Set

## Description
This set of tests focuses on the sending of SYN-segments moving the state of the TCP connection from `CLOSED` to `SYN-SENT`
and possibly to `CLOSED` again.

The list of socket options with level `IPPROTO_TCP` affecting this behaviour is:
* `TCP_KEEPINIT`
* `TCP_NOOPT`

The list of `sysctl`-variables affecting the sending of SYN-segments is
* `net.inet.tcp.keepinit`
* `net.inet.tcp.rexmit_drop_options`
* `net.inet.tcp.sack.enable`
* `net.inet.tcp.rfc1323`
* `kern.ipc.maxsockbuf`
* `net.inet.tcp.ecn.enable`
* `net.inet.tcp.ecn.maxretries`

## Status

| Name                                                                                                                                                                                                                                  | Result FreeBSD 11.0 | Result FreeBSD Head |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[snd-syn-with-default-options-ipv4](snd-syn-with-default-options-ipv4.pkt "Ensure that the default options are used")                                                                                                                  | Unknown             | Passed              |
|[snd-syn-with-default-options-ipv6](snd-syn-with-default-options-ipv6.pkt "Ensure that the default options are used")                                                                                                                  | Unknown             | Passed              |
|[snd-syn-without-options-ipv4](snd-syn-without-options-ipv4.pkt "Ensure that no options are used when using the TCP_NOOPT socket option")                                                                                              | Unknown             | Passed              |
|[snd-syn-without-options-ipv6](snd-syn-without-options-ipv6.pkt "Ensure that no options are used when using the TCP_NOOPT socket option")                                                                                              | Unknown             | Passed              |
|[snd-syn-rtx-keepinit-ipv4](snd-syn-rtx-keepinit-ipv4.pkt "Ensure that the keepinit timer is honored when limiting the retransmissions of SYN-segments")                                                                               | Unknown             | Passed              |
|[snd-syn-rtx-keepinit-ipv6](snd-syn-rtx-keepinit-ipv6.pkt "Ensure that the keepinit timer is honored when limiting the retransmissions of SYN-segments")                                                                               | Unknown             | Passed              |
|[snd-syn-rtx-max-number-ipv4](snd-syn-rtx-max-number-ipv4.pkt "Ensure that the maximum number is honored when limiting the retransmissions of SYN-segments")                                                                           | Unknown             | Passed              |
|[snd-syn-rtx-max-number-ipv6](snd-syn-rtx-max-number-ipv6.pkt "Ensure that the maximum number is honored when limiting the retransmissions of SYN-segments")                                                                           | Unknown             | Passed              |
|[snd-syn-rtx-drop-options-ipv4](snd-syn-rtx-drop-options-ipv4.pkt "Ensure that the options are dropped when the sysctl variable rexmit_drop_options is 1")                                                                             | Unknown             | Passed  (Note 1)    |
|[snd-syn-rtx-drop-options-ipv6](snd-syn-rtx-drop-options-ipv6.pkt "Ensure that the options are dropped when the sysctl variable rexmit_drop_options is 1")                                                                             | Unknown             | Passed  (Note 1)    |
|[snd-syn-mss-inherited-from-mtu-72-ipv4](snd-syn-mss-inherited-from-mtu-72-ipv4.pkt "Ensure that the MSS option inherits the appropriate value from an interface MTU of 72 bytes")                                                     | Unknown             | Passed              |
|[snd-syn-mss-inherited-from-mtu-9000-ipv4](snd-syn-mss-inherited-from-mtu-9000-ipv4.pkt "Ensure that the MSS option inherits the appropriate value from an interface MTU of 9000 bytes")                                               | Unknown             | Passed              |
|[snd-syn-mss-inherited-from-mtu-65535-ipv4](snd-syn-mss-inherited-from-mtu-65535-ipv4.pkt "Ensure that the MSS option inherits the appropriate value from an interface MTU of 65535 bytes")                                            | Unknown             | Passed              |
|[snd-syn-mss-inherited-from-mtu-1280-ipv6](snd-syn-mss-inherited-from-mtu-1280-ipv6.pkt "Ensure that the MSS option inherits the appropriate value from an interface MTU of 1280 bytes")                                                     | Unknown             | Passed              |
|[snd-syn-mss-inherited-from-mtu-9000-ipv6](snd-syn-mss-inherited-from-mtu-9000-ipv6.pkt "Ensure that the MSS option inherits the appropriate value from an interface MTU of 9000 bytes")                                               | Unknown             | Passed              |
|[snd-syn-mss-inherited-from-mtu-65535-ipv6](snd-syn-mss-inherited-from-mtu-65535-ipv6.pkt "Ensure that the MSS option inherits the appropriate value from an interface MTU of 65535 bytes")                                            | Unknown             | Failed  (Note 2)    |
|[snd-syn-without-sack-ipv4](snd-syn-without-sack-ipv4.pkt "Ensure that the option indicating SACK support is not included when the sysctl variable sack.enable is 0")                                                                  | Unknown             | Passed              |
|[snd-syn-without-sack-ipv6](snd-syn-without-sack-ipv6.pkt "Ensure that the option indicating SACK support is not included when the sysctl variable sack.enable is 0")                                                                  | Unknown             | Passed              |
|[snd-syn-without-ws-and-ts-ipv4](snd-syn-without-ws-and-ts-ipv4.pkt "Ensure that the options indicating window scaling and time stamp support are not included when the sysctl variable rfc1323 is 0")                                 | Unknown             | Passed              |
|[snd-syn-without-ws-and-ts-ipv6](snd-syn-without-ws-and-ts-ipv6.pkt "Ensure that the options indicating window scaling and time stamp support are not included when the sysctl variable rfc1323 is 0")                                 | Unknown             | Passed              |
|[snd-syn-without-sack-and-ws-and-ts-ipv4](snd-syn-without-sack-and-ws-and-ts-ipv4.pkt "Ensure that the options indicating SACK support, window scaling and time stamp support are not included when the sysctl variable rfc1323 is 0") | Unknown             | Passed              |
|[snd-syn-without-sack-and-ws-and-ts-ipv6](snd-syn-without-dack-and-ws-and-ts-ipv6.pkt "Ensure that the options indicating SACK support, window scaling and time stamp support are not included when the sysctl variable rfc1323 is 0") | Unknown             | Passed              |
|[snd-syn-with-min-ws-ipv4](snd-syn-with-min-ws-ipv4.pkt "Ensure that the window scale factor of 1 is used when the sysctl variable kern.ipc.maxsockbuf is set to 73728")                                                               | Unknown             | Passed              |
|[snd-syn-with-min-ws-ipv6](snd-syn-with-min-ws-ipv6.pkt "Ensure that the window scale factor of 1 is used when the sysctl variable kern.ipc.maxsockbuf is set to 73728")                                                               | Unknown             | Passed              |
|[snd-syn-with-max-ws-ipv4](snd-syn-with-max-ws-ipv4.pkt "Ensure that the window scale factor of 14 is used when the sysctl variable kern.ipc.maxsockbuf is set to 4294967295")                                                         | Unknown             | Passed              |
|[snd-syn-with-max-ws-ipv6](snd-syn-with-max-ws-ipv6.pkt "Ensure that the window scale factor of 14 is used when the sysctl variable kern.ipc.maxsockbuf is set to 4294967295")                                                         | Unknown             | Passed              |
|[snd-syn-with-ecn-ipv4](snd-syn-with-ecn-ipv4.pkt "Ensure that ECN support is signalled when the sysctl variable ecn.enable is 2")                                                                                                     | Unknown             | Passed              |
|[snd-syn-with-ecn-ipv6](snd-syn-with-ecn-ipv6.pkt "Ensure that ECN support is signalled when the sysctl variable ecn.enable is 2")                                                                                                     | Unknown             | Passed              |
|[snd-syn-with-ecn-alt-maxretries-ipv4](snd-syn-with-ecn-alt-maxretries-ipv4.pkt "Ensure that ECN support is signalled when the sysctl variable ecn.enable is 2 and ecn.maxretries is honored")                                         | Unknown             | Passed              |
|[snd-syn-with-ecn-alt-maxretries-ipv6](snd-syn-with-ecn-alt-maxretries-ipv6.pkt "Ensure that ECN support is signalled when the sysctl variable ecn.enable is 2 and ecn.maxretries is honored")                                         | Unknown             | Passed              |

## Notes
1. The sysctl variable `net.inet.tcp.rexmit_drop_options` is not described in the `TCP(4)` man page. The description
   of the sysctl variable (when displayed with `sysctl -d net.inet.tcp.rexmit_drop_options` states that no options
   will be used from the third and later retransmits of the SYN-segment. However, the MSS option is not dropped.
   Either change the code or change the documentation and add an entry to the man page.
2. The MSS is based on an MTU of 9000 bytes.
