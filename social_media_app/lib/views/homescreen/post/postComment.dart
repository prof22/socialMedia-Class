import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/postProvider.dart';
import 'package:social_media_app/models/commentModel.dart';
import 'package:social_media_app/models/postModel.dart';
import 'package:social_media_app/views/homescreen/widget/commentWidget.dart';
import 'package:social_media_app/views/homescreen/widget/feedItems.dart';

class PostComments extends StatelessWidget {
  PostComments({super.key, required this.post});
  final PostModel post;
  final TextEditingController commentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.cardColor,
        iconTheme: IconThemeData(color: theme.appBarTheme.backgroundColor),
        title: Text(
          'Comments',
          style:
              theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FeedItem(post: post),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<PostProvider>(
                            builder: (context, postprovider, _) {
                          return Text(
                              "Comments (${postprovider.comments?.length})");
                        }),
                        Row(
                          children: [
                            const Text('Recent'),
                            Consumer<PostProvider>(
                                builder: (context, postprovider, _) {
                              return IconButton(
                                  onPressed: () {
                                    postprovider
                                        .fetchAllRecentComment(post.sId);
                                  },
                                  icon: const Icon(Icons.keyboard_arrow_down));
                            })
                          ],
                        )
                      ],
                    ),
                  ),
                  Consumer<PostProvider>(builder: (context, postprovider, _) {
                    List<CommentModel>? comments = postprovider.comments;
                    return postprovider.isGetCommentLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : comments == [] || comments!.isEmpty
                            ? const Center(
                                child: Text('No comments'),
                              )
                            : Column(
                                children:
                                    List.generate(comments.length, (index) {
                                  CommentModel comment = comments[index];
                                  return CommentWidget(
                                    comment: comment,
                                    postProvider: postprovider,
                                  );
                                }),
                              );
                  }),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: commentTextController,
                          decoration: const InputDecoration(
                              hintText: 'Add comment Here..',
                              border: OutlineInputBorder()),
                        )),
                        Consumer<PostProvider>(
                            builder: (context, postprovider, _) {
                          return postprovider.isCommentLoading
                              ? const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: CircularProgressIndicator(),
                                )
                              : IconButton(
                                  onPressed: () async {
                                    if (commentTextController.text.isEmpty) {
                                      return;
                                    }
                                    await postprovider
                                        .saveComment(commentTextController.text,
                                            post.sId)
                                        .then((value) {
                                      if (value == true) {
                                        commentTextController.clear();
                                        postprovider.fetchAllComments(post.sId);
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.send));
                        })
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
