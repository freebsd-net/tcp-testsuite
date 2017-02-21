# Handling of TCP Segments with the FIN-bit Set in the SYN-SENT State

## Description
This set of tests focuses on the handling of FIN-segments in the `SYN-SENT` state.

[RFC 0793](https://tools.ietf.org/html/rfc0793) requires FIN-segments to be
ignored.

## Status

| Name                                                                                                                                                                          | Result FreeBSD 11.0 | Result FreeBSD Head |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-fin-without-data-syn-sent-ipv4](rcv-fin-without-data-syn-sent-ipv4.pkt "Ensure that the reception of a TCP FIN in the SYN-SENT state does not affect the TCP connection") | Unknown             | Passed              |
|[rcv-fin-without-data-syn-sent-ipv6](rcv-fin-without-data-syn-sent-ipv6.pkt "Ensure that the reception of a TCP FIN in the SYN-SENT state does not affect the TCP connection") | Unknown             | Passed              |
|[rcv-fin-with-data-syn-sent-ipv4](rcv-fin-with-data-syn-sent-ipv4.pkt "Ensure that the reception of a TCP FIN in the SYN-SENT state does not affect the TCP connection")       | Unknown             | Passed              |
|[rcv-fin-with-data-syn-sent-ipv4](rcv-fin-with-data-syn-sent-ipv6.pkt "Ensure that the reception of a TCP FIN in the SYN-SENT state does not affect the TCP connection")       | Unknown             | Passed              |
