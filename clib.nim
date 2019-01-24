import strformat
import strutils
import sequtils
import json
import logging

proc hello_echo*(message: cstring):cstring {.exportc.} =
  ## Echo a message back
  echo "Nim message addr    : ", message.repr
  var res = &"{message} echo"
  echo "Nim res addr        : ", res.repr
  GC_ref(res)
  result = addr res[0]

proc hello_release*(x:cstring) {.exportc.} =
  echo "x.len: ", x.len
  echo "Nim release         : ", x.repr
  let it:string = cast[string](x)
  echo "Nim release it      : ", it.repr
  GC_unref(it)

