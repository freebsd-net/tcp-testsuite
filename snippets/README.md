# Snippets

## Description
This directory contains files with useful script fragments

## Status

| Name                                                                                                       | Result FreeBSD 11.0 | Result FreeBSD Head |
|:-----------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[closed-initially-ipv4](closed-initially-ipv4.pkt "Move to initial CLOSED state")                           | Unknown             | Passed              |
|[closed-initially-ipv6](closed-initially-ipv6.pkt "Move to initial CLOSED state")                           | Unknown             | Passed              |
|[listen-ipv4](listen-ipv4.pkt "Move to LISTEN state")                                                       | Unknown             | Passed              |
|[listen-ipv6](listen-ipv6.pkt "Move to LISTEN state")                                                       | Unknown             | Passed              |
|[syn-sent-ipv4](syn-sent-ipv4.pkt "Move to SYN-SENT state")                                                 | Unknown             | Passed              |
|[syn-sent-ipv6](syn-sent-ipv6.pkt "Move to SYN-SENT state")                                                 | Unknown             | Passed              |
|[syn-rcvd-via-listen-ipv4](syn-rcvd-via-listen-ipv4.pkt "Move to SYN-RCVD state via LISTEN")                | Unknown             | Passed              |
|[syn-rcvd-via-listen-ipv6](syn-rcvd-via-listen-ipv6.pkt "Move to SYN-RCVD state via LISTEN")                | Unknown             | Passed              |
|[syn-rcvd-via-syn-sent-ipv4](syn-rcvd-via-syn-sent-ipv4.pkt "Move to SYN-RCVD state via SYN-SENT")          | Unknown             | Passed (Note 1)     |
|[syn-rcvd-via-syn-sent-ipv4-ecn01](syn-rcvd-via-syn-sent-ipv4-ecn01.pkt "Move to SYN-RCVD state via SYN-SENT, Client ECN")          | Unknown             | Passed      |
|[syn-rcvd-via-syn-sent-ipv4-ecn10](syn-rcvd-via-syn-sent-ipv4-ecn10.pkt "Move to SYN-RCVD state via SYN-SENT, Server ECN")          | Unknown             | Passed      |
|[syn-rcvd-via-syn-sent-ipv4-ecn11](syn-rcvd-via-syn-sent-ipv4-ecn11.pkt "Move to SYN-RCVD state via SYN-SENT, Full ECN")          | Unknown             | Passed      |
|[syn-rcvd-via-syn-sent-ipv6](syn-rcvd-via-syn-sent-ipv6.pkt "Move to SYN-RCVD state via SYN-SENT")          | Unknown             | Passed (Note 1)     |
|[established-ipv4](established-ipv4.pkt "Move to ESTABLISHED state")                                        | Unknown             | Passed              |
|[established-ipv6](established-ipv6.pkt "Move to ESTABLISHED state")                                        | Unknown             | Passed              |
|[close-wait-ipv4](close-wait-ipv4.pkt "Move to CLOSE-WAIT state")                                           | Unknown             | Passed (Note 2)     |
|[close-wait-ipv6](close-wait-ipv6.pkt "Move to CLOSE-WAIT state")                                           | Unknown             | Passed (Note 2)     |
|[last-ack-ipv4](last-ack-ipv4.pkt "Move to LAST-ACK state")                                                 | Unknown             | Passed              |
|[last-ack-ipv6](last-ack-ipv6.pkt "Move to LAST-ACK state")                                                 | Unknown             | Passed              |
|[closed-via-last-ack-ipv4](closed-via-last-ack-ipv4.pkt "Move to CLOSED state via LAST-ACK")                | Unknown             | Passed (Note 3)     |
|[closed-via-last-ack-ipv6](closed-via-last-ack-ipv6.pkt "Move to CLOSED state via LAST-ACK")                | Unknown             | Passed (Note 3)     |
|[fin-wait-1-ipv4](fin-wait-1-ipv4.pkt "Move to FIN-WAIT-1 state")                                           | Unknown             | Passed              |
|[fin-wait-1-ipv6](fin-wait-1-ipv6.pkt "Move to FIN-WAIT-1 state")                                           | Unknown             | Passed              |
|[fin-wait-2-ipv4](fin-wait-2-ipv4.pkt "Move to FIN-WAIT-2 state")                                           | Unknown             | Passed              |
|[fin-wait-2-ipv6](fin-wait-2-ipv6.pkt "Move to FIN-WAIT-2 state")                                           | Unknown             | Passed              |
|[closing-ipv4](closing-ipv4.pkt "Move to CLOSING state")                                                    | Unknown             | Passed (Note 2)     |
|[closing-ipv6](closing-ipv6.pkt "Move to CLOSING state")                                                    | Unknown             | Passed (Note 2)     |
|[time-wait-via-fin-wait-1-ipv4](time-wait-via-fin-wait-1-ipv4.pkt "Move to TIME-WAIT state via FIN-WAIT-1") | Unknown             | Passed (Note 3, 4)  |
|[time-wait-via-fin-wait-1-ipv6](time-wait-via-fin-wait-1-ipv6.pkt "Move to TIME-WAIT state via FIN-WAIT-1") | Unknown             | Passed (Note 3, 4)  |
|[time-wait-via-fin-wait-2-ipv4](time-wait-via-fin-wait-2-ipv4.pkt "Move to TIME-WAIT state via FIN-WAIT-2") | Unknown             | Passed (Note 3)     |
|[time-wait-via-fin-wait-2-ipv6](time-wait-via-fin-wait-2-ipv6.pkt "Move to TIME-WAIT state via FIN-WAIT-2") | Unknown             | Passed (Note 3)     |
|[time-wait-via-closing-ipv4](time-wait-via-closing-ipv4.pkt "Move to TIME-WAIT state via CLOSING")          | Unknown             | Passed (Note 2, 3)  |
|[time-wait-via-closing-ipv6](time-wait-via-closing-ipv6.pkt "Move to TIME-WAIT state via CLOSING")          | Unknown             | Passed (Note 2, 3)  |

## Notes
1. Addressed with rS361346. All options are consistently dropped.
2. A FIN-segment without the ACK bit being set is dropped. This seems to be normal behaviour, although not specified.
3. TCP-level options can't be used for end points in the final CLOSED state or the TIME-WAIT state.
4. FreeBSD doesn't do the state transition `FIN-WAIT-1 -> TIMEWAIT` directly, but does `FIN-WAIT-1 -> FIN-WAIT-2 -> TIMEWAIT`.
