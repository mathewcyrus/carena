import 'package:image_picker/image_picker.dart';

imagePicker(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return file.readAsBytes();
  }
  print("no image selected");
}
