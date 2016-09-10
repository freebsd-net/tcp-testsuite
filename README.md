# TCP Testsuite for FreeBSD based on Packetdrill

This TCP testsuite focuses on testing FreeBSD's TCP stack.

## Requirements
It it based on the packetdrill testtool.
The original version is available from [Google's repository](https://github.com/google/packetdrill).
However, this version does not really run on FreeBSD.
An extended version is available from [NPLab's respository](https://github.com/nplab/packetdrill)
and overcomes this limitation and adds support for SCTP and UDPLite.

To run all test scripts, execute the `tcsh` script `run-all-tests` with root priviledges.

## Structure of the Testsuite
| Test Group                                                                     | Number of Test Scripts |
|:-------------------------------------------------------------------------------|:----------------------:|
| [Sending of SYN-Segments](snd-syn/README.md)                                   | 32                     |
| [Handling of ICMP Messages](rcv-icmp/README.md)                                | 12                     |
| [Socket API](socket-api/README.md)                                             | 2                      |

## References
* [RFC 0793: *Transmission Control Protocol*](https://tools.ietf.org/html/rfc0793)
* [RFC 1122: *Requirements for Internet Hosts -- Communication Layers*](https://tools.ietf.org/html/rfc1122)
* [RFC 1323: *TCP Extensions for High Performance*](https://tools.ietf.org/html/rfc1323)
* [RFC 2018: *TCP Selective Acknowledgment Options*](https://tools.ietf.org/html/rfc2018)
* [RFC 2883: *An Extension to the Selective Acknowledgement (SACK) Option for TCP*](https://tools.ietf.org/html/rfc2883)
* [RFC 5461: *TCP's Reaction to Soft Errors*](https://tools.ietf.org/html/rfc5461)
* [RFC 5927: *ICMP Attacks against TCP*](https://tools.ietf.org/html/rfc5927)
* [RFC 6429: *TCP Sender Clarification for Persist Condition*](https://tools.ietf.org/html/rfc6429)

## Acknowledgement
This work is sponsored by Netflix, Inc.
