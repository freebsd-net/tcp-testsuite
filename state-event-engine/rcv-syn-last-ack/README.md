# Handling of TCP Segments with the SYN-bit Set in the LAST-ACK State

## Description
This set of tests focuses on the handling of SYN-segments in the `LAST-ACK` state.

[RFC 0793](https://tools.ietf.org/html/rfc0793) requires the sending of a
TCP segment with the RST bit set in response to a SYN segment fullfiling 
`RCV.NXT <= SEG.SEQ < RCV.NXT+RCV.WND`.
In all other cases, a challenge ACK has to be sent.

For mitigating blind attacks, [RFC 5961](https://tools.ietf.org/html/rfc5961#section-3)
requires the sending of a challenge ACK in any case.

In FreeBSD, the `sysctl`-variable `net.inet.tcp.insecure_syn` can be used to
select if procedures described in [RFC 0793](https://tools.ietf.org/html/rfc0793) or
[RFC 5961](https://tools.ietf.org/html/rfc5961#section-3) are followed.
The default is to follow [RFC 5961](https://tools.ietf.org/html/rfc5961#section-4).

## Status

| Name                                                                                                                                                                                                                                | Result FreeBSD 11.0 | Result FreeBSD Head |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-syn-last-ack-outside-left-secure-ipv4](rcv-syn-last-ack-outside-left-secure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT-1 in the LAST-ACK state triggers the sending of a challenge ACK")             | Unknown             | Passed              |
|[rcv-syn-last-ack-outside-left-secure-ipv6](rcv-syn-last-ack-outside-left-secure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT-1 in the LAST-ACK state triggers the sending of a challenge ACK")             | Unknown             | Passed              |
|[rcv-syn-last-ack-left-edge-secure-ipv4](rcv-syn-last-ack-left-edge-secure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT in the LAST-ACK state triggers the sending of a challenge ACK")                     | Unknown             | Failed              |
|[rcv-syn-last-ack-left-edge-secure-ipv6](rcv-syn-last-ack-left-edge-secure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT in the LAST-ACK state triggers the sending of a challenge ACK")                     | Unknown             | Failed              |
|[rcv-syn-last-ack-right-edge-secure-ipv4](rcv-syn-last-ack-right-edge-secure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the LAST-ACK state triggers the sending of a challenge ACK")         | Unknown             | Passed              |
|[rcv-syn-last-ack-right-edge-secure-ipv6](rcv-syn-last-ack-right-edge-secure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the LAST-ACK state triggers the sending of a challenge ACK")         | Unknown             | Passed              |
|[rcv-syn-last-ack-outside-right-secure-ipv4](rcv-syn-last-ack-outside-right-secure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND in the LAST-ACK state triggers the sending of a challenge ACK")     | Unknown             | Passed              |
|[rcv-syn-last-ack-outside-right-secure-ipv6](rcv-syn-last-ack-outside-right-secure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND in the LAST-ACK state triggers the sending of a challenge ACK")     | Unknown             | Passed              |
|[rcv-syn-last-ack-outside-left-insecure-ipv4](rcv-syn-last-ack-outside-left-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT-1 in the LAST-ACK state triggers the sending of a challenge ACK")         | Unknown             | Passed              |
|[rcv-syn-last-ack-outside-left-insecure-ipv6](rcv-syn-last-ack-outside-left-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT-1 in the LAST-ACK state triggers the sending of a challenge ACK")         | Unknown             | Passed              |
|[rcv-syn-last-ack-left-edge-insecure-ipv4](rcv-syn-last-ack-left-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT in the LAST-ACK state destroys the TCP connection")                             | Unknown             | Failed              |
|[rcv-syn-last-ack-left-edge-insecure-ipv6](rcv-syn-last-ack-left-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT in the LAST-ACK state destroys the TCP connection")                             | Unknown             | Failed              |
|[rcv-syn-last-ack-right-edge-insecure-ipv4](rcv-syn-last-ack-right-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the LAST-ACK state destroys the TCP connection")                 | Unknown             | Failed              |
|[rcv-syn-last-ack-right-edge-insecure-ipv6](rcv-syn-last-ack-right-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the LAST-ACK state destroys the TCP connection")                 | Unknown             | Failed              |
|[rcv-syn-last-ack-outside-right-insecure-ipv4](rcv-syn-last-ack-outside-right-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND in the LAST-ACK state triggers the sending of a challenge ACK") | Unknown             | Passed              |
|[rcv-syn-last-ack-outside-right-insecure-ipv6](rcv-syn-last-ack-outside-right-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND in the LAST-ACK state triggers the sending of a challenge ACK") | Unknown             | Passed              |
