import 'package:login_api/services/api_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Repository {
  final storage = FlutterSecureStorage();
  final ApiProvider apiProvider = ApiProvider();

  Future<String> authenticate({String username, String password}) =>
      apiProvider.authenticate(username, password);

  Future<void> persistToken(String token) async{
    storage.write(key: "authToken", value: token);
  }

  Future<bool>hasToken() async{
    String token = await storage.read(key: "authToken");
    bool result = token != null ? true : false;
    return result;
  }

  Future<void> deleteToken() async{
    await storage.delete(key: "authToken");
  }

}
