import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:printer_module/printer_module.dart';
import 'package:printer_module/src/printer_module.dart';
import 'package:printer_module/src/printer_module_method_channel.dart';
import 'package:printer_module/src/printer_module_platform_interface.dart';

class MockPrinterModulePlatform
    with MockPlatformInterfaceMixin
    implements PrinterModulePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PrinterModulePlatform initialPlatform = PrinterModulePlatform.instance;

  test('$MethodChannelPrinterModule is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPrinterModule>());
  });

  test('getPlatformVersion', () async {
    PrinterModule printerModulePlugin = PrinterModule();
    MockPrinterModulePlatform fakePlatform = MockPrinterModulePlatform();
    PrinterModulePlatform.instance = fakePlatform;

    expect(await printerModulePlugin.getPlatformVersion(), '42');
  });
}
