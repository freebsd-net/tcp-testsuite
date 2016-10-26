# Handling of TCP Segments with the RST-bit Set in the CLOSED state

## Description
This set of tests focuses on the handling of RST-segments moving the state of the TCP connection
either to `CLOSED` or leaving it untouched.
The behavior is described in [RFC 0793](https://tools.ietf.org/html/rfc0793) or
[RFC 5961](https://tools.ietf.org/html/rfc5961#section-3) and selected by the
`sysctl`-variable `net.inet.tcp.insecure_rst`.
The default is to follow [RFC 5961](https://tools.ietf.org/html/rfc5961#section-3).

## Status

| Name                                                                                                                                                                   | Result FreeBSD 11.0 | Result FreeBSD Head |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-rst-closed-secure-ipv4](rcv-rst-closed-secure-ipv4.pkt "Ensure that the reception of a TCP RST in the CLOSED state does not trigger the sending of a TCP RST")     | Unknown             | Passed              |
|[rcv-rst-closed-secure-ipv6](rcv-rst-closed-secure-ipv6.pkt "Ensure that the reception of a TCP RST in the CLOSED state does not trigger the sending of a TCP RST")     | Unknown             | Passed              |
|[rcv-rst-closed-insecure-ipv4](rcv-rst-closed-insecure-ipv4.pkt "Ensure that the reception of a TCP RST in the CLOSED state does not trigger the sending of a TCP RST") | Unknown             | Passed              |
|[rcv-rst-closed-insecure-ipv6](rcv-rst-closed-insecure-ipv6.pkt "Ensure that the reception of a TCP RST in the CLOSED state does not trigger the sending of a TCP RST") | Unknown             | Passed              |
