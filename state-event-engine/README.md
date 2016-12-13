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
[RFC 5961](https://tools.ietf.org/html/rfc5961) specifies an alternate handling of SYN and RST segments for improved security.

## Structure

The following table shows the number of tests for handling TCP segments in the various states.

|                 | SYN                                 | SYN-ACK                                | SYN-FIN                                | ACK                                | FIN                                | FIN-ACK                                | RST                                 | RST-ACK                                |
|:----------------|:-----------------------------------:|:--------------------------------------:|:--------------------------------------:|:----------------------------------:|:----------------------------------:|:--------------------------------------:|:-----------------------------------:|:--------------------------------------:|
|**CLOSED**       | [4](rcv-syn-closed/README.md)       | [4](rcv-syn-ack-closed/README.md)      | [4](rcv-syn-fin-closed/README.md)      | [4](rcv-ack-closed/README.md)      | [4](rcv-fin-closed/README.md)      | [4](rcv-fin-ack-closed/README.md)      | [4](rcv-rst-closed/README.md)       | [4](rcv-rst-ack-closed/README.md)      |
|**LISTEN**       | [x](rcv-syn-listen/README.md)       | [4](rcv-syn-ack-listen/README.md)      | [x](rcv-syn-fin-listen/README.md)      | [4](rcv-ack-listen/README.md)      | [x](rcv-fin-listen/README.md)      | [4](rcv-fin-ack-listen/README.md)      | [4](rcv-rst-listen/README.md)       | [4](rcv-rst-ack-listen/README.md)      |
|**SYN-SENT**     | [x](rcv-syn-syn-sent/README.md)     | [x](rcv-syn-ack-syn-sent/README.md)    | [x](rcv-syn-fin-syn-sent/README.md)    | [x](rcv-ack-syn-sent/README.md)    | [x](rcv-fin-syn-sent/README.md)    | [x](rcv-fin-ack-syn-sent/README.md)    | [6](rcv-rst-syn-sent/README.md)     | [6](rcv-rst-ack-syn-sent/README.md)    |
|**SYN-RCVD**     | [x](rcv-syn-syn-rcvd/README.md)     | [x](rcv-syn-ack-syn-rcvd/README.md)    | [x](rcv-syn-fin-syn-rcvd/README.md)    | [x](rcv-ack-syn-rcvd/README.md)    | [x](rcv-fin-syn-rcvd/README.md)    | [x](rcv-fin-ack-syn-rcvd/README.md)    | [32](rcv-rst-syn-rcvd/README.md)    | [x](rcv-rst-ack-syn-rcvd/README.md)    |
|**ESTABLISHED**  | [16](rcv-syn-established/README.md) | [x](rcv-syn-ack-established/README.md) | [x](rcv-syn-fin-established/README.md) | [x](rcv-ack-established/README.md) | [x](rcv-fin-established/README.md) | [x](rcv-fin-ack-established/README.md) | [16](rcv-rst-established/README.md) | [x](rcv-rst-ack-established/README.md) |
|**CLOSE-WAIT**   | [16](rcv-syn-close-wait/README.md)  | [x](rcv-syn-ack-close-wait/README.md)  | [x](rcv-syn-fin-close-wait/README.md)  | [x](rcv-ack-close-wait/README.md)  | [x](rcv-fin-close-wait/README.md)  | [x](rcv-fin-ack-close-wait/README.md)  | [16](rcv-rst-close-wait/README.md)  | [x](rcv-rst-ack-close-wait/README.md)  |
|**FIN-WAIT-1**   | [16](rcv-syn-fin-wait-1/README.md)  | [x](rcv-syn-ack-fin-wait-1/README.md)  | [x](rcv-syn-fin-fin-wait-1/README.md)  | [x](rcv-ack-fin-wait-1/README.md)  | [x](rcv-fin-fin-wait-1/README.md)  | [x](rcv-fin-ack-fin-wait-1/README.md)  | [16](rcv-rst-fin-wait-1/README.md)  | [x](rcv-rst-ack-fin-wait-1/README.md)  |
|**CLOSING**      | [16](rcv-syn-closing/README.md)     | [x](rcv-syn-ack-closing/README.md)     | [x](rcv-syn-fin-closing/README.md)     | [x](rcv-ack-closing/README.md)     | [x](rcv-fin-closing/README.md)     | [x](rcv-fin-ack-closing/README.md)     | [16](rcv-rst-closing/README.md)     | [x](rcv-rst-ack-closing/README.md)     |
|**LAST-ACK**     | [16](rcv-syn-last-ack/README.md)    | [x](rcv-syn-ack-last-ack/README.md)    | [x](rcv-syn-fin-last-ack/README.md)    | [x](rcv-ack-last-ack/README.md)    | [x](rcv-fin-last-ack/README.md)    | [x](rcv-fin-ack-last-ack/README.md)    | [16](rcv-rst-last-ack/README.md)    | [x](rcv-rst-ack-last-ack/README.md)    |
|**FIN-WAIT-2**   | [16](rcv-syn-fin-wait-2/README.md)  | [x](rcv-syn-ack-fin-wait-2/README.md)  | [x](rcv-syn-fin-fin-wait-2/README.md)  | [x](rcv-ack-fin-wait-2/README.md)  | [x](rcv-fin-fin-wait-2/README.md)  | [x](rcv-fin-ack-fin-wait-2/README.md)  | [16](rcv-rst-fin-wait-2/README.md)  | [x](rcv-rst-ack-fin-wait-2/README.md)  |
|**TIME-WAIT**    | [16](rcv-syn-time-wait/README.md)   | [x](rcv-syn-ack-time-wait/README.md)   | [x](rcv-syn-fin-time-wait/README.md)   | [x](rcv-ack-time-wait/README.md)   | [x](rcv-fin-time-wait/README.md)   | [x](rcv-fin-ack-time-wait/README.md)   | [16](rcv-rst-time-wait/README.md)   | [x](rcv-rst-ack-time-wait/README.md)   |

## Notes
1. The condition in [RFC 5961](https://tools.ietf.org/html/rfc5961#section-3.2) defining
   `outside the current receive window` should read
   `(SEG.SEQ < RCV.NXT || SEG.SEQ >= RCV.NXT + RCV.WND)`
   instead of
   `(SEG.SEQ <= RCV.NXT || SEG.SEQ > RCV.NXT + RCV.WND)`.
   This has been reported as [Errata 4845](http://www.rfc-editor.org/errata_search.php?rfc=5961&eid=4845).

## Fixes
* [r307727](https://svnweb.freebsd.org/changeset/base/307727) and [307746](https://svnweb.freebsd.org/changeset/base/307746).
* [r308745](https://svnweb.freebsd.org/changeset/base/308745) ([D8371](https://reviews.freebsd.org/D8371)).
* [r308832](https://svnweb.freebsd.org/changeset/base/308832) ([D8443](https://reviews.freebsd.org/D8443)).
* [r309397](https://svnweb.freebsd.org/changeset/base/309397) ([D8667](https://reviews.freebsd.org/D8667)).

## References
* [RFC 793: *Transmission Control Protocol*](https://tools.ietf.org/html/rfc0793)
* [RFC 1122: *Requirements for Internet Hosts -- Communication Layers*](https://tools.ietf.org/html/rfc1122)
* [RFC 1337: *TIME-WAIT Assassination Hazards in TCP*](https://tools.ietf.org/html/rfc1337)
* [RFC 5961: *Improving TCP's Robustness to Blind In-Window Attacks*](https://tools.ietf.org/html/rfc5961)
