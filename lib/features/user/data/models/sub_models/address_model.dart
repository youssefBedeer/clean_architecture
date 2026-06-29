import 'package:clean_architecture/core/databases/api/end_points.dart';
import 'package:clean_architecture/features/user/domain/entities/sub_entities/address_entity.dart';

class AddressModel extends AddressEntity{
  AddressModel({required super.suite, required super.city, required super.zipcode, required super.geo});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      suite: json[ApiKey.suite],
      city: json[ApiKey.city],
      zipcode: json[ApiKey.zipcode],
      geo: json[ApiKey.geo]
    );
  }

  Map<String, dynamic> toJson(){
    return {
      ApiKey.suite: suite, 
      ApiKey.city: city, 
      ApiKey.zipcode: zipcode, 
      ApiKey.geo: geo
    };
  }
}
