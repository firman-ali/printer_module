import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'printer_module_method_channel.dart';

abstract class PrinterModulePlatform extends PlatformInterface {
  /// Constructs a PrinterModulePlatform.
  PrinterModulePlatform() : super(token: _token);

  static final Object _token = Object();

  static PrinterModulePlatform _instance = MethodChannelPrinterModule();

  /// The default instance of [PrinterModulePlatform] to use.
  ///
  /// Defaults to [MethodChannelPrinterModule].
  static PrinterModulePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PrinterModulePlatform] when
  /// they register themselves.
  static set instance(PrinterModulePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
