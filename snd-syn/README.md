# Tests for Sending TCP Segments Having the SYN-bit Set

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
1. Whend using `getsockopt()` with the level `IPPROTO_TCP` and name `TCP_KEEPINIT` the value 0 instead of the actual
   value used is returned when the default value inherited from the sysctl variable `net.inet.tcp.keepinit` is used.
   A similar bug exists for using `getsockopt()` with the name `TCP_KEEPIDLE`, `TCP_KEEPINTVL`, and `TCP_KEEPCNT`.
