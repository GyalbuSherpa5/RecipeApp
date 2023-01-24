import 'package:flutter/material.dart';
import 'package:recipe/constants/routes.dart';
import 'package:recipe/page/dashBoard.dart';
import 'package:recipe/page/profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;
  final List<Widget> screens = const [
    DashBoard(),
    Profile(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const DashBoard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            createRecipeRoute,
            (route) => false,
          );
        },
        backgroundColor: Colors.green,
        icon: const Icon(
          Icons.food_bank_rounded,
          size: 50,
        ),
        label: const Text(
          'Create',
        ),
        extendedPadding:
            const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          notchMargin: 10,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black87,
            ),
            child: SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = const DashBoard();
                            currentTab = 0;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color:
                                  currentTab == 0 ? Colors.teal : Colors.grey,
                            ),
                            Text('DashBoard',
                                style: TextStyle(
                                    color: currentTab == 0
                                        ? Colors.teal[600]
                                        : Colors.grey))
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = const Profile();
                            currentTab = 1;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color:
                                  currentTab == 1 ? Colors.teal : Colors.grey,
                            ),
                            Text('Profile',
                                style: TextStyle(
                                    color: currentTab == 1
                                        ? Colors.teal[600]
                                        : Colors.grey))
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          )),
    );
  }
}
