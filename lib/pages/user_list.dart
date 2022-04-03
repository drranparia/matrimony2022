import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:matrimony2022/model/user_model.dart';
import 'package:matrimony2022/pages/add_edit_screen.dart';
import 'package:matrimony2022/services/db_sevice.dart';
import 'package:matrimony2022/widgets/light_color.dart';

import '../main.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  DBService dbService = DBService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "User Details",
                  style: TextStyle(
                    color: Color.fromRGBO(34, 33, 91, 1),
                    fontSize: 20,
                    fontFamily: 'WorkSans-Bold',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            _fetchData(),
          ],
        ),
      ),
    );
  }

  _fetchData() {
    return FutureBuilder<List<User>>(
        future: dbService.getUser(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> user) {
          if (user.hasData) {
            return _buildDataTable(user.data!);
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  _buildDataTable(List<User> user) {
    return SizedBox(
      height: 590,
      child: ListView.builder(
          itemCount: user.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 560,
              child: SizedBox(
                width: double.infinity,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
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
