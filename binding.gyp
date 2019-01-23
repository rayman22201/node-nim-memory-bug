{
  "targets": [
    {
      "target_name": "hellolib",
      "sources": [
        "<!@(node -p \"require('fs').readdirSync('./csrc').map(f=>'csrc/'+f).join(' ')\")",
        "jstonimbinding.cpp",
      ],
      "include_dirs": [
          "<!@(node -p \"require('node-addon-api').include\")",
          "csrc",
      ],
      'dependencies': [
        "<!(node -p \"require('node-addon-api').gyp\")"
      ],
      'cflags!': [ '-fno-exceptions' ],
      'cflags_cc!': [ '-fno-exceptions' ],
      'xcode_settings': {
        'GCC_ENABLE_CPP_EXCEPTIONS': 'YES',
        'CLANG_CXX_LIBRARY': 'libc++',
        'MACOSX_DEPLOYMENT_TARGET': '10.7',
      },
      'msvs_settings': {
        'VCCLCompilerTool': { 'ExceptionHandling': 1 },
      },
    },
    {
      "target_name": "action_after_build",
      "type": "none",
      "dependencies": ["hellolib"],
      "copies": [
        {
          "files": ["<(PRODUCT_DIR)/hellolib.node"],
          "destination": "lib/",
        }
      ]
    }
  ]
}