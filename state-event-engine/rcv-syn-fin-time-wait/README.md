# Handling of TCP Segments with the SYN-FIN-bits Set in the TIME-WAIT State

## Description
This set of tests focuses on the handling of SYN-FIN-segments in the `TIME-WAIT` state.

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

In FreeBSD, the `sysctl`-variable `net.inet.tcp.drop_synfin` can be used to control
whether SYN-FIN segments should be dropped or not.

## Status

| Name                                                                                                                                                                                                                                                                                             | Result FreeBSD 11.0 | Result FreeBSD Head |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-syn-fin-time-wait-using-shutdown-outside-left-drop-secure-ipv4](rcv-syn-fin-time-wait-using-shutdown-outside-left-drop-secure-ipv4.pkt "Ensure that a TCP SYN-FIN with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state is silently dropped")                                                        | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-outside-left-drop-secure-ipv6](rcv-syn-fin-time-wait-using-shutdown-outside-left-drop-secure-ipv6.pkt "Ensure that a TCP SYN-FIN with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state is silently dropped")                                                        | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-left-edge-drop-secure-ipv4](rcv-syn-fin-time-wait-using-shutdown-left-edge-drop-secure-ipv4.pkt "Ensure that a TCP SYN-FIN with SEG.SEQ=RCV.NXT in the TIME-WAIT state is silently dropped")                                                                | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-left-edge-drop-secure-ipv6](rcv-syn-fin-time-wait-using-shutdown-left-edge-drop-secure-ipv6.pkt "Ensure that a TCP SYN-FIN with SEG.SEQ=RCV.NXT in the TIME-WAIT state is silently dropped")                                                                | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-right-edge-drop-secure-ipv4](rcv-syn-fin-time-wait-using-shutdown-right-edge-drop-secure-ipv4.pkt "Ensure that a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state is silently dropped")                                                    | Unknown             | Passed (Note 3)     |
|[rcv-syn-fin-time-wait-using-shutdown-right-edge-drop-secure-ipv6](rcv-syn-fin-time-wait-using-shutdown-right-edge-drop-secure-ipv6.pkt "Ensure that a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state is silently dropped")                                                    | Unknown             | Passed (Note 3)     |
|[rcv-syn-fin-time-wait-using-shutdown-outside-right-drop-secure-ipv4](rcv-syn-fin-time-wait-using-shutdown-outside-right-drop-secure-ipv4.pkt "Ensure that a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state is silently dropped")                                                | Unknown             | Passed (Note 3)     |
|[rcv-syn-fin-time-wait-using-shutdown-outside-right-drop-secure-ipv6](rcv-syn-fin-time-wait-using-shutdown-outside-right-drop-secure-ipv6.pkt "Ensure that a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state is silently dropped")                                                | Unknown             | Passed (Note 3)     |
|[rcv-syn-fin-time-wait-using-shutdown-outside-left-drop-insecure-ipv4](rcv-syn-fin-time-wait-using-shutdown-outside-left-drop-insecure-ipv4.pkt "Ensure a TCP SYN-FIN with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state is silently dropped")                                                         | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-outside-left-drop-insecure-ipv6](rcv-syn-fin-time-wait-using-shutdown-outside-left-drop-insecure-ipv6.pkt "Ensure a TCP SYN-FIN with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state is silently dropped")                                                         | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-left-edge-drop-insecure-ipv4](rcv-syn-fin-time-wait-using-shutdown-left-edge-drop-insecure-ipv4.pkt "Ensure that a TCP SYN-FIN with SEG.SEQ=RCV.NXT in the TIME-WAIT state is silently dropped")                                                            | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-left-edge-drop-insecure-ipv6](rcv-syn-fin-time-wait-using-shutdown-left-edge-drop-insecure-ipv6.pkt "Ensure that a TCP SYN-FIN with SEG.SEQ=RCV.NXT in the TIME-WAIT state is silently dropped")                                                            | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-right-edge-drop-insecure-ipv4](rcv-syn-fin-time-wait-using-shutdown-right-edge-drop-insecure-ipv4.pkt "Ensure that a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state is silently dropped")                                                | Unknown             | Passed (Note 3)     |
|[rcv-syn-fin-time-wait-using-shutdown-right-edge-drop-insecure-ipv6](rcv-syn-fin-time-wait-using-shutdown-right-edge-drop-insecure-ipv6.pkt "Ensure that a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state is silently dropped")                                                | Unknown             | Passed (Note 3)     |
|[rcv-syn-fin-time-wait-using-shutdown-outside-right-drop-insecure-ipv4](rcv-syn-fin-time-wait-using-shutdown-outside-right-drop-insecure-ipv4.pkt "Ensure that a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state is silently dropped")                                            | Unknown             | Passed (Note 3)     |
|[rcv-syn-fin-time-wait-using-shutdown-outside-right-drop-insecure-ipv6](rcv-syn-fin-time-wait-using-shutdown-outside-right-drop-insecure-ipv6.pkt "Ensure that a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state is silently dropped")                                            | Unknown             | Passed (Note 3)     |
|[rcv-syn-fin-time-wait-using-shutdown-outside-left-nodrop-secure-ipv4](rcv-syn-fin-time-wait-using-shutdown-outside-left-nodrop-secure-ipv4.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not the sending of any segment")                   | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-outside-left-nodrop-secure-ipv6](rcv-syn-fin-time-wait-using-shutdown-outside-left-nodrop-secure-ipv6.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not the sending of any segment")                   | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-left-edge-nodrop-secure-ipv4](rcv-syn-fin-time-wait-using-shutdown-left-edge-nodrop-secure-ipv4.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not the sending of any segment")                           | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-left-edge-nodrop-secure-ipv6](rcv-syn-fin-time-wait-using-shutdown-left-edge-nodrop-secure-ipv6.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not the sending of any segment")                           | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-right-edge-nodrop-secure-ipv4](rcv-syn-fin-time-wait-using-shutdown-right-edge-nodrop-secure-ipv4.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state triggers the sending of a SYN-ACK segment")         | Unknown             | Passed (Note 2)     |
|[rcv-syn-fin-time-wait-using-shutdown-right-edge-nodrop-secure-ipv6](rcv-syn-fin-time-wait-using-shutdown-right-edge-nodrop-secure-ipv6.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state triggers the sending of a SYN-ACK segment")         | Unknown             | Passed (Note 2)     |
|[rcv-syn-fin-time-wait-using-shutdown-outside-right-nodrop-secure-ipv4](rcv-syn-fin-time-wait-using-shutdown-outside-right-nodrop-secure-ipv4.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state triggers the sending of SYN-ACK segment")       | Unknown             | Passed (Note 2)     |
|[rcv-syn-fin-time-wait-using-shutdown-outside-right-nodrop-secure-ipv6](rcv-syn-fin-time-wait-using-shutdown-outside-right-nodrop-secure-ipv6.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state triggers the sending of SYN-ACK segment")       | Unknown             | Passed (Note 2)     |
|[rcv-syn-fin-time-wait-using-shutdown-outside-left-nodrop-insecure-ipv4](rcv-syn-fin-time-wait-using-shutdown-outside-left-nodrop-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not the sending of any segment")               | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-outside-left-nodrop-insecure-ipv6](rcv-syn-fin-time-wait-using-shutdown-outside-left-nodrop-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not the sending of any segment")               | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-left-edge-nodrop-insecure-ipv4](rcv-syn-fin-time-wait-using-shutdown-left-edge-nodrop-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not the sending of any segment")                       | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-left-edge-nodrop-insecure-ipv6](rcv-syn-fin-time-wait-using-shutdown-left-edge-nodrop-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not the sending of any segment")                       | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-time-wait-using-shutdown-right-edge-nodrop-insecure-ipv4](rcv-syn-fin-time-wait-using-shutdown-right-edge-nodrop-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT triggers the sending of a SYN-ACK segment")           | Unknown             | Passed (Note 2)     |
|[rcv-syn-fin-time-wait-using-shutdown-right-edge-nodrop-insecure-ipv6](rcv-syn-fin-time-wait-using-shutdown-right-edge-nodrop-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT triggers the sending of a SYN-ACK segment")           | Unknown             | Passed (Note 2)     |
|[rcv-syn-fin-time-wait-using-shutdown-outside-right-nodrop-insecure-ipv4](rcv-syn-fin-time-wait-using-shutdown-outside-right-nodrop-insecure-ipv4.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state triggers the sending of a SYN-ACK segment") | Unknown             | Passed (Note 2)     |
|[rcv-syn-fin-time-wait-using-shutdown-outside-right-nodrop-insecure-ipv6](rcv-syn-fin-time-wait-using-shutdown-outside-right-nodrop-insecure-ipv6.pkt "Ensure that the reception of a TCP SYN-FIN with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state triggers the sending of a SYN-ACK segment") | Unknown             | Passed (Note 2)     |

## Notes
1. If `SEG.SEQ <= RCV.NXT`, no response is sent and the TCP connection stays in the `TIME-WAIT` state.
2. If `SEG.SEQ > RCV.NXT`, a SYN-ACK segment is sent and the TCP connection moves to the `SYN-RCVD` state.
3. The state was moved from `TIME-WAIT` to `CLOSED`, because the `drop_synfin` `sysctl`-variable was not honored. This is fixed in [f8b5681094dd752604bfa0603ba0be2873698f46](https://cgit.FreeBSD.org/src/commit/?id=f8b5681094dd752604bfa0603ba0be2873698f46) ([D36862](https://reviews.freebsd.org/D36862)).
