import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<Uint8List?> imagePicker(ImageSource source,
    {bool isRegister = false}) async {
  final ImagePicker imagePicker = ImagePicker();

  if (isRegister) {
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return file.readAsBytes();
    }
  } else {
    List<XFile>? files = await imagePicker.pickMultiImage(
      imageQuality: 4,
    );

    if (files.isNotEmpty) {
      List<Uint8List> imageBytesList =
          await Future.wait(files.map((file) => file.readAsBytes()));
      return Uint8List.fromList(
          imageBytesList.expand((imageBytes) => imageBytes).toList());
    }
  }

  return null;
}
