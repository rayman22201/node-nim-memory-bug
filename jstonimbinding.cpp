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
  String js_message = info[0].As<String>();
  cout << "C++ js_message addr : " << (void*)js_message << "\n";
  const char* message = js_message.Utf8Value().c_str();
  cout << "C++ message addr    : " << (void*)message << "\n";
  // cout << "C++ passing message : " << message << "\n";
  char* retval = hello_echo(
    (char *)(message)
  );
  cout << "C++ retval addr     : " << (void*)retval << "\n";
  String result = String::New(env, retval);
  cout << "C++ result addr     : " << (void*)result << "\n";
  // hello_release(
  //   (char *)(retval)
  // );
  return result;
}

// release
Value release(const CallbackInfo& info) {

}

Object Init(Env env, Object exports) {
  exports["start"] = Function::New(env, start);
  exports["echo"] = Function::New(env, echo);
  return exports;
}

NODE_API_MODULE(hellolib, Init)
