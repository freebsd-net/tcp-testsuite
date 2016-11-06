# Handling of TCP Segments with the SYN-bit Set in the TIME-WAIT State

## Description
This set of tests focuses on the handling of SYN-segments in the `TIME-WAIT` state.

[RFC1337](https://tools.ietf.org/html/rfc1337) discusses the handling of
SYN-segments in the `TIME-WAIT` state in addition to
[RFC 0793](https://tools.ietf.org/html/rfc0793).
 One of the possible handlings, F1, is to ignore SYN-segments in the
 `TIME-WAIT` state.

## Status

| Name                                                                                                                                                                                                                              | Result FreeBSD 11.0 | Result FreeBSD Head |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-syn-time-wait-outside-left-secure-ipv4](rcv-syn-time-wait-outside-left-secure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not affect the TCP connection")             | Unknown             | Passed              |
|[rcv-syn-time-wait-outside-left-secure-ipv6](rcv-syn-time-wait-outside-left-secure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not affect the TCP connection")             | Unknown             | Passed              |
|[rcv-syn-time-wait-left-edge-secure-ipv4](rcv-syn-time-wait-left-edge-secure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not affect the TCP connection")                     | Unknown             | Passed              |
|[rcv-syn-time-wait-left-edge-secure-ipv6](rcv-syn-time-wait-left-edge-secure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not affect the TCP connection")                     | Unknown             | Passed              |
|[rcv-syn-time-wait-right-edge-secure-ipv4](rcv-syn-time-wait-right-edge-secure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-syn-time-wait-right-edge-secure-ipv6](rcv-syn-time-wait-right-edge-secure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-syn-time-wait-outside-right-secure-ipv4](rcv-syn-time-wait-outside-right-secure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state does not affect the TCP connection")     | Unknown             | Passed              |
|[rcv-syn-time-wait-outside-right-secure-ipv6](rcv-syn-time-wait-outside-right-secure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state does not affect the TCP connection")     | Unknown             | Passed              |
|[rcv-syn-time-wait-outside-left-insecure-ipv4](rcv-syn-time-wait-outside-left-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-syn-time-wait-outside-left-insecure-ipv6](rcv-syn-time-wait-outside-left-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-syn-time-wait-left-edge-insecure-ipv4](rcv-syn-time-wait-left-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not affect the TCP connection")                 | Unknown             | Passed              |
|[rcv-syn-time-wait-left-edge-insecure-ipv6](rcv-syn-time-wait-left-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not affect the TCP connection")                 | Unknown             | Passed              |
|[rcv-syn-time-wait-right-edge-insecure-ipv4](rcv-syn-time-wait-right-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state does not affect the TCP connection")     | Unknown             | Passed              |
|[rcv-syn-time-wait-right-edge-insecure-ipv6](rcv-syn-time-wait-right-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state does not affect the TCP connection")     | Unknown             | Passed              |
|[rcv-syn-time-wait-outside-right-insecure-ipv4](rcv-syn-time-wait-outside-right-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state does not affect the TCP connection") | Unknown             | Passed              |
|[rcv-syn-time-wait-outside-right-insecure-ipv6](rcv-syn-time-wait-outside-right-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state does not affect the TCP connection") | Unknown             | Passed              |
