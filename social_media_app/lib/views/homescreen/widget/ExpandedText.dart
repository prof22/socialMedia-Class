import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/expandedTextprovider.dart';

class Expandedtext extends StatelessWidget {
  const Expandedtext({super.key, required this.text, required this.postId});
  final String text;
  final String postId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textExpandedprovider = Provider.of<Expandedtextprovider>(context);

    int maxLengthfor6lines = 100;

    bool isTextLong = text.length > maxLengthfor6lines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          maxLines:
              isTextLong && !textExpandedprovider.isExpanded(postId) ? 6 : null,
          overflow: isTextLong && !textExpandedprovider.isExpanded(postId)
              ? TextOverflow.ellipsis
              : TextOverflow.visible,
          style: theme.textTheme.bodyMedium,
        ),
        if (isTextLong)
          GestureDetector(
            onTap: () {
              textExpandedprovider.toggleExpanded(postId);
            },
            child: Text(
              textExpandedprovider.isExpanded(postId)
                  ? "Read Less"
                  : "Read More",
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          )
      ],
    );
  }
}
