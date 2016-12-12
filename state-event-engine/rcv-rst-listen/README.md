# Handling of TCP Segments with the RST-bit Set in the LISTEN state

## Description
This set of tests focuses on the handling of RST-segments in the LISTEN state. The state of the end-point should not be affected.

The required behavior is described in [RFC 0793](https://tools.ietf.org/html/rfc0793) or
[RFC 5961](https://tools.ietf.org/html/rfc5961#section-3) and selected by the
`sysctl`-variable `net.inet.tcp.insecure_rst`.
The default is to follow [RFC 5961](https://tools.ietf.org/html/rfc5961#section-3).

## Results

| Name                                                                                                                                                                                   | Result FreeBSD 11.0 | Result FreeBSD Head |
|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-rst-without-data-listen-ipv4](rcv-rst-without-data-listen-ipv4.pkt "Ensure that the reception of a RST-segment in the LISTEN state does not trigger the sending of a RST-segment") | Unknown             | Passed              |
|[rcv-rst-without-data-listen-ipv6](rcv-rst-without-data-listen-ipv6.pkt "Ensure that the reception of a RST-segment in the LISTEN state does not trigger the sending of a RST-segment") | Unknown             | Passed              |
|[rcv-rst-with-data-listen-ipv4](rcv-rst-with-data-listen-ipv4.pkt "Ensure that the reception of a RST-segment in the LISTEN state does not trigger the sending of a RST-segment")       | Unknown             | Passed              |
|[rcv-rst-with-data-listen-ipv6](rcv-rst-with-data-listen-ipv6.pkt "Ensure that the reception of a RST-segment in the LISTEN state does not trigger the sending of a RST-segment")       | Unknown             | Passed              |
