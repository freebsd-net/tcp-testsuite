# Handling of TCP Segments with the RST-bit Set in the TIME-WAIT State

## Description
This set of tests focuses on the handling of RST-segments moving the state of the TCP connection
either to `CLOSED` or leaving it untouched.
The behavior is described in [RFC 0793](https://tools.ietf.org/html/rfc0793) or
[RFC 5961](https://tools.ietf.org/html/rfc5961#section-3) and selected by the
`sysctl`-variable `net.inet.tcp.insecure_rst`.
The default is to follow [RFC 5961](https://tools.ietf.org/html/rfc5961#section-3).

## Status

| Name                                                                                                                                                                                                                              | Result FreeBSD 11.0 | Result FreeBSD Head |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-rst-time-wait-outside-left-secure-ipv4](rcv-rst-time-wait-outside-left-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not affect the TCP connection")             | Unknown             | Passed              |
|[rcv-rst-time-wait-outside-left-secure-ipv6](rcv-rst-time-wait-outside-left-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not affect the TCP connection")             | Unknown             | Passed              |
|[rcv-rst-time-wait-left-edge-secure-ipv4](rcv-rst-time-wait-left-edge-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not affect the TCP connection")                     | Unknown             | Passed              |
|[rcv-rst-time-wait-left-edge-secure-ipv6](rcv-rst-time-wait-left-edge-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not affect the TCP connection")                     | Unknown             | Passed              |
|[rcv-rst-time-wait-right-edge-secure-ipv4](rcv-rst-time-wait-right-edge-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-rst-time-wait-right-edge-secure-ipv6](rcv-rst-time-wait-right-edge-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-rst-time-wait-outside-right-secure-ipv4](rcv-rst-time-wait-outside-right-secure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state does not affect the TCP connection")     | Unknown             | Passed              |
|[rcv-rst-time-wait-outside-right-secure-ipv6](rcv-rst-time-wait-outside-right-secure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state does not affect the TCP connection")     | Unknown             | Passed              |
|[rcv-rst-time-wait-outside-left-insecure-ipv4](rcv-rst-time-wait-outside-left-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-rst-time-wait-outside-left-insecure-ipv6](rcv-rst-time-wait-outside-left-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-rst-time-wait-left-edge-insecure-ipv4](rcv-rst-time-wait-left-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not affect the TCP connection")                 | Unknown             | Passed              |
|[rcv-rst-time-wait-left-edge-insecure-ipv6](rcv-rst-time-wait-left-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not affect the TCP connection")                 | Unknown             | Passed              |
|[rcv-rst-time-wait-right-edge-insecure-ipv4](rcv-rst-time-wait-right-edge-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state does not affect the TCP connection")     | Unknown             | Passed              |
|[rcv-rst-time-wait-right-edge-insecure-ipv6](rcv-rst-time-wait-right-edge-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state does not affect the TCP connection")     | Unknown             | Passed              |
|[rcv-rst-time-wait-outside-right-insecure-ipv4](rcv-rst-time-wait-outside-right-insecure-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state does not affect the TCP connection") | Unknown             | Passed              |
|[rcv-rst-time-wait-outside-right-insecure-ipv6](rcv-rst-time-wait-outside-right-insecure-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state does not affect the TCP connection") | Unknown             | Passed              |

## Notes   
