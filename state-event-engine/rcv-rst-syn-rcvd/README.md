# Handling of TCP Segments with the RST-bit Set in the SYN-RCVD State

## Description
This set of tests focuses on the handling of RST-segments in the `SYN-RCVD` state.

[RFC 0793](https://tools.ietf.org/html/rfc0793) requires RST-segments to be accepted if and only if
`RCV.NXT <= SEG.SEQ < RCV.NXT+RCV.WND` holds.

For mitigating blind attacks, [RFC 5961](https://tools.ietf.org/html/rfc5961#section-3)
requires the RST-segments only to be accepted if and only if `RCV.NXT = SEG.SEQ` holds.
In case of `RCV.NXT < SEG.SEQ < RCV.NXT+RCV.WND`, a challenge ACK has to be sent.

In FreeBSD, the `sysctl`-variable `net.inet.tcp.insecure_rst` can be used to
select if procedures described in [RFC 0793](https://tools.ietf.org/html/rfc0793) or
[RFC 5961](https://tools.ietf.org/html/rfc5961#section-3) are followed.
The default is to follow [RFC 5961](https://tools.ietf.org/html/rfc5961#section-3).

Since the code path for handling RST-segments in the `SYN-RCVD` state depends on
the prior state, have two sets of tests.

## Status

| Name                                                                                                                                                                                                                                                                      | Result FreeBSD 11.0 | Result FreeBSD Head |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       |:-------------------:|:-------------------:|
|[rcv-rst-syn-rcvd-via-listen-outside-left-secure-ipv4](rcv-rst-syn-rcvd-via-listen-outside-left-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the SYN-RCVD via the LISTEN state does not affect the TCP connection")                   | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-listen-outside-left-secure-ipv6](rcv-rst-syn-rcvd-via-listen-outside-left-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the SYN-RCVD via the LISTEN state does not affect the TCP connection")                   | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-listen-left-edge-secure-ipv4](rcv-rst-syn-rcvd-via-listen-left-edge-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the SYN-RCVD via the LISTEN state destroys the TCP connection")                                  | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-listen-left-edge-secure-ipv6](rcv-rst-syn-rcvd-via-listen-left-edge-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the SYN-RCVD via the LISTEN state destroys the TCP connection")                                  | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-listen-right-edge-secure-ipv4](rcv-rst-syn-rcvd-via-listen-right-edge-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the SYN-RCVD via the LISTEN state triggers the sending of a challenge ACK")          | Unknown             | Failed (Note 1)     |
|[rcv-rst-syn-rcvd-via-listen-right-edge-secure-ipv6](rcv-rst-syn-rcvd-via-listen-right-edge-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the SYN-RCVD via the LISTEN state triggers the sending of a challenge ACK")          | Unknown             | Failed (Note 1)     |
|[rcv-rst-syn-rcvd-via-listen-outside-right-secure-ipv4](rcv-rst-syn-rcvd-via-listen-outside-right-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the SYN-RCVD via the LISTEN state does not affect the TCP connection")           | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-listen-outside-right-secure-ipv6](rcv-rst-syn-rcvd-via-listen-outside-right-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the SYN-RCVD via the LISTEN state does not affect the TCP connection")           | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-listen-outside-left-insecure-ipv4](rcv-rst-syn-rcvd-via-listen-outside-left-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the SYN-RCVD via the LISTEN state does not affect the TCP connection")               | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-listen-outside-left-insecure-ipv6](rcv-rst-syn-rcvd-via-listen-outside-left-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the SYN-RCVD via the LISTEN state does not affect the TCP connection")               | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-listen-left-edge-insecure-ipv4](rcv-rst-syn-rcvd-via-listen-left-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the SYN-RCVD via the LISTEN state destroys the TCP connection")                              | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-listen-left-edge-insecure-ipv6](rcv-rst-syn-rcvd-via-listen-left-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the SYN-RCVDvia the LISTEN  state destroys the TCP connection")                              | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-listen-right-edge-insecure-ipv4](rcv-rst-syn-rcvd-via-listen-right-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the SYN-RCVD via the LISTEN state destroys the TCP connection")                  | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-listen-right-edge-insecure-ipv6](rcv-rst-syn-rcvd-via-listen-right-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the SYN-RCVD via the LISTEN state destroys the TCP connection")                  | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-listen-outside-right-insecure-ipv4](rcv-rst-syn-rcvd-via-listen-outside-right-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the SYN-RCVD via the LISTEN state does not affect the TCP connection")       | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-listen-outside-right-insecure-ipv6](rcv-rst-syn-rcvd-via-listen-outside-right-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the SYN-RCVD via the LISTEN state does not affect the TCP connection")       | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-outside-left-secure-ipv4](rcv-rst-syn-rcvd-via-syn-sent-outside-left-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the SYN-RCVD via the SYN-SENT state does not affect the TCP connection")             | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-outside-left-secure-ipv6](rcv-rst-syn-rcvd-via-syn-sent-outside-left-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the SYN-RCVD via the SYN-SENT state does not affect the TCP connection")             | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-left-edge-secure-ipv4](rcv-rst-syn-rcvd-via-syn-sent-left-edge-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the SYN-RCVD via the SYN-SENT state destroys the TCP connection")                            | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-left-edge-secure-ipv6](rcv-rst-syn-rcvd-via-syn-sent-left-edge-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the SYN-RCVD via the SYN-SENT state destroys the TCP connection")                            | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-right-edge-secure-ipv4](rcv-rst-syn-rcvd-via-syn-sent-right-edge-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the SYN-RCVD via the SYN-SENT state triggers the sending of a challenge ACK")    | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-right-edge-secure-ipv6](rcv-rst-syn-rcvd-via-syn-sent-right-edge-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the SYN-RCVD via the SYN-SENT state triggers the sending of a challenge ACK")    | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-outside-right-secure-ipv4](rcv-rst-syn-rcvd-via-syn-sent-outside-right-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the SYN-RCVD via the SYN-SENT state does not affect the TCP connection")     | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-outside-right-secure-ipv6](rcv-rst-syn-rcvd-via-syn-sent-outside-right-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the SYN-RCVD via the SYN-SENT state does not affect the TCP connection")     | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-outside-left-insecure-ipv4](rcv-rst-syn-rcvd-via-syn-sent-outside-left-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the SYN-RCVD via the SYN-SENT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-outside-left-insecure-ipv6](rcv-rst-syn-rcvd-via-syn-sent-outside-left-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the SYN-RCVD via the SYN-SENT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-left-edge-insecure-ipv4](rcv-rst-syn-rcvd-via-syn-sent-left-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the SYN-RCVD via the SYN-SENT state destroys the TCP connection")                        | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-left-edge-insecure-ipv6](rcv-rst-syn-rcvd-via-syn-sent-left-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the SYN-RCVDvia the SYN-SENT  state destroys the TCP connection")                        | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-right-edge-insecure-ipv4](rcv-rst-syn-rcvd-via-syn-sent-right-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the SYN-RCVD via the SYN-SENT state destroys the TCP connection")            | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-right-edge-insecure-ipv6](rcv-rst-syn-rcvd-via-syn-sent-right-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the SYN-RCVD via the SYN-SENT state destroys the TCP connection")            | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-outside-right-insecure-ipv4](rcv-rst-syn-rcvd-via-syn-sent-outside-right-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the SYN-RCVD via the SYN-SENT state does not affect the TCP connection") | Unknown             | Passed              |
|[rcv-rst-syn-rcvd-via-syn-sent-outside-right-insecure-ipv6](rcv-rst-syn-rcvd-via-syn-sent-outside-right-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the SYN-RCVD via the SYN-SENT state does not affect the TCP connection") | Unknown             | Passed              |

## Notes
1. No challenge ACK is sent. The syn-cache code is missing the logic described in
   [RFC 5961](https://tools.ietf.org/html/rfc5961#section-3).
   See [tcp_syncache.c](http://fxr.watson.org/fxr/source/netinet/tcp_syncache.c#L562).
