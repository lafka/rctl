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

--- /usr/share/lua/5.2/pegasus/request.lua  2015-03-08 05:47:34.611849979 +0100
+++ rreq.lua    2015-03-08 05:47:19.648824038 +0100
@@ -45,7 +45,7 @@
   self._method = method
 end
 
-Request.PATTERN_QUERY_STRING = '(%w+)=(%w+)'
+Request.PATTERN_QUERY_STRING = '([^=]*)=([^&]*)&?'
 
 function Request:parseURLEncoded(value, _table)
   --value exists and _table is empty

