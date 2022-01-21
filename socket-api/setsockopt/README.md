# Tests for setsockopt()

## Description
The list of socket options with level `IPPROTO_IP` being tested is:
* `IP_TOS`
* `IP_TTL`

The list of socket options with level `IPPROTO_IPV6` being tested is:
* `IPV6_TCLASS`
* `IPV6_UNICAST_HOPS`

## Status
| Name                                                                                                                                                                                        | Result FreeBSD Head |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|
|[socket-api-setsockopt-ttl-active-ipv4](socket-api-setsockopt-ttl-active-ipv4.pkt "Ensure that setting the TTL works for actively established connections")                                  | Passed              |
|[socket-api-setsockopt-hoplimit-active-ipv6](socket-api-setsockopt-hoplimit-active-ipv6.pkt "Ensure that setting the hop limit works for actively established connections")                  | Passed              |
|[socket-api-setsockopt-ttl-passive-ipv4](socket-api-setsockopt-ttl-passive-ipv4.pkt "Ensure that setting the TTL works for passively established connections")                               | Passed              |
|[socket-api-setsockopt-hoplimit-passive-ipv6](socket-api-setsockopt-hoplimit-passive-ipv6.pkt "Ensure that setting the hop limit works for passively established connections")               | Passed              |
|[socket-api-setsockopt-tos-active-ipv4](socket-api-setsockopt-tos-active-ipv4.pkt "Ensure that setting the TOS works for actively established connections")                                  | Passed              |
|[socket-api-setsockopt-traffic-class-active-ipv6](socket-api-setsockopt-traffic-class-active-ipv6.pkt "Ensure that setting the traffic class works for actively established connections")    | Passed              |
|[socket-api-setsockopt-tos-passive-ipv4](socket-api-setsockopt-tos-passive-ipv4.pkt "Ensure that setting the TOS works for passively established connections")                               | Passed              |
|[socket-api-setsockopt-traffic-class-passive-ipv6](socket-api-setsockopt-traffic-class-passive-ipv6.pkt "Ensure that setting the traffic class works for passively established connections") | Passed              |

## Notes
