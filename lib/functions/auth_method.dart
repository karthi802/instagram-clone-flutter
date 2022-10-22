import '../utils/app_lib.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Signup user
  signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occrured";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //upload image to firebase and obtain its url
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        //add user to database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'photourl': photoUrl,
          'followers': [],
          'following': [],
        });

        res = 'successful';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //login user with email password
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Error occrured';
    
    try {
      if (email.isNotEmpty || password.isNotEmpty){

        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
      }
      else{
        res = 'Please enter all fields';
      }
    }
    catch(err) {
      res = err.toString();
    }
    return res;
  }
}
