# Handling of TCP Segments with the RST-ACK bits Set in the TIME-WAIT State

## Description
This set of tests focuses on the handling of RST-ACK-segments in the `TIME-WAIT` state.

[RFC1337](https://tools.ietf.org/html/rfc1337) discusses the handling of
RST-segments in the `TIME-WAIT` state in addition to
[RFC 0793](https://tools.ietf.org/html/rfc0793).
One of the possible handlings, F1, is to ignore RST-segments in the
`TIME-WAIT` state.
FreeBSD implements this strategy also for RST-ACK segments.
Since [RFC 0793](https://tools.ietf.org/html/rfc0793) specifies that `SEG.ACK` is
checked after the RST bit, the value of `SEG.ACK` is irrelevant.

## Status

| Name                                                                                                                                                                                                                                              | Result FreeBSD 11.0 | Result FreeBSD Head |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-rst-ack-time-wait-outside-left-secure-ipv4](rcv-rst-ack-time-wait-outside-left-secure-ipv4.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not affect the TCP connection")             | Unknown             | Passed              |
|[rcv-rst-ack-time-wait-outside-left-secure-ipv6](rcv-rst-ack-time-wait-outside-left-secure-ipv6.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not affect the TCP connection")             | Unknown             | Passed              |
|[rcv-rst-ack-time-wait-left-edge-secure-ipv4](rcv-rst-ack-time-wait-left-edge-secure-ipv4.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not affect the TCP connection")                     | Unknown             | Passed              |
|[rcv-rst-ack-time-wait-left-edge-secure-ipv6](rcv-rst-ack-time-wait-left-edge-secure-ipv6.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not affect the TCP connection")                     | Unknown             | Passed              |
|[rcv-rst-ack-time-wait-right-edge-secure-ipv4](rcv-rst-ack-time-wait-right-edge-secure-ipv4.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-rst-ack-time-wait-right-edge-secure-ipv6](rcv-rst-ack-time-wait-right-edge-secure-ipv6.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-rst-ack-time-wait-outside-right-secure-ipv4](rcv-rst-ack-time-wait-outside-right-secure-ipv4.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state does not affect the TCP connection")     | Unknown             | Passed              |
|[rcv-rst-ack-time-wait-outside-right-secure-ipv6](rcv-rst-ack-time-wait-outside-right-secure-ipv6.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state does not affect the TCP connection")     | Unknown             | Passed              |
|[rcv-rst-ack-time-wait-outside-left-insecure-ipv4](rcv-rst-ack-time-wait-outside-left-insecure-ipv4.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-rst-ack-time-wait-outside-left-insecure-ipv6](rcv-rst-ack-time-wait-outside-left-insecure-ipv6.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-rst-ack-time-wait-left-edge-insecure-ipv4](rcv-rst-ack-time-wait-left-edge-insecure-ipv4.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not affect the TCP connection")                 | Unknown             | Passed              |
|[rcv-rst-ack-time-wait-left-edge-insecure-ipv6](rcv-rst-ack-time-wait-left-edge-insecure-ipv6.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not affect the TCP connection")                 | Unknown             | Passed              |
|[rcv-rst-ack-time-wait-right-edge-insecure-ipv4](rcv-rst-ack-time-wait-right-edge-insecure-ipv4.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state does not affect the TCP connection")     | Unknown             | Passed              |
|[rcv-rst-ack-time-wait-right-edge-insecure-ipv6](rcv-rst-ack-time-wait-right-edge-insecure-ipv6.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state does not affect the TCP connection")     | Unknown             | Passed              |
|[rcv-rst-ack-time-wait-outside-right-insecure-ipv4](rcv-rst-ack-time-wait-outside-right-insecure-ipv4.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state does not affect the TCP connection") | Unknown             | Passed              |
|[rcv-rst-ack-time-wait-outside-right-insecure-ipv6](rcv-rst-ack-time-wait-outside-right-insecure-ipv6.pkt "Ensure that the reception of a RST-ACK-segment with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state does not affect the TCP connection") | Unknown             | Passed              |
