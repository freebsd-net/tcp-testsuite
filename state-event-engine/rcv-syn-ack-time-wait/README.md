# Handling of TCP Segments with the SYN-ACK-bits Set in the TIME-WAIT State

## Description
This set of tests focuses on the handling of SYN-ACK-segments in the `TIME-WAIT` state.

[RFC 0793](https://tools.ietf.org/html/rfc0793) requires the sending of
a RST-segment in response to a received SYN-segment with
`RCV.NXT <= SEG.SEQ < RCV.NXT+RCV.WND`.
If SEG.SEQ of the received SYN-segment is outside this window, a challenge ACK
has to be sent.

For mitigating blind attacks, [RFC 5961](https://tools.ietf.org/html/rfc5961#section-4)
requires that a challenge ACK has always to be sent in response to a SYN-segment.

In FreeBSD, the `sysctl`-variable `net.inet.tcp.insecure_syn` can be used to
select if procedures described in [RFC 0793](https://tools.ietf.org/html/rfc0793) or
[RFC 5961](https://tools.ietf.org/html/rfc5961#section-4) are followed.
The default is to follow [RFC 5961](https://tools.ietf.org/html/rfc5961#section-4).

FreeBSD currently implements a different strategy:
If a SYN-segment is received with `SEG.SEQ <= RCV.NXT`, no response is sent and
the TCP connection stays in the `TIME-WAIT` state.
However, if `SEG.SEQ > RCV.NXT` holds, the TCP connection is moved from the
`TIME-WAIT` state to the `CLOSED` state and the incoming SYN-segment is processed.

## Status

| Name                                                                                                                                                                                                                                             | Result FreeBSD 11.0 | Result FreeBSD Head |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-syn-ack-time-wait-outside-left-secure-ipv4](rcv-syn-ack-time-wait-outside-left-secure-ipv4.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state triggers the sending of an ACK segment")            | Unknown             | Passed (Note 1)     |
|[rcv-syn-ack-time-wait-outside-left-secure-ipv6](rcv-syn-ack-time-wait-outside-left-secure-ipv6.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state triggers the sending of an ACK segment")            | Unknown             | Passed (Note 1)     |
|[rcv-syn-ack-time-wait-left-edge-secure-ipv4](rcv-syn-ack-time-wait-left-edge-secure-ipv4.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT in the TIME-WAIT state trigger the sending of an ACK segment")                     | Unknown             | Passed (Note 1)     |
|[rcv-syn-ack-time-wait-left-edge-secure-ipv6](rcv-syn-ack-time-wait-left-edge-secure-ipv6.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT in the TIME-WAIT state trigger the sending of an ACK segment")                     | Unknown             | Passed (Note 1)     |
|[rcv-syn-ack-time-wait-right-edge-secure-ipv4](rcv-syn-ack-time-wait-right-edge-secure-ipv4.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state triggers the sending of a RST segment")         | Unknown             | Passed (Note 2)     |
|[rcv-syn-ack-time-wait-right-edge-secure-ipv6](rcv-syn-ack-time-wait-right-edge-secure-ipv6.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state triggers the sending of a RST segment")         | Unknown             | Passed (Note 2)     |
|[rcv-syn-ack-time-wait-outside-right-secure-ipv4](rcv-syn-ack-time-wait-outside-right-secure-ipv4.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state triggers the sending of a RST segment")     | Unknown             | Passed (Note 2)     |
|[rcv-syn-ack-time-wait-outside-right-secure-ipv6](rcv-syn-ack-time-wait-outside-right-secure-ipv6.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state triggers the sending of a RST segment")     | Unknown             | Passed (Note 2)     |
|[rcv-syn-ack-time-wait-outside-left-insecure-ipv4](rcv-syn-ack-time-wait-outside-left-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state triggers the sending of an ACK segment")        | Unknown             | Passed (Note 1)     |
|[rcv-syn-ack-time-wait-outside-left-insecure-ipv6](rcv-syn-ack-time-wait-outside-left-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state triggers the sending of an ACK segment")        | Unknown             | Passed (Note 1)     |
|[rcv-syn-ack-time-wait-left-edge-insecure-ipv4](rcv-syn-ack-time-wait-left-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT in the TIME-WAIT state triggers the sending of an ACK segment")                | Unknown             | Passed (Note 1)     |
|[rcv-syn-ack-time-wait-left-edge-insecure-ipv6](rcv-syn-ack-time-wait-left-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT in the TIME-WAIT state triggers the sending of an ACK segment")                | Unknown             | Passed (Note 1)     |
|[rcv-syn-ack-time-wait-right-edge-insecure-ipv4](rcv-syn-ack-time-wait-right-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT triggers the sending of a RST segment")           | Unknown             | Passed (Note 2)     |
|[rcv-syn-ack-time-wait-right-edge-insecure-ipv6](rcv-syn-ack-time-wait-right-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT triggers the sending of a RST segment")           | Unknown             | Passed (Note 2)     |
|[rcv-syn-ack-time-wait-outside-right-insecure-ipv4](rcv-syn-ack-time-wait-outside-right-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state triggers the sending of a RST segment") | Unknown             | Passed (Note 2)     |
|[rcv-syn-ack-time-wait-outside-right-insecure-ipv6](rcv-syn-ack-time-wait-outside-right-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN-ACK with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state triggers the sending of a RST segment") | Unknown             | Passed (Note 2)     |

## Notes
1. If `SEG.SEQ <= RCV.NXT`, an ACK is sent and the TCP connection stays in the `TIME-WAIT` state.
2. If `SEG.SEQ > RCV.NXT`, a RST segment with SEG.SEQ=0 is sent and the TCP connection moves to the `CLOSED` state.
