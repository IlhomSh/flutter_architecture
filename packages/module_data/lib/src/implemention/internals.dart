import 'package:injectable/injectable.dart';
import 'package:module_data/src/api/service.dart';
import 'package:module_model/src/user/user_data.dart';

@LazySingleton(as: UserService)
class DummyUserService implements UserService {
  @override
  Future<UserData> getDefaultUser() async {
    await Future.delayed(Duration(seconds: 1));
    return const UserData(id: 1, name: "Default");
  }

  @override
  Future<UserData> getUserBuId(int id) async {
    await Future.delayed(Duration(seconds: 1));
    return UserData(id: id, name: "Specific User number $id");
  }
}
