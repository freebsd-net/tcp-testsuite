# Handling of TCP Segments with the RST-bit Set in the LAST-ACK State

## Description
This set of tests focuses on the handling of RST-segments in the `LAST-ACK` state.

[RFC 0793](https://tools.ietf.org/html/rfc0793) requires RST-segments to be accepted if and only if
`RCV.NXT <= SEG.SEQ < RCV.NXT+RCV.WND` holds.

For mitigating blind attacks, [RFC 5961](https://tools.ietf.org/html/rfc5961#section-3)
requires the RST-segments only to be accepted if and only if `RCV.NXT = SEG.SEQ` holds.
In case of `RCV.NXT < SEG.SEQ < RCV.NXT+RCV.WND`, a challenge ACK has to be sent.

In FreeBSD, the `sysctl`-variable `net.inet.tcp.insecure_rst` can be used to
select if procedures described in [RFC 0793](https://tools.ietf.org/html/rfc0793) or
[RFC 5961](https://tools.ietf.org/html/rfc5961#section-3) are followed.
The default is to follow [RFC 5961](https://tools.ietf.org/html/rfc5961#section-3).

## Status

| Name                                                                                                                                                                                                                                         | Result FreeBSD 11.0 | Result FreeBSD Head |
|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-rst-last-ack-outside-left-secure-ipv4](rcv-rst-last-ack-outside-left-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the LAST-ACK state does not affect the TCP connection")                           | Unknown             | Passed              |
|[rcv-rst-last-ack-outside-left-secure-ipv6](rcv-rst-last-ack-outside-left-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the LAST-ACK state does not affect the TCP connection")                           | Unknown             | Passed              |
|[rcv-rst-last-ack-left-edge-secure-ipv4](rcv-rst-last-ack-left-edge-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the LAST-ACK state destroys the TCP connection")                                          | Unknown             | Failed (Note 1)     |
|[rcv-rst-last-ack-left-edge-secure-ipv6](rcv-rst-last-ack-left-edge-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the LAST-ACK state destroys the TCP connection")                                          | Unknown             | Failed (Note 1)     |
|[rcv-rst-last-ack-right-edge-secure-ipv4](rcv-rst-last-ack-right-edge-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the LAST-ACK state triggers the sending of a challenge ACK")                  | Unknown             | Passed              |
|[rcv-rst-last-ack-right-edge-secure-ipv6](rcv-rst-last-ack-right-edge-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the LAST-ACK state triggers the sending of a challenge ACK")                  | Unknown             | Passed              |
|[rcv-rst-last-ack-outside-right-secure-ipv4](rcv-rst-last-ack-outside-right-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the LAST-ACK state does not affect the TCP connection")                   | Unknown             | Passed              |
|[rcv-rst-last-ack-outside-right-secure-ipv6](rcv-rst-last-ack-outside-right-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the LAST-ACK state does not affect the TCP connection")                   | Unknown             | Passed              |
|[rcv-rst-last-ack-outside-left-insecure-ipv4](rcv-rst-last-ack-outside-left-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the LAST-ACK state does not affect the TCP connection")                         | Unknown             | Passed              |
|[rcv-rst-last-ack-outside-left-insecure-ipv6](rcv-rst-last-ack-outside-left-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the LAST-ACK state does not affect the TCP connection")                         | Unknown             | Passed              |
|[rcv-rst-last-ack-left-edge-insecure-ipv4](rcv-rst-last-ack-left-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the LAST-ACK state destroys the TCP connection")                                      | Unknown             | Failed (Note 1)     |
|[rcv-rst-last-ack-left-edge-insecure-ipv6](rcv-rst-last-ack-left-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the LAST-ACK state destroys the TCP connection")                                      | Unknown             | Failed (Note 1)     |
|[rcv-rst-last-ack-right-edge-insecure-ipv4](rcv-rst-last-ack-right-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the LAST-ACK state destroys the TCP connection")                          | Unknown             | Failed (Note 1)     |
|[rcv-rst-last-ack-right-edge-insecure-ipv6](rcv-rst-last-ack-right-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the LAST-ACK state destroys the TCP connection")                          | Unknown             | Failed (Note 1)     |
|[rcv-rst-last-ack-outside-right-insecure-ipv4](rcv-rst-last-ack-outside-right-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the LAST-ACK state does not affect the TCP connection")               | Unknown             | Passed              |
|[rcv-rst-last-ack-outside-right-insecure-ipv6](rcv-rst-last-ack-outside-right-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the LAST-ACK state does not affect the TCP connection")               | Unknown             | Passed              |

## Notes
1. In `CLOSING` or `LAST-ACK` state after receipt of an acceptable RST-segment the `SO_ERROR` socket options returns 0 instead of
   `ECONNRESET` (the same works in `CLOSE-WAIT`).
   TCP/IP Illustrated, page 964, states that no error is signalled to the process, "since the process has closed the socket".
   This argument covers `CLOSING`, `LAST-ACK`, and `TIME-WAIT`. However, the state can be reached by calling `shutdown(..., SHUT_WR)`
   and therefore the appication can still be notified in `CLOSING` and `LAST-ACK` state.
   A fix is under review in [D8371](https://reviews.freebsd.org/D8371).
