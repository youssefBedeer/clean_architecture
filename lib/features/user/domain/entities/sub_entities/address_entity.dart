import 'package:clean_architecture/features/user/domain/entities/sub_entities/geo_entity.dart';

class AddressEntity {
  final String suite;
  final String city;
  final String zipcode;
  final GeoEntity geo;
  AddressEntity({
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });
}
