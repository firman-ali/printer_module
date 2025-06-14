import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'printer_module_platform_interface.dart';

/// An implementation of [PrinterModulePlatform] that uses method channels.
class MethodChannelPrinterModule extends PrinterModulePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('printer_module');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
