// @ts-ignore
import * as hellolib from '../lib/hellolib.node';

interface HelloCLib {
  // Keep this in sync with jstonimbinding.cpp
  start():void;
  echo(message:string):string;
}

hellolib.start();
export const main:HelloCLib = hellolib;
