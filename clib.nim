import strformat
import strutils
import sequtils
import json
import logging

echo "clib initialized"

proc hello_echo*(message:cstring):cstring {.exportc.} =
  ## Echo a message back
  result = &"{message} echo"
  echo &"Nim echo result: {result}"
