import 'model.dart';

final String userTable = 'userTable';
final String cityTable = 'cityTable';
final String countryTable = 'countryTable';
final String stateTable = 'stateTable';

class UserFields {
  static final String id = 'id';
  static final String UserName = 'UserName';
  static final String DOB = 'DOB';
  static final String Age = 'Age';
  static final String Gender = 'Gender';
  static final String MobileNumber = 'MobileNumber';
  static final String Email = 'Email';
  static final String CityId = 'CityId';
  static final String IsFavorite = 'IsFavorite';
  static final String StateId = 'StateId';
  static final String CountryId = 'CountryId';
  static final String CityName = 'CityName';
  static final String StateName = 'StateName';
  static final String CountryName = 'CountryName';
}

class User extends Model {
  late int? id;
  late String UserName;
  late String DOB;
  late int Age;
  late int Gender;
  late String? MobileNumber;
  late String? Email;
  late int? IsFavorite;
  late String CityName;
  late String CountryName;
  late String StateName;

  User({
    this.id,
    required this.UserName,
    required this.DOB,
    required this.Age,
    required this.Gender,
    this.MobileNumber,
    this.Email,
    required this.IsFavorite,
    required this.CityName,
    required this.StateName,
    required this.CountryName,
  });

  static User fromMap(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      UserName: json['UserName'].toString(),
      DOB: json['DOB'].toString(),
      Age: json['Age'],
      Gender: json['Gender'],
      MobileNumber: json['MobileNumber'].toString(),
      Email: json['Email'].toString(),
      IsFavorite: json['IsFavorite'],
      CityName: json['CityName'],
      StateName: json['StateName'],
      CountryName: json['CountryName'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'UserName': UserName,
      'DOB': DOB,
      'Age': Age,
      'Gender': Gender,
      'MobileNumber': MobileNumber,
      'Email': Email,
      'CityName': CityName,
      'StateName': StateName,
      'CountryName': CountryName,
      'IsFavorite': IsFavorite,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
