# Testing RFC3168 ECN in TCP

## Description
* Explicit Congestion Notification is a mechanism by
which the network can expose impeding congestion to an
affected connection, before packet loss has to happen.

By default, FreeBSD has ECN passive enabled, that is,
a Client requesting ECN support during the initial SYN
segment may use this capability, but connections
originating from FreeBSD are not requesting ECN actively.

These tests verify the RFC3168 compliant behavior,
including CWR on RTO, ECT0 mark only on new data segments
but not on control, pure ACK or retransmitted segments.

## References
* [RFC3168: *The Addition of Explicit Congestion Notification (ECN) to IP*](https://tools.ietf.org/html/rfc3168)
