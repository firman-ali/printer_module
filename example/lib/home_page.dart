import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printer_module/printer_module.dart';

import 'data_selection_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PrinterType? _printerType;
  String _platformVersion = 'Unknown';
  final _printerModulePlugin = PrinterModule();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _printerModulePlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void connectPrinter() async {
    final result = await DataSelectionSheet.show(
      context: context,
      items: PrinterType.values,
      title: 'Pilih Printer',
      searchHint: 'Cari printer...',
      showSearch: true,
    );

    if (result != null) {
      _printerType = result;
      _printerModulePlugin.connectPrinter(result);
    }
  }

  void statusPrinter() async {
    if (_printerType == null) return;
    final status = await _printerModulePlugin.printerStatus(_printerType!);
    final snackBar = SnackBar(content: Text('Status Printer: $status'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void testPrinter() async {
    if (_printerType == null) return;
    final commands = [PrintText('Hello, World!'), PrintText('This is a test.')];
    await _printerModulePlugin.prints(
      printerType: _printerType!,
      commands: commands,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin example app')),
      body: Column(
        children: [
          Center(child: Text('Running on: $_platformVersion\n')),
          SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: connectPrinter,
            child: Text("Connect Printer"),
          ),
          SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: statusPrinter,
            child: Text("Status Printer"),
          ),
          SizedBox(height: 24.0),
          ElevatedButton(onPressed: testPrinter, child: Text("Test Printer")),
        ],
      ),
    );
  }
}
