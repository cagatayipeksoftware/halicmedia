import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halicmedia/models/user.dart';
import 'package:halicmedia/providers/user_provider.dart';
import 'package:halicmedia/resources/firestore_methods.dart';
import 'package:halicmedia/widgets/comment_card.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({super.key, required this.snap});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        },
          icon:Icon( 
          Icons.arrow_back),
          color: Colors.white,
        ),
        title: const Text(
          "Yorumlar",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postId'])
            .collection('comments')
            .orderBy('datePublished',descending: true,)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          return ListView.builder(itemBuilder: (context, index) => CommentCard(
            snap:snapshot.data!.docs[index].data()
          ),itemCount: snapshot.data!.docs.length,);

        },
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: const EdgeInsets.only(left: 16, right: 8, bottom: 4),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user!.photoUrl),
              radius: 20,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 8, bottom: 4),
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                      hintText: "Yorum Yap,Değerlendirmeni Belirt!",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      )),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await FirestoreMethods().postComment(
                    widget.snap["postId"],
                    _commentController.text,
                    user!.uid,
                    user.username,
                    user.photoUrl);

                    setState(() {
                      _commentController.text="";
                    });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: const Text(
                  "Gönder",
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
