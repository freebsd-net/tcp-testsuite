# Handling of TCP Segments with the RST-bit Set in the SYN-SENT State

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
|[rcv-rst-syn-sent-outside-left-ipv4](rcv-rst-syn-sent-outside-left-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.ACK=SND.NXT-1 in the SYN-SENT state does not affect the TCP connection")                                         | Unknown             | Passed              |
|[rcv-rst-syn-sent-outside-left-ipv6](rcv-rst-syn-sent-outside-left-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.ACK=SND.NXT-1 in the SYN-SENT state does not affect the TCP connection")                                         | Unknown             | Passed              |
|[rcv-rst-syn-sent-left-edge-ipv4](rcv-rst-syn-sent-left-edge-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.ACK=SND.NXT in the SYN-SENT state destroys the TCP connection")                                                        | Unknown             | Passed              |
|[rcv-rst-syn-sent-left-edge-ipv6](rcv-rst-syn-sent-left-edge-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.ACK=SND.NXT in the SYN-SENT state destroys the TCP connection")                                                        | Unknown             | Passed              |
|[rcv-rst-syn-sent-outside-right-ipv4](rcv-rst-syn-sent-outside-right-ipv4.pkt "Ensure that the reception of a TCP RST with SEG.ACK=SND.NXT+1 in the SYN-SENT state does not affect the TCP connection")                                       | Unknown             | Passed              |
|[rcv-rst-syn-sent-outside-right-ipv6](rcv-rst-syn-sent-outside-right-ipv6.pkt "Ensure that the reception of a TCP RST with SEG.ACK=RCV.NXT+1 in the SYN-SENT state does not affect the TCP connection")                                       | Unknown             | Passed              |

## Notes
