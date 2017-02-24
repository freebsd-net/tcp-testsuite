# Handling of TCP Segments with the SYN-ACK-bits Set in the SYN-SENT State

## Description
This set of tests focuses on the handling of SYN-ACK-segments in the `SYN-SENT` state.

[RFC 0793](https://tools.ietf.org/html/rfc0793) requires ACK-segments to be
ignored if SND.UNA =< SEG.ACK =< SND.NXT holds and triggering the sending of
a RST segment with SEG.SEQ = SEQ.ACK otherwise.

If the ACK is acceptable, the SYN-ACK is processed and an ACK segment with
SEG.ACK = SEG.SEQ + 1. (Note 1)

## Status

| Name                                                                                                                                                                                                                                                                                          | Result FreeBSD 11.0 | Result FreeBSD Head |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-syn-ack-syn-sent-without-data-ack-outside-left-ipv4](rcv-syn-ack-without-data-syn-sent-ack-outside-left-ipv4.pkt "Ensure that the reception of a TCP ACK with SEG.ACK=SND.NXT-1 in the SYN-SENT state triggers the sending of a TCP RST and does not affect the TCP connection")          | Unknown             | Failed (Note 2)     |
|[rcv-syn-ack-syn-sent-without-data-ack-outside-left-ipv6](rcv-syn-ack-without-data-syn-sent-ack-outside-left-ipv6.pkt "Ensure that the reception of a TCP ACK with SEG.ACK=SND.NXT-1 in the SYN-SENT state triggers the sending of a TCP RST and does not affect the TCP connection")          | Unknown             | Failed (Note 2)     |
|[rcv-syn-ack-syn-sent-without-data-ack-left-edge-ipv4](rcv-syn-ack-without-data-syn-sent-ack-left-edge-ipv4.pkt "Ensure that the reception of a TCP ACK with SEG.ACK=SND.NXT in the SYN-SENT state triggers the sending of a TCP ACK using SEG.ACK=RCV.NXT and a state change to ESTABLISHED") | Unknown             | Passed              |
|[rcv-syn-ack-syn-sent-without-data-ack-left-edge-ipv6](rcv-syn-ack-without-data-syn-sent-ack-left-edge-ipv6.pkt "Ensure that the reception of a TCP ACK with SEG.ACK=SND.NXT in the SYN-SENT state triggers the sending of a TCP ACK using SEG.ACK=RCV.NXT and a state change to ESTABLISHED") | Unknown             | Passed              |
|[rcv-syn-ack-syn-sent-without-data-ack-outside-right-ipv4](rcv-syn-ack-without-data-syn-sent-ack-outside-right-ipv4.pkt "Ensure that the reception of a TCP ACK with SEG.ACK=SND.NXT+1 in the SYN-SENT state triggers the sending of a TCP RST and does not affect the TCP connection")        | Unknown             | Failed (Note 2)     |
|[rcv-syn-ack-syn-sent-without-data-ack-outside-right-ipv6](rcv-syn-ack-without-data-syn-sent-ack-outside-right-ipv6.pkt "Ensure that the reception of a TCP ACK with SEG.ACK=RCV.NXT+1 in the SYN-SENT state triggers the sending of a TCP RST and does not affect the TCP connection")        | Unknown             | Failed (Note 2)     |
|[rcv-syn-ack-syn-sent-with-data-ack-outside-left-ipv4](rcv-syn-ack-with-data-syn-sent-ack-outside-left-ipv4.pkt "Ensure that the reception of a TCP ACK with SEG.ACK=SND.NXT-1 in the SYN-SENT state triggers the sending of a TCP RST and does not affect the TCP connection")                | Unknown             | Failed (Note 2)     |
|[rcv-syn-ack-syn-sent-with-data-ack-outside-left-ipv6](rcv-syn-ack-with-data-syn-sent-ack-outside-left-ipv6.pkt "Ensure that the reception of a TCP ACK with SEG.ACK=SND.NXT-1 in the SYN-SENT state triggers the sending of a TCP RST and does not affect the TCP connection")                | Unknown             | Failed (Note 2)     |
|[rcv-syn-ack-syn-sent-with-data-ack-left-edge-ipv4](rcv-syn-ack-with-data-syn-sent-ack-left-edge-ipv4.pkt "Ensure that the reception of a TCP ACK with SEG.ACK=SND.NXT in the SYN-SENT state triggers the sending of a TCP ACK using SEG.ACK=RCV.NXT and a state change to ESTABLISHED")       | Unknown             | Passed (Note 1)     |
|[rcv-syn-ack-syn-sent-with-data-ack-left-edge-ipv6](rcv-syn-ack-with-data-syn-sent-ack-left-edge-ipv6.pkt "Ensure that the reception of a TCP ACK with SEG.ACK=SND.NXT in the SYN-SENT state triggers the sending of a TCP ACK using SEG.ACK=RCV.NXT and a state change to ESTABLISHED")       | Unknown             | Passed (Note 1)     |
|[rcv-syn-ack-syn-sent-with-data-ack-outside-right-ipv4](rcv-syn-ack-with-data-syn-sent-ack-outside-right-ipv4.pkt "Ensure that the reception of a TCP ACK with SEG.ACK=SND.NXT+1 in the SYN-SENT state triggers the sending of a TCP RST and does not affect the TCP connection")              | Unknown             | Failed (Note 2)     |
|[rcv-syn-ack-syn-sent-with-data-ack-outside-right-ipv6](rcv-syn-ack-with-data-syn-sent-ack-outside-right-ipv6.pkt "Ensure that the reception of a TCP ACK with SEG.ACK=RCV.NXT+1 in the SYN-SENT state triggers the sending of a TCP RST and does not affect the TCP connection")              | Unknown             | Failed (Note 2)     |

## Notes

1. FreeBSD doesn't set `RCV.NXT is set to SEG.SEQ+1`, send an ACK and then processes to data which
   increments `RCV.NXT` by `SEG.LEN` and sends another ACK. Instead is single ACK is sent.
2. When the SYN is retransmitted, the SACK-permitted option is dropped, since the received SYN-ACK does not contain it.
   However, [RFC 0793](https://tools.ietf.org/html/rfc793#section-3.9) requires the received SYN-ACK segment to be dropped,
   so the retransmitted SYN should have the same options as the initial one.
