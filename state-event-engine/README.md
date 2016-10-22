
# Testing the State-Event-Engine of TCP

## Description
The following diagram from  [RFC 793, Section 3.2](https://tools.ietf.org/html/rfc793#section-3.2)
with corrections from [RFC 1122, Section 4.2.2.8](https://tools.ietf.org/html/rfc1122#section-4.2.2.8)
shows the TCP state-event-engine.
```
                                       +---------+ ---------\      active OPEN
                                       |  CLOSED |            \    -----------
                                       +---------+<---------\   \   create TCB
                                         |     ^              \   \  snd SYN
                            passive OPEN |     |   CLOSE        \   \
                            ------------ |     | ----------       \   \
                             create TCB  |     | delete TCB         \   \
                                         V     |                      \   \
                        rcv RST        +---------+            CLOSE    |    \
                 --------------------->|  LISTEN |          ---------- |     |
               /                       +---------+          delete TCB |     |
               |            rcv SYN      |     |     SEND              |     |
               |           -----------   |     |    -------            |     V
          +---------+      snd SYN,ACK  /       \   snd SYN          +---------+
          |         |<-----------------           ------------------>|         |
          |   SYN   |                    rcv SYN                     |   SYN   |
          |   RCVD  |<-----------------------------------------------|   SENT  |
          |         |                  snd SYN,ACK                   |         |
          |         |------------------           -------------------|         |
          +---------+   rcv ACK of SYN  \       /  rcv SYN,ACK       +---------+
               |        --------------   |     |   -----------
               |               x         |     |     snd ACK
               |                         V     V
        CLOSE  |                       +---------+
       ------- |                       |  ESTAB  |
       snd FIN |                       +---------+
               |                CLOSE    |     |    rcv FIN
               V               -------   |     |    -------
          +---------+          snd FIN  /       \   snd ACK          +---------+
          |  FIN    |<-----------------           ------------------>|  CLOSE  |
          | WAIT-1  |---------------------                           |   WAIT  |
          +---------+                      \   rcv FIN               +---------+
rcv ACK of FIN ||                           |  -------                    |  CLOSE 
-------------- | \                          |  snd ACK                    | -------
       x       V   ---    rcv FIN,ACK       V                             V snd FIN
          +---------+  \  -----------  +---------+                   +---------+
          |FINWAIT-2|   |   snd ACK    | CLOSING |                   | LAST-ACK|
          +---------+   \              +---------+                   +---------+
               |          --------------    |                             |
               |                         \  | rcv ACK of FIN              | rcv ACK of FIN
       rcv FIN |                          | | --------------              | --------------
       ------- |                          V V        x                    V       x
       snd ACK  \                      +---------+                   +---------+
                  -------------------->|TIME WAIT|------------------>| CLOSED  |
                                       +---------+   Timeout=2MSL    +---------+
                                                     ------------
                                                      delete TCB 
```
[RFC 1337](https://tools.ietf.org/html/rfc1337) describes the handling of RST segments
in the TIME-WAIT state.
[RFC 5961](https://tools.ietf.org/html/rfc5961) improves the handling of SYS and RST segments.

## Status

|                 |  SYN     | SYN-ACK  | SYN-FIN  | ACK      | FIN      | FIN-ACK  | RST      | RST-ACK  |
|:----------------|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|
|**CLOSED**       |          |          |          |          |          |          |          |          |
|**LISTEN**       |          |          |          |          |          |          |          |          |
|**SYN-SENT**     |          |          |          |          |          |          |          |          |
|**SYN-RCVD**     |          |          |          |          |          |          |          |          |
|**ESTABLISHED**  |          |          |          |          |          |          |          |          |
|**FIN-WAIT-1**   |          |          |          |          |          |          |          |          |
|**FIN-WAIT-2**   |          |          |          |          |          |          |          |          |
|**CLOSE-WAIT**   |          |          |          |          |          |          |          |          |
|**CLOSING**      |          |          |          |          |          |          |          |          |
|**TIME-WAIT**    |          |          |          |          |          |          |          |          |

## References
* [RFC 793: *Transmission Control Protocol*](https://tools.ietf.org/html/rfc0793)
* [RFC 1122: *Requirements for Internet Hosts -- Communication Layers*](https://tools.ietf.org/html/rfc1122)
* [RFC 1337: *TIME-WAIT Assassination Hazards in TCP*](https://tools.ietf.org/html/rfc1337)
* [RFC 5961: *Improving TCP's Robustness to Blind In-Window Attacks*](https://tools.ietf.org/html/rfc5961)
