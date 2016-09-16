# Handling the Reception of TCP Segments with the RST-bit Set

## Description
This set of tests focuses on the handling of RST-segments moving the state of the TCP connection
either to `CLOSED` or leaving it untouched.
The behavior is described in [RFC 0793](https://tools.ietf.org/html/rfc0793) or
[RFC 5961](https://tools.ietf.org/html/rfc5961#section-3) and selected by the
`sysctl`-variable `net.inet.tcp.insecure_rst`.
The default is to follow [RFC 5961](https://tools.ietf.org/html/rfc5961#section-3).

## Status

| Name                                                                                                                                                                                                                                  | Result FreeBSD 11.0 | Result FreeBSD Head |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-rst-closed-ipv4](rcv-rst-closed.pkt "Test the handling in CLOSED state")                                                                                                                                                          | Unknown             | Unknown             |

## Notes
1. The `systcl`-variable `net.inet.tcp.insecure_rst` is not described in `man 4 tcp`.
