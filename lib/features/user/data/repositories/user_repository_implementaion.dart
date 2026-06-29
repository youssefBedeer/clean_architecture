import 'package:clean_architecture/core/connection/network_info.dart';
import 'package:clean_architecture/core/errors/exeptions.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/params/params.dart';
import 'package:clean_architecture/features/user/data/data_resources/user_local_data_source.dart';
import 'package:clean_architecture/features/user/data/data_resources/user_remote_data_source.dart';
import 'package:clean_architecture/features/user/domain/entities/user_entity.dart';
import 'package:clean_architecture/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl extends UserRepository {
  final NetworkInfo networkInfo;
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, UserEntity>> getUser({
    required UserParams params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteUser = await remoteDataSource.getUser(params);
        localDataSource.cacheUser(remoteUser);
        return Right(remoteUser);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      try {
        final localUser = await localDataSource.getLastUser();
        return Right(localUser);
      } on CacheExeption catch (e) {
        return Left(Failure(errMessage: e.errorMessage));
      }
    }
  }
}
