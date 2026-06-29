import 'dart:convert';

import 'package:clean_architecture/core/databases/cache/cache_helper.dart';
import 'package:clean_architecture/core/errors/exeptions.dart';
import 'package:clean_architecture/features/user/data/models/user_model.dart';

class UserLocalDataSource {
  final CacheHelper cache;
  final String key = "CachedUser";
  UserLocalDataSource({required this.cache});

  void cacheUser(UserModel? userToCache) {
    if (userToCache != null) {
      cache.saveData(key: key, value: json.encode(userToCache.toJson()));
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }

  Future<UserModel> getLastUser() {
    final jsonString = cache.getDataString(key: key);

    if (jsonString != null) {
      return Future.value(UserModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }
}
