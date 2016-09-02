# Tests for Sending TCP Segments Having the SYN-bit Set

The following table shows the status of the tests:

| Name                                                                                                                                          | Result FreeBSD 11.0 | Result FreeBSD Head |
|:----------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[snd-syn-with-default-options-ipv4](snd-syn-with-default-options-ipv4.pkt "Ensure that the default options are used")                          | Unknown             | Passed              |
|[snd-syn-with-default-options-ipv6](snd-syn-with-default-options-ipv6.pkt "Ensure that the default options are used")                          | Unknown             | Passed              |
|[snd-syn-without-options-ipv4](snd-syn-without-options-ipv4.pkt "Ensure that no options are used when using the TCP_NOOPT socket option")      | Unknown             | Passed              |
|[snd-syn-without-options-ipv6](snd-syn-without-options-ipv6.pkt "Ensure that no options are used when using the TCP_NOOPT socket option")      | Unknown             | Passed              |

# Notes
