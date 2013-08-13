# Boaldyn client-server protocol

This is short and quick explanation how Boaldyn server communicate
with client and how client sends replies.

Communication is done in plain text, JSON format. 

When server start connection, it sends this text:

```
{ "check"       : "<command>",
  "cmd"         : "<command>",
  "halt-on-fail": true/false,
  "reply"       : "http://server-url:port/client/<id>"}
```
