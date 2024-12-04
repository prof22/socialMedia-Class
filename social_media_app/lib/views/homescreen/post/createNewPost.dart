import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/postProvider.dart';
import 'package:social_media_app/views/homescreen/widget/imagePreview.dart';
import 'package:social_media_app/views/homescreen/widget/videoPreview.dart';

class PostCreationScreen extends StatelessWidget {
  const PostCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          'Create New Post',
          style:
              theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<PostProvider>(builder: (context, postprovider, _) {
                return TextField(
                  maxLines: 10,
                  decoration: const InputDecoration(
                    labelText: 'Write your Post',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => postprovider.setPostText(value),
                );
              }),
              const SizedBox(
                height: 16,
              ),
              Consumer<PostProvider>(builder: (context, postprovider, _) {
                return ElevatedButton.icon(
                  onPressed: () {
                    postprovider.pickImage();
                  },
                  label: const Text('Pick Image(s)/video(s)'),
                  icon: const Icon(Icons.photo_library),
                );
              }),
              const SizedBox(
                height: 16,
              ),
              Consumer<PostProvider>(builder: (context, postprovider, _) {
                return postprovider.pickImages.isNotEmpty
                    ? Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: postprovider.pickImages.map((file) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              file.path.endsWith('.mp4')
                                  ? VideoPreview(file: file)
                                  : ImagePreview(file: file),
                              IconButton(
                                  onPressed: () {
                                    postprovider.removeImage(file);
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.red,
                                  ))
                            ],
                          );
                        }).toList(),
                      )
                    : const Text('No Image selected');
              }),
              const SizedBox(
                height: 16,
              ),
              Consumer<PostProvider>(builder: (context, postprovider, _) {
                return postprovider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          bool success = await postprovider.savePost();
                          if (success) {
                            postprovider.setPostText('');
                            postprovider.clearImage();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Post Saved Successfully!'),
                            ));
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Failed to save Post'),
                            ));
                          }
                        },
                        child: const Text('Post/Save'));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
