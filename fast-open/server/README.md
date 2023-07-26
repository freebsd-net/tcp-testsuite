# Snippets

## Description
This directory contains files to validate the TCP FastOpen server-side

## Status

| Name                                                                                                 | Result FreeBSD 13.0 | Result FreeBSD Head |
|:-----------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|
|[server-cookie-req](server-cookie-req.pkt "Perform basic TFO cookie request")                         | Unknown             | PASSED (Note 1)     |
|[server-correct-cookie](server-correct-cookie.pkt "Do a TFO SYN+Data with the correct cookie")        | Unknown             | PASSED (Note 1)     |
|[server-wrong-cookie](server-wrong-cookie.pkt "Validate SYN data is rejected with wrong cookie")      | Unknown             | PASSED (Note 1)     |
|[server-data-on-synack](server-data-on-synack "Check if server data is returned on SYN,ACK")          | Unknown             | PASSED (Note 1)     |
## Notes
1. Requires the setkey utility provided