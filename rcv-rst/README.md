# Handling the Reception of TCP Segments with the RST-bit Set

## Description
This set of tests focuses on the handling of RST-segments moving the state of the TCP connection
either to `CLOSED` or leaves it untouched.
The behavior is described in [RFC 5961](https://tools.ietf.org/html/rfc5961#section-3) and controlled
by the `sysctl`-variable `net.inet.tcp.insecure_rst`.

The list of `sysctl`-variables affecting the handling of RST-segments is
* net.inet.tcp.insecure_rst

## Status

| Name                                                                                                                                                                                                                                  | Result FreeBSD 11.0 | Result FreeBSD Head |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-rst-closed-ipv4](rcv-rst-closed.pkt "Test the handling in CLOSED state")                                                                                                                                                          | Unknown             | Unknown             |

## Notes
