// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture/core/databases/api/api_consumer.dart';
import 'package:clean_architecture/core/databases/api/end_points.dart';
import 'package:clean_architecture/core/params/params.dart';
import 'package:clean_architecture/features/user/data/models/user_model.dart';

class UserRemoteDataSource {
  final ApiConsumer api; 
  UserRemoteDataSource({
    required this.api,
  });
  Future<UserModel> getUser(UserParams params) async {
    final response = await api.get("${EndPoints.users}/${params.id}"); 
    return UserModel.fromJson(response);
  }
}
