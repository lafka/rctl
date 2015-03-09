

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

Connecting to Rotel devices
============================

You'll need some cables: 
The Rotel needs a rj45 to serial adapter (ie db9) and

The other end will (the talking end) needs
a serial port, or a USB-to-serial device (ie FTDI).

Tools for controlling Rotel equipment over Computer I/O serial line.
Make your rj45 serial to db9 rotel-compliant:
rotel-rj45  - db9
3 tx        - 2 rx
4 gnd       - 5 gnd
5 rx        - 3 tx
6 gnd       - 5 gnd

quipped the "rj4-9"

This is a serial binary protocol with a common command set.
Commands are sent with a device id, type and checksum

Serial lines are either 19200 or 32800 baud, depending on the model.

Please check the manual for your specific device, ie RSP1068 Commands.pdf
from the rotel website.

Troubleshooting
===============

There are two questions you need to ask of yourself:

 * Am I using a crossover cable?
 * Did I remember to patch pegasus?




