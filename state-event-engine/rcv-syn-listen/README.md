# Handling of TCP Segments with the SYN-bit Set in the LISTEN State

## Description
This set of tests focuses on the handling of SYN-segments in the LISTEN state.
A SYN-ACK segment has to be sent.

The required behavior is described in [RFC 0793](https://tools.ietf.org/html/rfc0793).

## Status

| Name                                                                                                                                                           | Result FreeBSD 11.0 | Result FreeBSD Head |
|:---------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-syn-listen-secure-ipv4](rcv-syn-listen-secure-ipv4.pkt "Ensure that the reception of a SYN-segment in the LISTEN state a TCP SYN-ACK segment is sent")     | Unknown             | Passed              |
|[rcv-syn-listen-secure-ipv6](rcv-syn-listen-secure-ipv6.pkt "Ensure that the reception of a SYN-segment in the LISTEN state a TCP SYN-ACK segment is sent")     | Unknown             | Passed              |
|[rcv-syn-listen-insecure-ipv4](rcv-syn-listen-insecure-ipv4.pkt "Ensure that the reception of a SYN-segment in the LISTEN state a TCP SYN-ACK segment is sent") | Unknown             | Passed              |
|[rcv-syn-listen-insecure-ipv6](rcv-syn-listen-insecure-ipv6.pkt "Ensure that the reception of a SYN-segment in the LISTEN state a TCP SYN-ACK segment is sent") | Unknown             | Passed              |
