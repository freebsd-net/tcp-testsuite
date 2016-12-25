# Handling of TCP Segments with the FIN-bit Set in the LISTEN state

## Description
This set of tests focuses on the handling of FIN-segments in the LISTEN state.
The state of the end-point should not be affected.

The required behavior is described in [RFC 0793](https://tools.ietf.org/html/rfc793#section-3.9).

## Results

| Name                                                                                                                                                                                   | Result FreeBSD 11.0 | Result FreeBSD Head |
|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-fin-without-data-listen-ipv4](rcv-fin-without-data-listen-ipv4.pkt "Ensure that the reception of a FIN-segment in the LISTEN state does not trigger the sending of a TCP-segment") | Unknown             | Passed              |
|[rcv-fin-without-data-listen-ipv6](rcv-fin-without-data-listen-ipv6.pkt "Ensure that the reception of a FIN-segment in the LISTEN state does not trigger the sending of a TCP-segment") | Unknown             | Passed              |
|[rcv-fin-with-data-listen-ipv4](rcv-fin-with-data-listen-ipv4.pkt "Ensure that the reception of a FIN-segment in the LISTEN state does not trigger the sending of a TCP-segment")       | Unknown             | Passed              |
|[rcv-fin-with-data-listen-ipv6](rcv-fin-with-data-listen-ipv6.pkt "Ensure that the reception of a FIN-segment in the LISTEN state does not trigger the sending of a TCP-segment")       | Unknown             | Passed              |
