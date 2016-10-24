# Handling of TCP Segments with the RST-bit Set in the CLOSING State

## Description
This set of tests focuses on the handling of RST-segments moving the state of the TCP connection
either to `CLOSED` or leaving it untouched.
The behavior is described in [RFC 0793](https://tools.ietf.org/html/rfc0793) or
[RFC 5961](https://tools.ietf.org/html/rfc5961#section-3) and selected by the
`sysctl`-variable `net.inet.tcp.insecure_rst`.
The default is to follow [RFC 5961](https://tools.ietf.org/html/rfc5961#section-3).

## Status

| Name                                                                                                                                                                                                                                         | Result FreeBSD 11.0 | Result FreeBSD Head |
|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-rst-closing-outside-left-secure-ipv4](rcv-rst-closing-outside-left-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the CLOSING state does not affect the TCP connection")                              | Unknown             | Passed              |
|[rcv-rst-closing-outside-left-secure-ipv6](rcv-rst-closing-outside-left-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the CLOSING state does not affect the TCP connection")                              | Unknown             | Passed              |
|[rcv-rst-closing-left-edge-secure-ipv4](rcv-rst-closing-left-edge-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the CLOSING state destroys the TCP connection")                                             | Unknown             | Failed (Note 1)     |
|[rcv-rst-closing-left-edge-secure-ipv6](rcv-rst-closing-left-edge-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the CLOSING state destroys the TCP connection")                                             | Unknown             | Failed (Note 1)     |
|[rcv-rst-closing-right-edge-secure-ipv4](rcv-rst-closing-right-edge-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the CLOSING state triggers the sending of a challenge ACK")                     | Unknown             | Passed              |
|[rcv-rst-closing-right-edge-secure-ipv6](rcv-rst-closing-right-edge-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the CLOSING state triggers the sending of a challenge ACK")                     | Unknown             | Passed              |
|[rcv-rst-closing-outside-right-secure-ipv4](rcv-rst-closing-outside-right-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the CLOSING state does not affect the TCP connection")                      | Unknown             | Passed              |
|[rcv-rst-closing-outside-right-secure-ipv6](rcv-rst-closing-outside-right-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the CLOSING state does not affect the TCP connection")                      | Unknown             | Passed              |
|[rcv-rst-closing-outside-left-insecure-ipv4](rcv-rst-closing-outside-left-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the CLOSING state does not affect the TCP connection")                            | Unknown             | Passed              |
|[rcv-rst-closing-outside-left-insecure-ipv6](rcv-rst-closing-outside-left-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the CLOSING state does not affect the TCP connection")                            | Unknown             | Passed              |
|[rcv-rst-closing-left-edge-insecure-ipv4](rcv-rst-closing-left-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the CLOSING state destroys the TCP connection")                                         | Unknown             | Failed (Note 1)     |
|[rcv-rst-closing-left-edge-insecure-ipv6](rcv-rst-closing-left-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the CLOSING state destroys the TCP connection")                                         | Unknown             | Failed (Note 1)     |
|[rcv-rst-closing-right-edge-insecure-ipv4](rcv-rst-closing-right-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the CLOSING state destroys the TCP connection")                             | Unknown             | Failed (Note 1)     |
|[rcv-rst-closing-right-edge-insecure-ipv6](rcv-rst-closing-right-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the CLOSING state destroys the TCP connection")                             | Unknown             | Failed (Note 1)     |
|[rcv-rst-closing-outside-right-insecure-ipv4](rcv-rst-closing-outside-right-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the CLOSING state does not affect the TCP connection")                  | Unknown             | Passed              |
|[rcv-rst-closing-outside-right-insecure-ipv6](rcv-rst-closing-outside-right-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the CLOSING state does not affect the TCP connection")                  | Unknown             | Passed              |

## Notes
1. In `CLOSING` or `LAST-ACK` after receipt of an acceptable RST-segment the `SO_ERROR` socket options returns 0 instead of
   `ECONNRESET` (the same works in `CLOSE-WAIT`).
   See [tcp_input.c](https://svnweb.freebsd.org/base/head/sys/netinet/tcp_input.c?revision=306458&view=markup#l2162).
   TCP/IP Illustrated, page 964, states that no error is signalled to the processs, "since the process has closed the socket".
   This argument covers `CLOSING`, `LAST-ACK`, and `TIME-WAIT`.
