import 'printer_module_platform_interface.dart';

class PrinterModule {
  Future<String?> getPlatformVersion() {
    return PrinterModulePlatform.instance.getPlatformVersion();
  }
}
