# Handling of TCP Segments with the SYN-bit Set in the SYN-SENT State

## Description
This set of tests focuses on the handling of SYN-segments in the `SYN-SENT` state.

[RFC 0793](https://tools.ietf.org/html/rfc0793) requires SYN-segments to trigger
the sending of a SYN-ACK segment and to change the TCP connection state to `SYN-RCVD`.

## Status

| Name                                                                                                                                                                                                                          | Result FreeBSD 11.0 | Result FreeBSD Head |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-syn-without-data-syn-sent-ipv4](rcv-syn-without-data-syn-sent-ipv4.pkt "Ensure that the reception of a TCP SYN in the SYN-SENT state triggers the sending of a SYN-ACK and changes the TCP connection state to SYN-RCVD") | Unknown             | Passed (Note 1)     |
|[rcv-syn-without-data-syn-sent-ipv6](rcv-syn-without-data-syn-sent-ipv6.pkt "Ensure that the reception of a TCP SYN in the SYN-SENT state triggers the sending of a SYN-ACK and changes the TCP connection state to SYN-RCVD") | Unknown             | Passed (Note 1)     |
|[rcv-syn-with-data-syn-sent-ipv4](rcv-syn-with-data-syn-sent-ipv4.pkt "Ensure that the reception of a TCP SYN in the SYN-SENT state triggers the sending of a SYN-ACK and changes the TCP connection state to SYN-RCVD")       | Unknown             | Passed (Note 1,2)   |
|[rcv-syn-with-data-syn-sent-ipv6](rcv-syn-with-data-syn-sent-ipv6.pkt "Ensure that the reception of a TCP SYN in the SYN-SENT state triggers the sending of a SYN-ACK and changes the TCP connection state to SYN-RCVD")       | Unknown             | Passed (Note 1,2)   |

## Notes

1. The SYN-ACK sent does not contain the SACK Permitted option anymore. Other options are still reported.
2. The data on the SYN segment is buffered and delivered after the handshake is complete. It is also only acknowledged after the handshake.
