# Tests for Sending TCP Segments Having the SYN-bit Set

This set of tests focuses on the sending of SYN-segments moving to state of the TCP connection from `CLOSED` to `SYN-SENT`
possibly to `CLOSED` again.
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

The following table shows the status of the tests:

| Name                                                                                                                                                                            | Result FreeBSD 11.0 | Result FreeBSD Head |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[snd-syn-with-default-options-ipv4](snd-syn-with-default-options-ipv4.pkt "Ensure that the default options are used")                                                            | Unknown             | Passed              |
|[snd-syn-with-default-options-ipv6](snd-syn-with-default-options-ipv6.pkt "Ensure that the default options are used")                                                            | Unknown             | Passed              |
|[snd-syn-without-options-ipv4](snd-syn-without-options-ipv4.pkt "Ensure that no options are used when using the TCP_NOOPT socket option")                                        | Unknown             | Passed              |
|[snd-syn-without-options-ipv6](snd-syn-without-options-ipv6.pkt "Ensure that no options are used when using the TCP_NOOPT socket option")                                        | Unknown             | Passed              |
|[snd-syn-keepinit-inherited-from-sysctl-ipv4](snd-syn-keepinit-inherited-from-sysctl-ipv4.pkt "Ensure that the keepinit timeout is inherited from the keepinit sysctl variable") | Unknown             | Passed  (Note 1)    |
|[snd-syn-keepinit-inherited-from-sysctl-ipv6](snd-syn-keepinit-inherited-from-sysctl-ipv6.pkt "Ensure that the keepinit timeout is inherited from the keepinit sysctl variable") | Unknown             | Passed  (Note 1)    |

# Notes
1. When using `getsockopt()` with the level `IPPROTO_TCP` and name `TCP_KEEPINIT`, the value 0 instead of the actual
   value used is returned when the default value inherited from the sysctl variable `net.inet.tcp.keepinit` is used.
   A similar bug exists for using `getsockopt()` with the name `TCP_KEEPIDLE`, `TCP_KEEPINTVL`, and `TCP_KEEPCNT`.
2. The sysctl variable `net.inet.tcp.rexmit_drop_options` is not described in the `TCP(4)` man page. The description
   of the sysctl variable (when displayed with `sysctl -d net.inet.tcp.rexmit_drop_options` states that no options
   will be used from the third and later retransmits of the SYN-segment. However, the MSS option is not dropped.
   Either change the code or change the documentation and add an entry to the man page.
