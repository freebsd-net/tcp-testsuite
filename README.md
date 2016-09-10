# TCP Testsuite for FreeBSD based on Packetdrill

This TCP testsuite focuses on testing FreeBSD's TCP stack.

It it based on the packetdrill testtool.
The original version is available from [Google's repository](https://github.com/google/packetdrill).
However, this version does not really run on FreeBSD.
An extended version is available from [NPLab's respository](https://github.com/nplab/packetdrill)
and overcomes this limitation and adds support for SCTP and UDPLite.

To run all test scripts, execute the `tcsh` script `run-all-tests` with root priviledges.

| Test Group                                                                     | Number of Test Scripts |
|:-------------------------------------------------------------------------------|:----------------------:|
| [Sending of SYN-Segments](snd-syn/README.md)                                   | 32                     |
| [Handling of ICMP Meassages](rcv-icmp/README.md)                               | 12                     |
| [Socket API](socket-api/README.md)                                             | 2                      |

This work is sponsored by Netflix, Inc.
