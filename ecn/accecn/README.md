# Testing the Accurate ECN extension of TCP

## Description
* Accurate ECN (AccECN) is a proposed extension, which
cleanly negotiates different semantics for the TCP flag
bits, and convey all observed CE marks back to the sender.

These tests validate the expected behavior of a AccECN
server and client, when exposed to various IP ECN marks
on the SYN (first) and SYN,ACK (second indication in the
name of the test).

Furthermore, interaction with Non-ECN, RFC3168-ECN and
broken/enhanced clients is verified.

Note that these tests require a patched version of
packetdrill to run. The packetdrill patch may be found
here: (https://github.com/rscheff/packetdrill/tree/AccECN-update) for FreeBSD
and here: (https://github.com/rscheff/packetdrill-1/tree/AccECN) for upstream Packetdrill.

## References
* [Acc-ECN: *More Accurate ECN Feedback in TCP*](https://tools.ietf.org/html/draft-ietf-tcpm-accurate-ecn)
