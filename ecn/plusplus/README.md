# Testing the ECN+ and ECN++ extensions of TCP

## Description
* RFC3168 ECN only allows data segments as ECN capable transport (ECT),
while control, pure ACK and retransmissions are to be set as Not-ECT.
* ECN+ allows the SYN/ACK to be sent as ECT, while otherwise identical 
to RFC3168
* ECN++ allows all control, pure ACK and retransmissions to be ECT - 
bascially every TCP segment may be ECT

## References
* [RFC 3168: *The Addition of Explicit Congestion Notification (ECN) to IP*](https://tools.ietf.org/html/rfc3168)
* [RFC 5562: *Adding Explicit Congestion Notification (ECN) Capability to TCP's SYN/ACK Packets*](https://tools.ietf.org/html/rfc5562)
* [Generalized-ECN: *ECN++: Adding Explicit Congestion Notification (ECN) to TCP Control Packets*](https://tools.ietf.org/html/draft-ietf-tcpm-generalized-ecn)
