# Handling the Reception of TCP Segments with the RST-bit Set

## Description
This set of tests focuses on the handling of RST-segments moving the state of the TCP connection either to `CLOSED` or leaves it untouched.

The list of `sysctl`-variables affecting the handling of RST-segments is
* net.inet.tcp.insecure_rst

## Status

| Name                                                                                                                                                                                                                                  | Result FreeBSD 11.0 | Result FreeBSD Head |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-rst-closed-ipv4](rcv-rst-closed.pkt "Test the handling in CLOSED state")                                                                                                                                                          | Unknown             | Unknown             |

## Notes
