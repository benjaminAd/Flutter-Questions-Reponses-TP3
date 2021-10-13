import 'package:firebase_storage/firebase_storage.dart';

class StorageFirebase {
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> getImageFromStorage(String path) async {
    print("Here");
    print(path);
    return await _storage.ref(path).getDownloadURL();
  }
}
