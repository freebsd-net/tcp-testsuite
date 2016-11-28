# Handling of TCP Segments with the SYN-FIN-bits Set in the CLOSED state

## Description
This set of tests focuses on the handling of FIN-segments in the CLOSED state.
The state of the end-point should not be affected.

The required behavior is described in [RFC 0793](https://tools.ietf.org/html/rfc793#section-3.9).

## Results

| Name                                                                                                                                                             | Result FreeBSD 11.0 | Result FreeBSD Head |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-fin-closed-ipv4](rcv-fin-closed-ipv4.pkt "Ensure that the reception of a FIN-segment in the CLOSED state does trigger the sending of a RST-ACK-segment")     | Unknown             | Failed (Note 1)     |
|[rcv-fin-closed-ipv6](rcv-fin-closed-ipv6.pkt "Ensure that the reception of a FIN-segment in the CLOSED state does trigger the sending of a RST-ACK-segment")     | Unknown             | Failed (Note 1)     |

## Notes

1. The FIN is not counted as 1 byte in the sequence number space.
