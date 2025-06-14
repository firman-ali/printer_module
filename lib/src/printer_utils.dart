class PrinterUtils {
  static int size58PrintLength = 32;
  static int size80PrintLength = 48;

  // 0 for 58mm
  // 1 for 80mm
  static String generateStrLine(int formatPrinterSize) {
    if (formatPrinterSize == 0) {
      return '-' * size58PrintLength;
    } else {
      return '-' * size80PrintLength;
    }
  }

  // 0 for 58mm
  // 1 for 80mm
  static String? getThreeLineSpacingSize(int formatPrinterSize) {
    if (formatPrinterSize == 0) {
      return "%-12s %5s %12s %n";
    } else {
      return "%-20s %5s %20s %n";
    }
  }

  // 0 for 58mm
  // 1 for 80mm
  static String? getLeftRightSpacingSize(int formatPrinterSize) {
    if (formatPrinterSize == 0) {
      return null;
    } else {
      return "%-20s %26s %n";
    }
  }
}
