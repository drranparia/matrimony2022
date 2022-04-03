import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:matrimony2022/model/user_model.dart';
import 'package:matrimony2022/services/db_sevice.dart';
import 'package:matrimony2022/widgets/light_color.dart';

import '../main.dart';
import 'add_edit_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

TextEditingController myController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  String a = "";
  late List<User> num = [];

  void cont() async {
    setState(() {});
    if (a.isNotEmpty) {
      num = await dbService.getSearch(a);
      setState(() {
        for (int i = 0; i < num.length; i++) {
          num[i].toJson()["UserName"];
        }
      });
    }
  }

  void blank() async {
    setState(() {
      a = "1234";
    });
    if (a.isNotEmpty) {
      num = await dbService.getSearch(a);
      setState(() {
        for (int i = 0; i < num.length; i++) {
          num[i].toJson()["UserName"];
        }
      });
    } else {
      return null;
    }
  }

  dynamic getSearch() async {
    num = await dbService.getSearch(a);
    setState(() {
      for (int i = 0; i < num.length; i++) {
        num[i].toJson()["UserName"];
      }
    });
  }

  DBService dbService = DBService();
  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();

    myController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "Search Users",
                        style: TextStyle(
                          color: Color.fromRGBO(34, 33, 91, 1),
                          fontSize: 20,
                          fontFamily: 'WorkSans-Bold',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ThemeData().colorScheme.copyWith(
                          primary: LightColor.lightBlue,
                        ),
                  ),
                  child: TextField(
                    onChanged: (text) {
                      a = myController.text.trim();
                      if (a.isNotEmpty) {
                        cont();
                      } else {
                        blank();
                      }
                    },
                    controller: myController,
                    onEditingComplete: cont,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: myController.text.isEmpty
                          ? Container(width: 0)
                          : IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                myController.clear();
                                blank();
                              },
                            ),
                      prefixIconColor: LightColor.skyBlue,
                      hintText: 'divyanshu',
                      hintStyle: TextStyle(
                        fontFamily: 'WorkSans',
                      ),
                      labelText: 'Search Users',
                      labelStyle: TextStyle(
                          fontFamily: 'WorkSans', color: LightColor.lightBlue),
                      contentPadding: const EdgeInsets.only(
                        left: 12.0,
                        bottom: 6.0,
                        top: 6.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: LightColor.theme,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: LightColor.lightBlue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ),
                _fetchData(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //
  _fetchData() {
    return FutureBuilder<List<User>>(
        future: dbService.getSearch(a),
        builder: (BuildContext context, num) {
          if (num.hasData) {
            return _buildDataTable(num.data!);
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  _buildDataTable(List<User> user) {
    return Container(
      height: 500,
      child: ListView.builder(
          itemCount: num.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 560,
              child: SizedBox(
                width: double.infinity,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            LightColor.gr1,
                            LightColor.gr2,
                          ],
                        ),
                      ),
                      padding: EdgeInsets.only(
                          left: 20, top: 20, right: 20, bottom: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user[index].toJson()['UserName'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'WorkSans-SemiBold',
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Date of birth : ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                user[index].toJson()["DOB"],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(255, 255, 255, 0.6),
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Age : ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'WorkSans',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        user[index].toJson()["Age"].toString(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.6),
                                          fontFamily: 'WorkSans',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Gender : ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'WorkSans',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        user[index].toJson()["Gender"] as int ==
                                                1
                                            ? Text(" Male",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 0.6),
                                                  fontFamily: 'WorkSans',
                                                  fontWeight: FontWeight.w400,
                                                ))
                                            : user[index].toJson()["Gender"]
                                                        as int ==
                                                    2
                                                ? Text(" Female",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 0.6),
                                                      fontFamily: 'WorkSans',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ))
                                                : Text(
                                                    " Other",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 0.6),
                                                      fontFamily: 'WorkSans',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Mobile Number : ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                user[index].toJson()['MobileNumber'],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(255, 255, 255, 0.6),
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "E-mail : ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                user[index].toJson()['Email'],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(255, 255, 255, 0.6),
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "City : ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                user[index].toJson()['CityName'],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(255, 255, 255, 0.6),
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Country : ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                user[index].toJson()['CountryName'],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(255, 255, 255, 0.6),
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Divider(
                              indent: 0,
                              endIndent: 0,
                              thickness: 2,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: FavoriteButton(
                                      iconSize: 35,
                                      isFavorite: user[index].IsFavorite == 1
                                          ? true
                                          : false,
                                      valueChanged: (favbutton) {
                                        print(user[index].id);

                                        if (favbutton == true) {
                                          dbService.setFav(
                                              1,
                                              int.parse(
                                                  user[index].id.toString()));
                                        }
                                        if (favbutton == false) {
                                          dbService.setFav(
                                              0,
                                              int.parse(
                                                  user[index].id.toString()));
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      size: 23,
                                      color: LightColor.black,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddEditScreen(
                                            isEditMode: true,
                                            user: user[index],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      size: 25,
                                      color: LightColor.red,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext contex) {
                                            return AlertDialog(
                                              title: Text("Delete"),
                                              content: Text(
                                                  "Do you want to delete this record"),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        dbService
                                                            .deleteUser(
                                                                user[index])
                                                            .then(
                                                          (value) {
                                                            setState(() {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              HomePage()));
                                                            });
                                                          },
                                                        );
                                                      },
                                                      child: Text("Delete"),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("No"),
                                                    )
                                                  ],
                                                )
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            );
          }),
    );
  }
}
