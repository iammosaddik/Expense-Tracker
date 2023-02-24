import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/Style/app_color.dart';
import 'package:firebase_authentication/Widget/button_global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Authentication/sign_in.dart';

class HomeScreen extends StatefulWidget {
  // final User user;
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool income = false;
  bool expence = false;
  var size, height, width;
  String dropdownvalue = 'Salary';

  var items = [
    'Salary',
    'Rentng',
    'Tuition fee',
    'Utility',
    'Communication',
    'Kids',
  ];
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 65,
              width: double.infinity,
              color: const Color(0xffbac6bc5e1),
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Row(
                  children: const [
                    Text(
                      'Total Income',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '6000',
                      style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      'Total Spending',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '500',
                      style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Container(
                height: 65,
                decoration: myButtonDecoration.copyWith(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: const [
                          Text(
                            'Income',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Salary',
                            style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Text(
                        '+3000',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Container(
                height: 65,
                decoration: myButtonDecoration.copyWith(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: const [
                          Text(
                            'Income',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Rentng',
                            style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Text(
                        '2000',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Container(
                height: 65,
                decoration: myButtonDecoration.copyWith(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: const [
                          Text(
                            'Expanse',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Tuition Fee',
                            style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Text(
                        '-3000',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ButtonGlobal(
                textButton: 'Log Out',
                buttonDecoration: myButtonDecoration.copyWith(color: Colors.redAccent),
                buttonTextColor: Colors.white,
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then((value) {
                    print('Sign Out Successfully');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn()));
                  });
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Container(
              alignment: Alignment.topLeft,
              child: AlertDialog(
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 60, top: 20),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Amount',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 60),
                    child: Container(
                      decoration: myButtonDecoration.copyWith(color: AppColor.borderColor),
                      child: AppTextField(
                        textFieldType: TextFieldType.NAME,
                        decoration: InputDecoration(
                          hintText: 'Amount',
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 60),
                    child: Row(
                      children: [
                        Column(
                          children: const [
                            Text(
                              'Sector',
                              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(15)),
                            child: DropdownButton(
                              underline: SizedBox(),
                              dropdownColor: Colors.grey,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              value: dropdownvalue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: this.income,
                        onChanged: (value) {
                          setState(() {
                            this.income = value!;
                          });
                        },
                      ),
                      const Text(
                        'Income',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: this.expence,
                        onChanged: (value) {
                          setState(() {
                            this.expence = value!;
                          });
                        },
                      ),
                      const Text(
                        'Expence',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  ButtonGlobal(
                    textButton: 'Save',
                    buttonDecoration: myButtonDecoration.copyWith(color: Colors.green),
                    buttonTextColor: Colors.black,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
