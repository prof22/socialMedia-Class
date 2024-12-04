import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/postProvider.dart';
import 'package:social_media_app/models/commentModel.dart';
import 'package:social_media_app/util/timeSpan.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget(
      {super.key, required this.comment, required this.postProvider});
  final CommentModel comment;
  final PostProvider postProvider;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 20,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
      title: Text(
        "${comment.createdBy!.username}",
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.content.toString(),
              style: Theme.of(context).textTheme.bodyLarge),
          Text(
              "${getComparedTime(comment.createdAt.toString())} ${postProvider.comments?.where((commentEd) => commentEd.sId == comment.sId).map((e) => e.likes!.length)} like(s)")
        ],
      ),
      trailing: Consumer<PostProvider>(builder: (context, postprovider, _) {
        bool isLiked = postprovider.isCommentLiked(comment.sId.toString());
        return IconButton(
          onPressed: () async {
            await postprovider.toggleCommentLike(
                comment.sId.toString(), comment.postId);
          },
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_outline,
            color: isLiked ? Colors.blueGrey.shade900 : Colors.grey,
          ),
        );
      }),
    );
  }
}
