# Handling of TCP Segments with the RST-bit Set in the LISTEN State

## Description
This set of tests focuses on the handling of RST-segments in the LISTEN state.
The state of the end-point should not be affected.

The required behavior is described in [RFC 0793](https://tools.ietf.org/html/rfc0793) or
[RFC 5961](https://tools.ietf.org/html/rfc5961#section-3) and selected by the
`sysctl`-variable `net.inet.tcp.insecure_rst`.
The default is to follow [RFC 5961](https://tools.ietf.org/html/rfc5961#section-3).

## Status

| Name                                                                                                                                                                    | Result FreeBSD 11.0 | Result FreeBSD Head |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-rst-listen-secure-ipv4](rcv-rst-listen-secure-ipv4.pkt "Ensure that the reception of a TCP RST in the LISTEN state does not change the state of the end point")     | Unknown             | Passed              |
|[rcv-rst-listen-secure-ipv6](rcv-rst-listen-secure-ipv6.pkt "Ensure that the reception of a TCP RST in the LISTEN state does not change the state of the end point")     | Unknown             | Passed              |
|[rcv-rst-listen-insecure-ipv4](rcv-rst-listen-insecure-ipv4.pkt "Ensure that the reception of a TCP RST in the LISTEN state does not change the state of the end point") | Unknown             | Passed              |
|[rcv-rst-listen-insecure-ipv6](rcv-rst-listen-insecure-ipv6.pkt "Ensure that the reception of a TCP RST in the LISTEN state does not change the state of the end point") | Unknown             | Passed              |
