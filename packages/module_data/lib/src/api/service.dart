import 'package:module_model/module_model.dart';

abstract class UserService {
  Future<UserData> getDefaultUser();

  Future<UserData> getUserBuId(int userId);
  
}
