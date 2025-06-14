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

  PrintText(
    this.text, {
    this.fontSize = 0,
    this.align = PrintAlign.left,
    this.isBold = false,
  });

  @override
  Map<String, dynamic> toJson() => {
    'type': 'text',
    'text': text,
    'fontSize': fontSize,
    'align': align.index,
    'isBold': isBold,
  };
}

class PrintSeparator extends PrintCommand {
  @override
  Map<String, dynamic> toJson() => {'type': 'separator'};
}

class PrintFeed extends PrintCommand {
  final int lines;

  PrintFeed(this.lines);

  @override
  Map<String, dynamic> toJson() => {'type': 'feed', 'lines': lines};
}

class PrintCut extends PrintCommand {
  @override
  Map<String, dynamic> toJson() => {'type': 'cut'};
}

class PrintLeftRight extends PrintCommand {
  final String leftText;
  final String rightText;

  PrintLeftRight(this.leftText, this.rightText);

  @override
  Map<String, dynamic> toJson() => {
    'type': 'leftRight',
    'leftText': leftText,
    'rightText': rightText,
  };
}

class PrintThreeLine extends PrintCommand {
  final String leftText;
  final String centerText;
  final String rightText;

  PrintThreeLine(this.leftText, this.centerText, this.rightText);

  @override
  Map<String, dynamic> toJson() => {
    'type': 'threeLines',
    'leftText': leftText,
    'centerText': centerText,
    'rightText': rightText,
  };
}

class PrintQr extends PrintCommand {
  final String qrText;
  final PrintAlign align;
  final int size;

  PrintQr(this.qrText, this.align, this.size);

  @override
  Map<String, dynamic> toJson() => {
    'type': 'qr',
    'qrText': qrText,
    'align': align.index,
    'size': size,
  };
}

class PrintBitmap extends PrintCommand {
  final Uint8List imageBytes;
  final int imageWidth;
  final int imageHeight;

  PrintBitmap(this.imageBytes, this.imageWidth, this.imageHeight);

  @override
  Map<String, dynamic> toJson() => {
    'type': 'bitmap',
    'imageStr': base64Encode(imageBytes),
    'imageWidth': imageWidth,
    'imageHeight': imageHeight,
  };
}

class PrintSingleBitmap extends PrintCommand {
  final Uint8List imageBytes;
  final PrintAlign align;

  PrintSingleBitmap(this.imageBytes, this.align);

  @override
  Map<String, dynamic> toJson() => {
    'type': 'singleBitmap',
    'imageStr': base64Encode(imageBytes),
    'align': align.index,
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
