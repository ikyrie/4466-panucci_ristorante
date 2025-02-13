import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

class PaperSizeUtils {
  static PaperSize getPaperSize(int value) {
    switch (value) {
      case 1:
        return PaperSize.mm58;
      case 2:
        return PaperSize.mm72;
      case 3:
        return PaperSize.mm80;
      default:
        return PaperSize.mm58;
    }
  }
}

class TextSizeUtils {
  static PosTextSize getTextSize(int value) {
    switch (value) {
      case 1:
        return PosTextSize.size1;
      case 2:
        return PosTextSize.size2;
      case 3:
        return PosTextSize.size3;
      case 4:
        return PosTextSize.size4;
      case 5:
        return PosTextSize.size5;
      case 6:
        return PosTextSize.size6;
      case 7:
        return PosTextSize.size7;
      case 8:
        return PosTextSize.size8;
      default:
        return PosTextSize.size1;
    }
  }
}