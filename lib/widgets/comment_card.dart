import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halicmedia/models/user.dart';
import 'package:halicmedia/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key,required this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
    String _timeAgo(Timestamp timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp.toDate());

    if (difference.inDays > 8) {
      return DateFormat.yMMMd('tr').format(timestamp.toDate());
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} gün önce';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} saat önce';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} dakika önce';
    } else {
      return 'Şimdi';
    }
  }
  @override
  Widget build(BuildContext context) {
    final User? user=Provider.of<UserProvider>(context).getUser;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profilePic']),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "${widget.snap["name"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black)),
                      TextSpan(
                          text: " ${widget.snap['text']}",
                          style: TextStyle(color: Colors.black,))
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      _timeAgo(widget.snap['datePublished']),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(padding: const EdgeInsets.all(8),
          child: const Icon(Icons.favorite,size: 16,),)
        ],
      ),
    );
  }
}
