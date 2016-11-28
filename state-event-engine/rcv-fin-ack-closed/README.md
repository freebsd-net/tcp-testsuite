# Handling of TCP Segments with the FIN-ACK-bits Set in the CLOSED state

## Description
This set of tests focuses on the handling of FIN-ACK-segments in the CLOSED state.
The state of the end-point should not be affected.

The required behavior is described in [RFC 0793](https://tools.ietf.org/html/rfc793#section-3.9).

## Results

| Name                                                                                                                                                                     | Result FreeBSD 11.0 | Result FreeBSD Head |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-fin-ack-closed-ipv4](rcv-fin-ack-closed-ipv4.pkt "Ensure that the reception of a FIN-ACK-segment in the CLOSED state does trigger the sending of a RST-segment")     | Unknown             | Passed              |
|[rcv-fin-ack-closed-ipv6](rcv-fin-ack-closed-ipv6.pkt "Ensure that the reception of a FIN-ACK-segment in the CLOSED state does trigger the sending of a RST-segment")     | Unknown             | Passed              |
