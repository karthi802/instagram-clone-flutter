import '../utils/app_lib.dart';

class UserProvider with ChangeNotifier {
  Person? _person;
  final AuthMethods _authMethods = AuthMethods();

  Person get getUser => _person!;

  Future<void> refreshUser() async {
    Person user = await _authMethods.getUserDetails();
    _person = user;
    notifyListeners();
  }
}
