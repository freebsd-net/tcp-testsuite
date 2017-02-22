# Handling of TCP Segments with the RST-bit Set in the SYN-SENT State

## Description
This set of tests focuses on the handling of RST-segments in the `SYN-SENT` state.

[RFC 0793](https://tools.ietf.org/html/rfc0793) requires RST-segments to be
ignored.

## Status

| Name                                                                                                                                                                          | Result FreeBSD 11.0 | Result FreeBSD Head |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-rst-without-data-syn-sent-ipv4](rcv-rst-without-data-syn-sent-ipv4.pkt "Ensure that the reception of a TCP RST in the SYN-SENT state does not affect the TCP connection") | Unknown             | Passed              |
|[rcv-rst-without-data-syn-sent-ipv6](rcv-rst-without-data-syn-sent-ipv6.pkt "Ensure that the reception of a TCP RST in the SYN-SENT state does not affect the TCP connection") | Unknown             | Passed              |
|[rcv-rst-with-data-syn-sent-ipv4](rcv-rst-with-data-syn-sent-ipv4.pkt "Ensure that the reception of a TCP RST in the SYN-SENT state does not affect the TCP connection")       | Unknown             | Passed              |
|[rcv-rst-with-data-syn-sent-ipv4](rcv-rst-with-data-syn-sent-ipv6.pkt "Ensure that the reception of a TCP RST in the SYN-SENT state does not affect the TCP connection")       | Unknown             | Passed              |
