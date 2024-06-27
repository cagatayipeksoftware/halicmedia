import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:halicmedia/screens/add_post_screen.dart";
import "package:halicmedia/screens/feed_screen.dart";
import "package:halicmedia/screens/profile_screen.dart";
import "package:halicmedia/screens/search_screen.dart";

const webScreenSize=600;

List<Widget> HomeScreenItems=[
             FeedScreen(),
            SearchScreen(),
            AddPostScreen(),
            Text("Notif"),
            ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
];