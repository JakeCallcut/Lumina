import 'package:firebase_auth/firebase_auth.dart';


class FirebaseAuthService {
  FirebaseAuth _auth= FirebaseAuth.instance;




  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    
    } catch (e) {
      print("An error occured");
    } 
    
    return null;
  

  
  }




  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    
    } catch (e) {
      print("An error occured");
    } 
    
    return null;
  
  }





Future<void> deleteUserAccount() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.delete();
      print("User account deleted successfully");
    } else {
      print("No user is currently signed in.");
    }
  } catch (e) {
    print("Error deleting user: $e");
    
    // If the error is about re-authentication required
    if (e is FirebaseAuthException && e.code == 'requires-recent-login') {
      print("User needs to re-authenticate before deleting the account.");
      // Call the re-authentication function here
    }
  }
}


}