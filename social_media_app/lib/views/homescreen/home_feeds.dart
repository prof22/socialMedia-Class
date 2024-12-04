import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/postProvider.dart';
import 'package:social_media_app/models/postModel.dart';
import 'package:social_media_app/util/timeSpan.dart';
import 'package:social_media_app/views/homescreen/widget/feedItems.dart';
import 'package:social_media_app/views/homescreen/widget/stories.dart';

class HomeFeedScreen extends StatelessWidget {
  HomeFeedScreen({super.key});
  // Sample list of images
  List<String> profileImages = [
    'https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250',
    'https://www.shutterstock.com/shutterstock/photos/2066600693/display_1500/stock-photo-portrait-of-a-beautiful-young-woman-wearing-makeup-and-looking-off-to-the-side-2066600693.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1955838985/display_1500/stock-photo-young-african-american-girl-wearing-casual-clothes-confuse-and-wondering-about-question-uncertain-1955838985.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2504074045/display_1500/stock-photo-black-man-representing-orix-s-ibejis-in-nature-wearing-white-clothes-candombl-umbanda-afro-2504074045.jpg',
    'https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250',
    // Add more profile image URLs here
  ];

  List<String> statusImages = [
    'https://www.shutterstock.com/shutterstock/photos/2173330173/display_1500/stock-photo-happy-mature-couple-preparing-kebabs-for-dinner-in-their-home-2173330173.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1913554207/display_1500/stock-photo-boy-playing-with-young-woman-in-the-yard-on-a-sunny-day-with-objects-to-paint-in-the-foreground-1913554207.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2417679253/display_1500/stock-photo-young-girls-getting-ready-for-outdoor-ballet-practice-2417679253.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2373400225/display_1500/stock-photo-a-young-black-african-woman-gazes-up-at-the-sky-with-a-radiant-smile-while-seated-at-an-open-air-2373400225.jpg',
    'https://cloudinary-marketing-res.cloudinary.com/image/upload/f_auto,q_auto/v1701383469/ClassPass-case_study-image2',
    'https://www.shutterstock.com/shutterstock/photos/2432207497/display_1500/stock-photo-african-american-brazilian-male-painter-at-work-painting-on-canvas-in-art-studio-2432207497.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2226415005/display_1500/stock-photo-young-creative-black-man-with-paintbrush-and-color-palette-working-over-new-artwork-painted-with-2226415005.jpg',
    // Add more status image URLs here
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(statusImages.length + 1, (index) {
                    if (index == 0) {
                      return const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: FirstImageWithCircleOverlay(),
                      );
                    } else {
                      int adjustedIndex = index - 1;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Stories(
                          profileImage: profileImages[
                                      adjustedIndex % profileImages.length]
                                  .isEmpty
                              ? null
                              : profileImages[
                                  adjustedIndex % profileImages.length],
                          statusImage:
                              statusImages[adjustedIndex % statusImages.length],
                        ),
                      );
                    }
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child:
                  Consumer<PostProvider>(builder: (context, postProvider, _) {
                List<PostModel> posts = postProvider.posts;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    PostModel post = posts[index];
                    return FeedItem(post: post);
                  },
                );
              }),
            )
          ],
        ),
      );
    });
  }
}
