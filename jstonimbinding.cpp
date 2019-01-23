// When you edit/update methods in this file, update the type declaration in jssrc/main.ts accordingly.
#include "napi.h"
#include <clib.h>
#include <iostream>
using namespace std;
using namespace Napi;

N_CDECL(void, NimMain)(void);

// start
Value start(const CallbackInfo& info) {
  Env env = info.Env();
  NimMain();
  return env.Undefined();
}

// echo
String echo(const CallbackInfo& info) {
  Env env = info.Env();
  std::string js_message = info[0].As<Value>().ToString().Utf8Value();
  const char* message = js_message.c_str();
  cout << "C++ passing message: " << message << "\n";
  char* retval = hello_echo(
    (char *)(message)
  );
  return String::New(env, retval);
}

Object Init(Env env, Object exports) {
  exports.Set(String::New(env, "start"),
    Function::New(env, start));
  exports.Set(String::New(env, "echo"),
    Function::New(env, echo));
  return exports;
}

NODE_API_MODULE(hellolib, Init)
