// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class PhotoUpload {
//   final ImagePicker _picker = ImagePicker();

//   // Upload image to Firebase Storage
//   Future<String?> uploadImage() async {
//     try {
//       // Pick an image from the gallery
//       final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//       if (image == null) return null;

//       // Upload the image to Firebase Storage
//       File file = File(image.path);
//       String fileName = 'skincare_routine/${DateTime.now().millisecondsSinceEpoch}.jpg';
//       TaskSnapshot snapshot = await _storage.ref(fileName).putFile(file);
//       String downloadUrl = await snapshot.ref.getDownloadURL();

//       return downloadUrl;
//     } catch (e) {
//       print('Error uploading photo: $e');
//       return null;
//     }
//   }
// }
