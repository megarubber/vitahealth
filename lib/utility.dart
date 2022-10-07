import 'dart:typed_data';
import 'dart:convert';

class Utility {
  /*
  static Image imageFromBase64String(String base64String, {required int w, required int h}) {
    return Image.memory(
      dataFromBase64String(base64String),
      width: w,
      height: h,
      fit: BoxFit.fill
    )
  }
  */
  
  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}