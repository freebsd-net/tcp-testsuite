# Tests for getsockopt()

## Description
The list of socket options with level `IPPROTO_TCP` being tested is:
* `TCP_KEEPCNT`
* `TCP_KEEPIDLE`
* `TCP_KEEPINIT`
* `TCP_KEEPINTVL`
* `TCP_INFO`

## Status
| Name                                                                                                                                                                                                                                  | Result FreeBSD 11.0 | Result FreeBSD Head |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[socket-api-getsockopt-keepcnt-inherited-from-sysctl-ipv4](socket-api-getsockopt-keepcnt-inherited-from-sysctl-ipv4.pkt "Ensure that the keepcnt timeout is inherited from the sysctl variable keepcnt")                               | Failed  (Note 1)    | Passed              |
|[socket-api-getsockopt-keepcnt-inherited-from-sysctl-ipv6](socket-api-getsockopt-keepcnt-inherited-from-sysctl-ipv6.pkt "Ensure that the keepcnt timeout is inherited from the sysctl variable keepcnt")                               | Failed  (Note 1)    | Passed              |
|[socket-api-getsockopt-keepidle-inherited-from-sysctl-ipv4](socket-api-getsockopt-keepidle-inherited-from-sysctl-ipv4.pkt "Ensure that the keepidle timeout is inherited from the sysctl variable keepidle")                           | Failed  (Note 2)    | Passed              |
|[socket-api-getsockopt-keepidle-inherited-from-sysctl-ipv6](socket-api-getsockopt-keepidle-inherited-from-sysctl-ipv6.pkt "Ensure that the keepidle timeout is inherited from the sysctl variable keepidle")                           | Failed  (Note 2)    | Passed              |
|[socket-api-getsockopt-keepinit-inherited-from-sysctl-ipv4](socket-api-getsockopt-keepinit-inherited-from-sysctl-ipv4.pkt "Ensure that the keepinit timeout is inherited from the sysctl variable keepinit")                           | Failed  (Note 3)    | Passed              |
|[socket-api-getsockopt-keepinit-inherited-from-sysctl-ipv6](socket-api-getsockopt-keepinit-inherited-from-sysctl-ipv6.pkt "Ensure that the keepinit timeout is inherited from the sysctl variable keepinit")                           | Failed  (Note 3)    | Passed              |
|[socket-api-getsockopt-keepintvl-inherited-from-sysctl-ipv4](socket-api-getsockopt-keepintvl-inherited-from-sysctl-ipv4.pkt "Ensure that the keepintvl timeout is inherited from the sysctl variable keepintvl")                       | Failed  (Note 4)    | Passed              |
|[socket-api-getsockopt-keepintvl-inherited-from-sysctl-ipv6](socket-api-getsockopt-keepintvl-inherited-from-sysctl-ipv6.pkt "Ensure that the keepintvl timeout is inherited from the sysctl variable keepintvl")                       | Failed  (Note 4)    | Passed              |
|[socket-api-getsockopt-tcpinfo-ipv4](socket-api-getsockopt-tcpinfo-ipv4.pkt "Ensure that TCPINFO can be used to get the tcpi_options")                                                                                                 | Failed  (Note 5)    | Passed              |
|[socket-api-getsockopt-tcpinfo-ipv6](socket-api-getsockopt-tcpinfo-ipv6.pkt "Ensure that TCPINFO can be used to get the tcpi_options")                                                                                                 | Failed  (Note 5)    | Passed              |

## Notes
1. When using `getsockopt()` with the level `IPPROTO_TCP` and name `TCP_KEEPCNT`, the value 0 instead of the actual
   value used is returned when the default value inherited from the sysctl variable `net.inet.tcp.keepcnt` is used.
   This was fixed in [r305810](305810) ([D7833](https://reviews.freebsd.org/D7833)).
2. When using `getsockopt()` with the level `IPPROTO_TCP` and name `TCP_KEEPIDLE`, the value 0 instead of the actual
   value used is returned when the default value inherited from the sysctl variable `net.inet.tcp.keepidle` is used.
   This was fixed in [r305810](305810) ([D7833](https://reviews.freebsd.org/D7833)).
3. When using `getsockopt()` with the level `IPPROTO_TCP` and name `TCP_KEEPINIT`, the value 0 instead of the actual
   value used is returned when the default value inherited from the sysctl variable `net.inet.tcp.keepinit` is used.
   This was fixed in [r305810](305810) ([D7833](https://reviews.freebsd.org/D7833)).
4. When using `getsockopt()` with the level `IPPROTO_TCP` and name `TCP_KEEPINTVL`, the value 0 instead of the actual
   value used is returned when the default value inherited from the sysctl variable `net.inet.tcp.keepintvl` is used.
   This was fixed in [r305810](305810) ([D7833](https://reviews.freebsd.org/D7833)).
5. When using `getsockopt()` with the level `IPPROTO_TCP` and name `TCP_INFO`, `TCPI_OPT_ECN` is not set in `tcpi_options`.
   This was fixed in [r305810](305810) ([D7833](https://reviews.freebsd.org/D7833)).
