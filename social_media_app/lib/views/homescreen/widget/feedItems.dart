import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/postProvider.dart';
import 'package:social_media_app/models/postModel.dart';
import 'package:social_media_app/util/timeSpan.dart';
import 'package:social_media_app/views/homescreen/post/postComment.dart';
import 'package:social_media_app/views/homescreen/widget/ExpandedText.dart';
import 'package:social_media_app/views/homescreen/widget/VideoUrlPreview.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({super.key, t, required this.post});
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.cardColor,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://cloudinary-marketing-res.cloudinary.com/image/upload/f_auto,q_auto/v1701383469/ClassPass-case_study-image2"),
                radius: 20,
              ),
              title: Text(
                "${post.createdBy!.username}",
                style: theme.textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                getComparedTime(post.createdAt.toString()),
                style: theme.textTheme.labelSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expandedtext(
              text: post.content.toString(),
              postId: post.sId.toString(),
            ),
            if (post.images!.isNotEmpty) ...[
              const SizedBox(
                height: 8,
              ),
              _buildImageGrid(post.images!, theme),
            ],
            const SizedBox(
              height: 8,
            ),
            _buildActionButtons(post),
          ],
        ),
      ),
    );
  }
}

Widget _buildMediaWidget(String url) {
  if (url.endsWith('.mp4') || url.endsWith('.avi') || url.endsWith('.mov')) {
    return MediaWidget(url: url);
  } else {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        height: 100,
      ),
    );
  }
}

Widget _buildImageGrid(List<String> mediaurl, theme) {
  return Row(
    children: [
      Expanded(
        child: _buildMediaWidget(mediaurl[0]),
      ),
      const SizedBox(
        width: 4,
      ),
      Expanded(
        child: SizedBox(
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              for (int i = 1; i < mediaurl.length && i <= 4; i++)
                Positioned(
                  left: 1 * 8.0,
                  child: Opacity(
                    opacity: 1 - (i * 0.15),
                    child: _buildMediaWidget(mediaurl[i]),
                  ),
                ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildActionButtons(PostModel post) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      TextButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_outline_outlined,
            color: Colors.blue,
          ),
          label: const Text(
            '',
          )),
      Consumer<PostProvider>(builder: (context, postprovider, _) {
        return TextButton.icon(
            onPressed: () {
              postprovider.fetchAllComments(post.sId);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostComments(post: post)));
              // PostComments
            },
            icon: const FaIcon(FontAwesomeIcons.comment),
            label: const Text(
              '',
            ));
      }),
      TextButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.share,
            color: Colors.grey,
          ),
          label: const Text(
            '',
          )),
      TextButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.book_online_outlined,
            color: Colors.grey,
          ),
          label: const Text(
            '',
          ))
    ],
  );
}
