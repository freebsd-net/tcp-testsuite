# TCP Testsuite for FreeBSD based on Packetdrill

This TCP testsuite focuses on testing FreeBSD's TCP stack.

It it based on the packetdrill testtool.
The original version is available from [Google's repsoitory](https://github.com/google/packetdrill).
However, this version does not really run on FreeBSD.
An extended version is available from [NPLab's respository](https://github.com/nplab/packetdrill)
and overcomes this limitation and adds support for SCTP and UDPLite.

To run all test scripts, execute the `tcsh` script `run-all-tests`.

This work is sponsored by Netflix, Inc.
