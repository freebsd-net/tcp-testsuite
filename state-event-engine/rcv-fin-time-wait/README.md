# Handling of TCP Segments with the FIN bit Set in the TIME-WAIT State

## Description
This set of tests focuses on the handling of FIN-segments in the `TIME-WAIT` state.

Receiving a TCP segment, which is not acceptable should trigger the sending of segment with `SEG.SEQ=SND.NXT` and `SEG.ACK=RCV.NXT`. FreeBSD currently drops all incoming FIN-segments without the ACK-bit being set in the state `TIME-WAIT`.

## Status

| Name                                                                                                                                                                                                                                                          | Result FreeBSD 11.0 | Result FreeBSD Head |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[rcv-fin-time-wait-using-shutdown-outside-left-ipv4](rcv-fin-time-wait-using-shutdown-outside-left-ipv4.pkt "Ensure that the reception of a FIN-segment with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT does not trigger the sending of an ACK-segment")               | Unknown             | Passed (Note 1)     |
|[rcv-fin-time-wait-using-shutdown-outside-left-ipv6](rcv-fin-time-wait-using-shutdown-outside-left-ipv6.pkt "Ensure that the reception of a FIN-segment with SEG.SEQ=RCV.NXT-1 in the TIME-WAIT does not trigger the sending of an ACK-segment")               | Unknown             | Passed (Note 1)     |
|[rcv-fin-time-wait-using-shutdown-left-edge-ipv4](rcv-fin-time-wait-using-shutdown-left-edge-ipv4.pkt "Ensure that the reception of a FIN-segment with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not trigger the sending of an ACK-segment")                 | Unknown             | Passed              |
|[rcv-fin-time-wait-using-shutdown-left-edge-ipv6](rcv-fin-time-wait-using-shutdown-left-edge-ipv6.pkt "Ensure that the reception of a FIN-segment with SEG.SEQ=RCV.NXT in the TIME-WAIT state does not trigger the sending of an ACK-segment")                 | Unknown             | Passed              |
|[rcv-fin-time-wait-using-shutdown-middle-ipv4](rcv-fin-time-wait-using-shutdown-middle-ipv4.pkt "Ensure that the reception of a FIN-segment with SEG.SEQ=RCV.NXT+1 in the TIME-WAIT state does not trigger the sending of an ACK-segment")                     | Unknown             | Passed              |
|[rcv-fin-time-wait-using-shutdown-middle-ipv6](rcv-fin-time-wait-using-shutdown-middle-ipv6.pkt "Ensure that the reception of a FIN-segment with SEG.SEQ=RCV.NXT+1 in the TIME-WAIT state does not trigger the sending of an ACK-segment")                     | Unknown             | Passed              |
|[rcv-fin-time-wait-using-shutdown-right-edge-ipv4](rcv-fin-time-wait-using-shutdown-right-edge-ipv4.pkt "Ensure that the reception of a FIN-segment with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state does not trigger the sending of an ACK-segment")     | Unknown             | Passed              |
|[rcv-fin-time-wait-using-shutdown-right-edge-ipv6](rcv-fin-time-wait-using-shutdown-right-edge-ipv6.pkt "Ensure that the reception of a FIN-segment with SEG.SEQ=RCV.NXT+RCV.WND-1 in the TIME-WAIT state does not trigger the sending of an ACK-segment")     | Unknown             | Passed              |
|[rcv-fin-time-wait-using-shutdown-outside-right-ipv4](rcv-fin-time-wait-using-shutdown-outside-right-ipv4.pkt "Ensure that the reception of a FIN-segment with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state does not trigger the sending of an ACK-segment") | Unknown             | Passed (Note 1)     |
|[rcv-fin-time-wait-using-shutdown-outside-right-ipv6](rcv-fin-time-wait-using-shutdown-outside-right-ipv6.pkt "Ensure that the reception of a FIN-segment with SEG.SEQ=RCV.NXT+RCV.WND in the TIME-WAIT state does not trigger the sending of an ACK-segment") | Unknown             | Passed (Note 1)     |

## Notes
1. [RFC 0793](https://tools.ietf.org/html/rfc0793) requires the sending of an ACK-segment with `SEG.SEQ=SND.NXT` and `SEG.ACK=RCV.NXT` in response to incoming segments having an `SEG.SEQ` not being acceptable. FreeBSD currently does not send these.
