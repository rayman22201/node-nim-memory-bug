import strformat
import strutils
import sequtils
import json
import logging

proc hello_echo*(message: cstring):cstring {.exportc.} =
  ## Echo a message back
  echo "Nim message addr    : ", message.repr
  var res = &"{message} echo"
  echo "Nim res repr        : ", res.repr
  result = res
  GC_ref(res)
  echo "Nim result addr     : ", result.repr
  echo &"Nim echo result     : {result}"

proc hello_release*(x:cstring) {.exportc.} =
  echo "x.len: ", x.len
  echo "Nim release         : ", x.repr
  let it:string = cast[string](x)
  echo "Nim release it      : ", it.repr
  GC_unref(it)

