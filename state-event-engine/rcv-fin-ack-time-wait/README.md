# Handling of TCP Segments with the FIN-ACK bits Set in the TIME-WAIT State

## Description
This set of tests focuses on the handling of FIN-ACK-segments in the `TIME-WAIT` state.

Receiving a TCP segment, which is not acceptable should trigger the sending of an ACK with `SEG.SEQ=SND.NXT` and `SEG.ACK=RCV.NXT`.
According to [RFC 0793](https://tools.ietf.org/html/rfc0793) the same applies to acceptable segments, although a peer following [RFC 0793](https://tools.ietf.org/html/rfc0793) will only send FIN-ACK segments using `SEG.SEQ=RCV.NXT-1`.

## Status

| Name                                                                                                                                                                                                                                                              | Result FreeBSD 11.0 | Result FreeBSD Head |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-fin-ack-time-wait-using-shutdown-outside-left-ipv4](rcv-fin-ack-time-wait-using-shutdown-outside-left-ipv4.pkt "Ensure that the reception of a FIN-ACK-segment with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT triggers the sending of an ACK-segment")               | Unknown             | Passed              |
|[rcv-fin-ack-time-wait-using-shutdown-outside-left-ipv6](rcv-fin-ack-time-wait-using-shutdown-outside-left-ipv6.pkt "Ensure that the reception of a FIN-ACK-segment with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT triggers the sending of an ACK-segment")               | Unknown             | Passed              |
|[rcv-fin-ack-time-wait-using-shutdown-left-edge-ipv4](rcv-fin-ack-time-wait-using-shutdown-left-edge-ipv4.pkt "Ensure that the reception of a FIN-ACK-segment with SEG.SEQ=RCV.NXT in the TIME-WAIT state triggers the sending of an ACK-segment")                 | Unknown             | Passed (Note 1)     |
|[rcv-fin-ack-time-wait-using-shutdown-left-edge-ipv6](rcv-fin-ack-time-wait-using-shutdown-left-edge-ipv6.pkt "Ensure that the reception of a FIN-ACK-segment with SEG.SEQ=RCV.NXT in the TIME-WAIT state triggers the sending of an ACK-segment")                 | Unknown             | Passed (Note 1)     |
|[rcv-fin-ack-time-wait-using-shutdown-middle-ipv4](rcv-fin-ack-time-wait-using-shutdown-middle-ipv4.pkt "Ensure that the reception of a FIN-ACK-segment with SEG.SEQ=RCV.NXT+1 in the TIME-WAIT state triggers the sending of an ACK-segment")                     | Unknown             | Passed (Note 1)     |
|[rcv-fin-ack-time-wait-using-shutdown-middle-ipv6](rcv-fin-ack-time-wait-using-shutdown-middle-ipv6.pkt "Ensure that the reception of a FIN-ACK-segment with SEG.SEQ=RCV.NXT+1 in the TIME-WAIT state triggers the sending of an ACK-segment")                     | Unknown             | Passed (Note 1)     |
|[rcv-fin-ack-time-wait-using-shutdown-right-edge-ipv4](rcv-fin-ack-time-wait-using-shutdown-right-edge-ipv4.pkt "Ensure that the reception of a FIN-ACK-segment with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state triggers the sending of an ACK-segment")     | Unknown             | Passed (Note 1)     |
|[rcv-fin-ack-time-wait-using-shutdown-right-edge-ipv6](rcv-fin-ack-time-wait-using-shutdown-right-edge-ipv6.pkt "Ensure that the reception of a FIN-ACK-segment with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state triggers the sending of an ACK-segment")     | Unknown             | Passed (Note 1)     |
|[rcv-fin-ack-time-wait-using-shutdown-outside-right-ipv4](rcv-fin-ack-time-wait-using-shutdown-outside-right-ipv4.pkt "Ensure that the reception of a FIN-ACK-segment with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state triggers the sending of an ACK-segment") | Unknown             | Passed (Note 1)     |
|[rcv-fin-ack-time-wait-using-shutdown-outside-right-ipv6](rcv-fin-ack-time-wait-using-shutdown-outside-right-ipv6.pkt "Ensure that the reception of a FIN-ACK-segment with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state triggers the sending of an ACK-segment") | Unknown             | Passed (Note 1)     |

## Notes
1. The peer does not follow [RFC 0793](https://tools.ietf.org/html/rfc0793): It sends the FIN-bit using multiple `SEG.SEQ`.
