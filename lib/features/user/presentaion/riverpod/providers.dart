import 'package:clean_architecture/core/connection/network_info.dart';
import 'package:clean_architecture/core/databases/api/api_consumer.dart';
import 'package:clean_architecture/core/databases/api/dio_consumer.dart';
import 'package:clean_architecture/core/databases/cache/cache_helper.dart';
import 'package:clean_architecture/features/user/data/data_resources/user_local_data_source.dart';
import 'package:clean_architecture/features/user/data/data_resources/user_remote_data_source.dart';
import 'package:clean_architecture/features/user/data/repositories/user_repository_implementaion.dart';
import 'package:clean_architecture/features/user/domain/repositories/user_repository.dart';
import 'package:clean_architecture/features/user/domain/usecases/get_user.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref){
  return Dio();
});

final apiConsumerProvider = Provider<ApiConsumer>((ref){
  return DioConsumer(dio: ref.read(dioProvider));
});

final remoteDataSourceProvider = Provider<UserRemoteDataSource>((ref){
  return UserRemoteDataSource(api: ref.read(apiConsumerProvider));
});

final cacheHelperProvider = Provider<CacheHelper>((ref) {
  return CacheHelper();
});

final localDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  return UserLocalDataSource(
    cache: ref.read(cacheHelperProvider), // ✅
  );
});

final networkInfoProvider = Provider<NetworkInfo>((ref){
  return NetworkInfoImpl(
    DataConnectionChecker()
  );
});

final UserRepositoryImplProvider = Provider<UserRepository>((ref){
  return UserRepositoryImpl(
    remoteDataSource: ref.read(remoteDataSourceProvider),
    localDataSource: ref.read(localDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider)
  );
});

final getUserProvider = Provider<GetUser>((ref){
  return GetUser(repository: ref.read(UserRepositoryImplProvider));
});