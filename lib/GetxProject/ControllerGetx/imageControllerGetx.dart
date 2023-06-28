import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageControllerGetx extends GetxController {
  static ImageControllerGetx get to => Get.find<ImageControllerGetx>();

  String imagePath = '';
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if(pickedFile != null) {
      imagePath = pickedFile.path;
      print(imagePath);
      update();
    }
    else{
      print('no image selected');
      return;
    }
  }


}