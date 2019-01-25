import strformat
import strutils
import sequtils
import json
import logging

var myRegion: MemRegion
# You just declare a region. Don't have to initialize it. The default 0 values are fine.
# Regions act like a little mini heap that you use and then throw away when you are done.
# They don't need to be GC'ed because they just get reset when you are done with them anyway.
# This is very efficient.

echo "clib initialized"

proc hello_echo*(message:cstring):cstring {.exportc.} =
  #var myRegion: MemRegion
  # You could also declare the region here if you wanted.
  # For this case it doesn't matter, but you can use multiple regions.
  # It's useful for some use cases to have regions per function or per category, etc...
  withRegion(myRegion):
    # this template is similar to the python "with file:" concept.
    # Everything in this block will allocate to testRegion.
    # then when the block is finished, the region gets reset.
    let msg = $message
    ## Echo a message back
    result = &"{msg} from nim"
    echo &"Nim echo result: {msg}"
    echo("Total memory available: " & formatSize(getTotalMem()) & " bytes")
    echo("Free memory: " & formatSize(getFreeMem()) & " bytes")
    echo("Occupied Memory: " & formatSize(getOccupiedMem()) & " bytes")
