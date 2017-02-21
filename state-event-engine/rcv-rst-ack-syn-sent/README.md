# Handling of TCP Segments with the RST-ACK-bits Set in the SYN-SENT State

## Description
This set of tests focuses on the handling of TCP-segments with the
RST and ACK bit set in the `SYN-SENT` state.

[RFC 0793](https://tools.ietf.org/html/rfc0793) requires RST-ACK-segments to
be accepted if and only if `SEG.ACK = SND.NXT` holds.

## Status

| Name                                                                                                                                                                                                                                                 | Result FreeBSD 11.0 | Result FreeBSD Head |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-rst-ack-without-data-syn-sent-ack-outside-left-ipv4](rcv-rst-ack-without-data-syn-sent-ack-outside-left-ipv4.pkt "Ensure that the reception of a TCP RST-ACK with SEG.ACK=SND.NXT-1 in the SYN-SENT state does not affect the TCP connection")   | Unknown             | Passed              |
|[rcv-rst-ack-without-data-syn-sent-ack-outside-left-ipv6](rcv-rst-ack-without-data-syn-sent-ack-outside-left-ipv6.pkt "Ensure that the reception of a TCP RST-ACK with SEG.ACK=SND.NXT-1 in the SYN-SENT state does not affect the TCP connection")   | Unknown             | Passed              |
|[rcv-rst-ack-without-data-syn-sent-ack-left-edge-ipv4](rcv-rst-ack-without-data-syn-sent-ack-left-edge-ipv4.pkt "Ensure that the reception of a TCP RST-ACK with SEG.ACK=SND.NXT in the SYN-SENT state destroys the TCP connection")                  | Unknown             | Passed              |
|[rcv-rst-ack-without-data-syn-sent-ack-left-edge-ipv6](rcv-rst-ack-without-data-syn-sent-ack-left-edge-ipv6.pkt "Ensure that the reception of a TCP RST-ACK with SEG.ACK=SND.NXT in the SYN-SENT state destroys the TCP connection")                  | Unknown             | Passed              |
|[rcv-rst-ack-without-data-syn-sent-ack-outside-right-ipv4](rcv-rst-ack-without-data-syn-sent-ack-outside-right-ipv4.pkt "Ensure that the reception of a TCP RST-ACK with SEG.ACK=SND.NXT+1 in the SYN-SENT state does not affect the TCP connection") | Unknown             | Passed              |
|[rcv-rst-ack-without-data-syn-sent-ack-outside-right-ipv6](rcv-rst-ack-without-data-syn-sent-ack-outside-right-ipv6.pkt "Ensure that the reception of a TCP RST-ACK with SEG.ACK=RCV.NXT+1 in the SYN-SENT state does not affect the TCP connection") | Unknown             | Passed              |
|[rcv-rst-ack-with-data-syn-sent-ack-outside-left-ipv4](rcv-rst-ack-with-data-syn-sent-ack-outside-left-ipv4.pkt "Ensure that the reception of a TCP RST-ACK with SEG.ACK=SND.NXT-1 in the SYN-SENT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-rst-ack-with-data-syn-sent-ack-outside-left-ipv6](rcv-rst-ack-with-data-syn-sent-ack-outside-left-ipv6.pkt "Ensure that the reception of a TCP RST-ACK with SEG.ACK=SND.NXT-1 in the SYN-SENT state does not affect the TCP connection")         | Unknown             | Passed              |
|[rcv-rst-ack-with-data-syn-sent-ack-left-edge-ipv4](rcv-rst-ack-with-data-syn-sent-ack-left-edge-ipv4.pkt "Ensure that the reception of a TCP RST-ACK with SEG.ACK=SND.NXT in the SYN-SENT state destroys the TCP connection")                        | Unknown             | Passed              |
|[rcv-rst-ack-with-data-syn-sent-ack-left-edge-ipv6](rcv-rst-ack-with-data-syn-sent-ack-left-edge-ipv6.pkt "Ensure that the reception of a TCP RST-ACK with SEG.ACK=SND.NXT in the SYN-SENT state destroys the TCP connection")                        | Unknown             | Passed              |
|[rcv-rst-ack-with-data-syn-sent-ack-outside-right-ipv4](rcv-rst-ack-with-data-syn-sent-ack-outside-right-ipv4.pkt "Ensure that the reception of a TCP RST-ACK with SEG.ACK=SND.NXT+1 in the SYN-SENT state does not affect the TCP connection")       | Unknown             | Passed              |
|[rcv-rst-ack-with-data-syn-sent-ack-outside-right-ipv6](rcv-rst-ack-with-data-syn-sent-ack-outside-right-ipv6.pkt "Ensure that the reception of a TCP RST-ACK with SEG.ACK=RCV.NXT+1 in the SYN-SENT state does not affect the TCP connection")       | Unknown             | Passed              |
