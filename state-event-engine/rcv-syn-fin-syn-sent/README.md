# Handling of TCP Segments with the SYN-FIN-bits Set in the SYN-SENT State

## Description
This set of tests focuses on the handling of SYN-FIN-segments in the `SYN-SENT` state.

[RFC 0793](https://tools.ietf.org/html/rfc0793) requires SYN-FIN-segments to trigger
the sending of a SYN-ACK segment and to change the TCP connection state to `SYN-RCVD`.

In FreeBSD, the `sysctl`-variable `net.inet.tcp.drop_synfin` can be used to
select that received SYN-FIN-segments are just dropped.
The default is to not drop SYN-FIN-segments.

## Status

| Name                                                                                                                                                                                                                                                                          | Result FreeBSD 11.0 | Result FreeBSD Head |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-syn-fin-without-data-syn-sent-dropping-disabled-ipv4](rcv-syn-fin-without-data-syn-sent-dropping-disabled-ipv4.pkt "Ensure that the reception of a TCP SYN-FIN in the SYN-SENT state triggers the sending of a SYN-ACK and changes the TCP connection state to SYN-RCVD") | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-without-data-syn-sent-dropping-disabled-ipv6](rcv-syn-fin-without-data-syn-sent-dropping-disabled-ipv6.pkt "Ensure that the reception of a TCP SYN-FIN in the SYN-SENT state triggers the sending of a SYN-ACK and changes the TCP connection state to SYN-RCVD") | Unknown             | Passed (Note 1)     |
|[rcv-syn-fin-with-data-syn-sent-dropping-disabled-ipv4](rcv-syn-fin-with-data-syn-sent-dropping-disabled-ipv4.pkt "Ensure that the reception of a TCP SYN-FIN in the SYN-SENT state triggers the sending of a SYN-ACK and changes the TCP connection state to SYN-RCVD")       | Unknown             | Passed (Note 1,2)   |
|[rcv-syn-fin-with-data-syn-sent-dropping-disabled-ipv6](rcv-syn-fin-with-data-syn-sent-dropping-disabled-ipv6.pkt "Ensure that the reception of a TCP SYN-FIN in the SYN-SENT state triggers the sending of a SYN-ACK and changes the TCP connection state to SYN-RCVD")       | Unknown             | Passed (Note 1,2)   |
|[rcv-syn-fin-without-data-syn-sent-dropping-enabled-ipv4](rcv-syn-fin-without-data-syn-sent-dropping-enabled-ipv4.pkt "Ensure that the reception of a TCP SYN-FIN in the SYN-SENT state does not trigger any change in the TCP connection")                                    | Unknown             | Passed (Note 3)     |
|[rcv-syn-fin-without-data-syn-sent-dropping-enabled-ipv6](rcv-syn-fin-without-data-syn-sent-dropping-enabled-ipv6.pkt "Ensure that the reception of a TCP SYN-FIN in the SYN-SENT state does not trigger any change in the TCP connection")                                    | Unknown             | Passed (Note 3)     |
|[rcv-syn-fin-with-data-syn-sent-dropping-enabled-ipv4](rcv-syn-fin-with-data-syn-sent-dropping-enabled-ipv4.pkt "Ensure that the reception of a TCP SYN-FIN in the SYN-SENT state does not trigger any change in the TCP connection")                                          | Unknown             | Passed (Note 3)     |
|[rcv-syn-fin-with-data-syn-sent-dropping-enabled-ipv6](rcv-syn-fin-with-data-syn-sent-dropping-enabled-ipv6.pkt "Ensure that the reception of a TCP SYN-FIN in the SYN-SENT state does not trigger any change in the TCP connection")                                          | Unknown             | Passed (Note 3)     |

## Notes

1. The SYN-ACK sent does not contain the SACK Permitted option anymore. Other options are still reported.
2. The data on the SYN segment is buffered and delivered after the handshake is complete.
   It is also only acknowledged after the handshake.
3. The received SYN-FIN segment is processed even if the `sysctl`-variable `net.inet.tcp.drop_synfin` is set to 1.
   Fixed in [r316743](https://svnweb.freebsd.org/changeset/base/316743) ([D9894](https://reviews.freebsd.org/D9894)).

