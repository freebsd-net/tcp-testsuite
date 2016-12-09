# Handling of TCP Segments with the SYN-bit Set in the CLOSED state

## Description
This set of tests focuses on the handling of SYN-segments in the CLOSED state.
The state of the end-point should not be affected.

The required behavior is described in [RFC 0793](https://tools.ietf.org/html/rfc793#section-3.9).

## Results

| Name                                                                                                                                                                                   | Result FreeBSD 11.0 | Result FreeBSD Head |
|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-syn-without-data-closed-ipv4](rcv-syn-without-data-closed-ipv4.pkt "Ensure that the reception of a SYN-segment in the CLOSED state does trigger the sending of a RST-ACK-segment") | Unknown             | Passed              |
|[rcv-syn-without-data-closed-ipv6](rcv-syn-without-data-closed-ipv6.pkt "Ensure that the reception of a SYN-segment in the CLOSED state does trigger the sending of a RST-ACK-segment") | Unknown             | Passed              |
|[rcv-syn-with-data-closed-ipv4](rcv-syn-with-data-closed-ipv4.pkt "Ensure that the reception of a SYN-segment in the CLOSED state does trigger the sending of a RST-ACK-segment")       | Unknown             | Passed              |
|[rcv-syn-with-data-closed-ipv6](rcv-syn-with-data-closed-ipv6.pkt "Ensure that the reception of a SYN-segment in the CLOSED state does trigger the sending of a RST-ACK-segment")       | Unknown             | Passed              |
