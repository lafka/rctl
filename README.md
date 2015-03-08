Usage: rctl <command>
Speaks Rotel.

Where command is anything in `rctl commands`

Example: 
 ./rctl Power On > /dev/ttyUSB0

Broken. Please fix pegasus to include a proper regex for query string
and such (url decoding etc etc etc).

Dependencies:
 - lsqlite3
 - pegasus

-- pegasus sucks.... 
QUERY_STRING regex: '([^=]*)=([^&]*)&?'

see pegasus-query-string.patch
