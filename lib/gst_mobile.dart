
import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:ffi/ffi.dart';

import 'gst_mobile_bindings_generated.dart';

const String _libName = 'gst_mobile';

/// The dynamic library in which the symbols for [GstMobileBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// The bindings to the native functions in [_dylib].
final GstMobileBindings _bindings = GstMobileBindings(_dylib);

String version() {
 Pointer<Char> v = _bindings.maao_gst_version();
  return v.cast<Utf8>().toDartString();
} 
