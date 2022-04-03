import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrimony2022/main.dart';
import 'package:matrimony2022/model/user_model.dart';
import 'package:matrimony2022/services/db_sevice.dart';
import 'package:matrimony2022/widgets/light_color.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({Key? key, this.user, this.isEditMode = false})
      : super(key: key);
  final User? user;
  final bool isEditMode;

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  late DateTime initialDate;
  late bool isFav;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController _DateOfBirthController = TextEditingController();
  DateTime? _dateOfBirth;
  late User user;
  late int a;
  bool isDisableButton = true;
  late DBService dbService;
  List<dynamic> cou = [];
  List<dynamic> city = [];
  List<dynamic> sta = [];
  List<dynamic> gen = [
    {"id": "1", "name": "Male"},
    {"id": "2", "name": "Female"},
    {"id": "3", "name": "Other"}
  ];
  List<dynamic> fav = [
    {"id": "0", "name": "Yes"},
    {"id": "1", "name": "No"},
  ];

  String countryValue = '';
  String stateValue = '';
  String cityValue = '';

  String address = "";

  @override
  void initState() {
    dbService = DBService();
    super.initState();
    user = User(
        UserName: "",
        DOB: "",
        Age: 0,
        Gender: 0,
        IsFavorite: 0,
        CityName: '',
        CountryName: '',
        StateName: '');

    if (user.MobileNumber == null) {
      user.MobileNumber = "";
    }
    if (user.Email == null) {
      user.Email = "";
    }

    if (widget.isEditMode) {
      user = widget.user!;
      List<String> n = user.DOB.split("/");
      initialDate = DateTime.parse(n[2] + '-' + n[1] + '-' + n[0]);
    } else {
      initialDate = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    _formUI() {
      return SingleChildScrollView(
        child: Column(
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "UserName",
              "Name",
              "",
              (onValidate) {
                if (onValidate.isEmpty) {
                  return "* Required";
                }
                return null;
              },
              (onSaved) {
                user.UserName = onSaved.toString().trim();
              },
              focusedBorderWidth: 1,
              borderWidth: 1,
              borderColor: LightColor.theme,
              labelFontSize: 15,
              labelBold: true,
              paddingLeft: 0,
              borderRadius: 25,
              prefixIcon: Icon(Icons.text_fields_rounded),
              showPrefixIcon: true,
              prefixIconPaddingLeft: 10,
              prefixIconColor: LightColor.gr2,
              textColor: LightColor.gr1,
              borderFocusColor: LightColor.lightBlue,
              contentPadding: 15,
              fontSize: 15,
              paddingRight: 0,
              initialValue: user.UserName,
            ),

            FormHelper.dropDownWidgetWithLabel(
              context,
              "Gender",
              "--Select--",
              user.Gender,
              gen,
              (onChanged) {
                user.Gender = int.parse(onChanged);
              },
              (onValidate) {
                if (onValidate == null) {
                  return "* Required";
                }
                return null;
              },
              borderRadius: 25,
              paddingRight: 0,
              paddingLeft: 0,
              labelFontSize: 15,
              borderFocusColor: LightColor.lightBlue,
              borderColor: LightColor.theme,
              prefixIcon: Icon(Icons.male_rounded),
              showPrefixIcon: true,
              prefixIconPaddingLeft: 10,
              prefixIconColor: LightColor.gr2,
              focusedBorderWidth: 1,
            ), //GENDER
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    "Date of Birth",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: TextFormField(
                    onSaved: (d) async {
                      user.DOB = d.toString();
                      user.Age = await a;
                    },
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        fontFamily: 'WorkSans-ExtraBold',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color.fromRGBO(34, 33, 91, 1),
                      ),
                      contentPadding: EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: LightColor.lightBlue,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: LightColor.theme,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: const Icon(
                        Icons.calendar_today_rounded,
                        color: LightColor.gr2,
                      ),
                    ),
                    controller: _DateOfBirthController,
                    keyboardType: TextInputType.name,
                    onTap: () => pickDateOfBirth(context),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Select Date';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ), //DOB
            FormHelper.inputFieldWidgetWithLabel(
                context, "MobileNumber", "Mobile Number", "", (onValidate) {},
                (onSaved) {
              user.MobileNumber = onSaved;
            },
                focusedBorderWidth: 1,
                borderWidth: 1,
                borderColor: LightColor.theme,
                labelFontSize: 15,
                labelBold: true,
                paddingLeft: 0,
                borderRadius: 25,
                prefixIcon: Icon(Icons.contact_phone_rounded),
                showPrefixIcon: true,
                prefixIconPaddingLeft: 10,
                prefixIconColor: LightColor.gr2,
                textColor: LightColor.gr1,
                borderFocusColor: LightColor.lightBlue,
                contentPadding: 10,
                fontSize: 15,
                paddingRight: 0,
                isNumeric: true,
                initialValue: user.MobileNumber.toString()), //MOBILE NUMBER
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "Email",
              "Email",
              "",
              (onValidate) {},
              (onSaved) {
                user.Email = onSaved.toString().trim();
              },
              initialValue: user.Email.toString(),
              focusedBorderWidth: 1,
              borderWidth: 1,
              borderColor: LightColor.theme,
              labelFontSize: 15,
              labelBold: true,
              paddingLeft: 0,
              borderRadius: 25,
              prefixIcon: Icon(Icons.mail_rounded),
              showPrefixIcon: true,
              prefixIconPaddingLeft: 10,
              prefixIconColor: LightColor.gr2,
              textColor: LightColor.gr1,
              borderFocusColor: LightColor.lightBlue,
              contentPadding: 15,
              fontSize: 15,
              paddingRight: 0,
            ), //EMAIL
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    "Location",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: CSCPicker(
                    currentCountry: user.CountryName.isNotEmpty
                        ? user.CountryName
                        : '*Country',
                    currentState:
                        user.StateName.isNotEmpty ? user.StateName : '*State',
                    currentCity:
                        user.CityName.isNotEmpty ? user.CityName : '*City',
                    showStates: true,
                    showCities: true,
                    flagState: CountryFlag.ENABLE,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Colors.white,
                      border: Border.all(color: LightColor.theme, width: 1),
                    ),
                    disabledDropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Colors.grey.shade300,
                      border: Border.all(color: LightColor.theme, width: 1),
                    ),
                    countrySearchPlaceholder: "Country",
                    stateSearchPlaceholder: "State",
                    citySearchPlaceholder: "City",
                    countryDropdownLabel: "*Country",
                    stateDropdownLabel: "*State",
                    cityDropdownLabel: "*City",
                    selectedItemStyle: TextStyle(
                      color: LightColor.gr1,
                      fontSize: 14,
                    ),
                    dropdownHeadingStyle: TextStyle(
                        color: LightColor.gr1,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    dropdownItemStyle: TextStyle(
                      color: LightColor.lightBlue,
                      fontSize: 14,
                    ),
                    dropdownDialogRadius: 20.0,
                    searchBarRadius: 20.0,
                    onCountryChanged: (value) {
                      setState(() {
                        countryValue = value;
                        user.CountryName = countryValue;
                      });
                    },
                    onStateChanged: (value) {
                      setState(() {
                        stateValue = value.toString();
                        user.StateName = stateValue;
                      });
                    },
                    onCityChanged: (value) {
                      setState(
                        () {
                          cityValue = value.toString();
                          user.CityName = cityValue;
                        },
                      );
                    },
                  ),
                ),
              ],
            ), //LOCATION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: 100,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: LightColor.gr1,
                        textStyle:
                            TextStyle(fontSize: 15, fontFamily: 'WorkSans'),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isDisableButton
                          ? null
                          : () {
                              if (validateAndSave()) {
                                if (widget.isEditMode) {
                                  dbService.updateUser(user).then((value) {
                                    FormHelper.showSimpleAlertDialog(
                                        context,
                                        "SQFlite",
                                        "Data Modified Successfully ",
                                        "Ok", () {
                                      Navigator.pop(context);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                      );
                                    });
                                  });
                                  globalKey.currentState!.save();
                                } else {
                                  dbService.addUser(user).then((value) {
                                    FormHelper.showSimpleAlertDialog(
                                        context,
                                        "SQFlite",
                                        "Data added successfully ",
                                        "Ok", () {
                                      Navigator.pop(context);
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                      );
                                    });
                                  });
                                  globalKey.currentState!.save();
                                }
                              }
                            },
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            ), //SUBMIT
          ],
        ),
      );
    }

    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.isEditMode ? 'Edit Details' : "Add User",
                        style: TextStyle(
                          color: LightColor.lightBlue,
                          fontSize: 20,
                          fontFamily: 'WorkSans-Bold',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: globalKey,
                  child: _formUI(),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: _dateOfBirth ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                  colorScheme: ColorScheme.light(
                primary: LightColor.theme,
              )),
              child: child ?? const Text(''),
            ));
    if (newDate == null) {
      return;
    }
    setState(() {
      _dateOfBirth = newDate;
      String dob = DateFormat('dd/MM/yyyy').format(newDate);
      _DateOfBirthController.text = dob;
      a = calculateAge(newDate);
    });
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    if (user.Gender == 1 && age >= 21) {
      isDisableButton = false;
    } else if (user.Gender == 2 && age >= 18) {
      isDisableButton = false;
    } else if (user.Gender == 3 && age >= 18) {
      isDisableButton = false;
    } else {
      isDisableButton = true;
    }
    return age;
  }
}
