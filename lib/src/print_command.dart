import 'dart:convert';
import 'dart:typed_data';

enum PrintAlign { left, center, right }

abstract class PrintCommand {
  Map<String, dynamic> toJson();
}

class PrintText extends PrintCommand {
  final String text;
  final int fontSize;
  final PrintAlign align;
  final bool isBold;
  final int printSize;

  PrintText(
    this.text, {
    this.fontSize = 0,
    this.align = PrintAlign.left,
    this.isBold = false,
    this.printSize = 58,
  });

  @override
  Map<String, dynamic> toJson() => {
    'type': 'text',
    'text': text,
    'fontSize': fontSize,
    'align': align.index,
    'isBold': isBold,
    'printSize': printSize,
  };
}

class PrintSeparator extends PrintCommand {
  @override
  Map<String, dynamic> toJson() => {'type': 'separator'};
}

class PrintFeed extends PrintCommand {
  final int lines;
  final int printSize;

  PrintFeed(this.lines, {this.printSize = 58});

  @override
  Map<String, dynamic> toJson() => {
    'type': 'feed',
    'lines': lines,
    'printSize': printSize,
  };
}

class PrintCut extends PrintCommand {
  @override
  Map<String, dynamic> toJson() => {'type': 'cut'};
}

class PrintLeftRight extends PrintCommand {
  final String leftText;
  final String rightText;
  final int printSize;

  PrintLeftRight(this.leftText, this.rightText, {this.printSize = 58});

  @override
  Map<String, dynamic> toJson() => {
    'type': 'leftRight',
    'leftText': leftText,
    'rightText': rightText,
    'printSize': printSize,
  };
}

class PrintThreeLine extends PrintCommand {
  final String leftText;
  final String centerText;
  final String rightText;
  final int printSize;

  PrintThreeLine(
    this.leftText,
    this.centerText,
    this.rightText, {
    this.printSize = 58,
  });

  @override
  Map<String, dynamic> toJson() => {
    'type': 'threeLines',
    'leftText': leftText,
    'centerText': centerText,
    'rightText': rightText,
    'printSize': printSize,
  };
}

class PrintQr extends PrintCommand {
  final String qrText;
  final PrintAlign align;
  final int size;
  final int printSize;

  PrintQr(this.qrText, this.align, this.size, {this.printSize = 58});

  @override
  Map<String, dynamic> toJson() => {
    'type': 'qr',
    'qrText': qrText,
    'align': align.index,
    'size': size,
    'printSize': printSize,
  };
}

class PrintBitmap extends PrintCommand {
  final Uint8List imageBytes;
  final int imageWidth;
  final int imageHeight;
  final PrintAlign align;
  final int printSize;

  PrintBitmap(
    this.imageBytes,
    this.imageWidth,
    this.imageHeight,
    this.align, {
    this.printSize = 58,
  });

  @override
  Map<String, dynamic> toJson() => {
    'type': 'bitmap',
    'imageStr': base64Encode(imageBytes),
    'imageWidth': imageWidth,
    'imageHeight': imageHeight,
    'align': align.index,
    'printSize': printSize,
  };
}

class PrintSingleBitmap extends PrintCommand {
  final Uint8List imageBytes;
  final PrintAlign align;
  final int printSize;

  PrintSingleBitmap(this.imageBytes, this.align, {this.printSize = 58});

  @override
  Map<String, dynamic> toJson() => {
    'type': 'singleBitmap',
    'imageStr': base64Encode(imageBytes),
    'align': align.index,
    'printSize': printSize,
  };
}

class PrintReset extends PrintCommand {
  @override
  Map<String, dynamic> toJson() => {'type': 'reset'};
}

class PrintStartPrinting extends PrintCommand {
  @override
  Map<String, dynamic> toJson() => {'type': 'startPrint'};
}
