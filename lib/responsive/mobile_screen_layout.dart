import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halicmedia/providers/user_provider.dart';
import 'package:halicmedia/utils/dimensions.dart';
import 'package:provider/provider.dart';
import "package:halicmedia/models/user.dart" as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
        body: PageView(
          children: HomeScreenItems,
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: CupertinoTabBar(
          height: 60,
          backgroundColor:Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.home,
                    size: 30, color: _page == 0 ? Colors.white : Colors.grey),
              ),
              label: "",
              backgroundColor: Color.fromARGB(255, 25, 1, 240),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.search,
                    size: 30, color: _page == 1 ? Colors.white : Colors.grey),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.add_circle,
                    size: 30, color: _page == 2 ? Colors.white : Colors.grey),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.favorite,
                    size: 30, color: _page == 3 ? Colors.white : Colors.grey),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.person,
                    size: 30, color: _page == 4 ? Colors.white : Colors.grey),
              ),
              label: "",
            ),
          ],
          onTap: navigationTapped,
        ));
  }
}
