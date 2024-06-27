import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halicmedia/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        
        centerTitle: true,
        title: Padding(padding: EdgeInsets.only(top: 40,left: 50),
          child: Image.asset(
            "assets/logo.png",
            height: 100,
            width: 200,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.messenger_outline,
                color: Colors.white,
              ))
              ,
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) =>
                PostCard(snap: snapshot.data!.docs[index].data()),
            itemCount: snapshot.data!.docs.length,
          );
        },
      ),
    );
  }
}
