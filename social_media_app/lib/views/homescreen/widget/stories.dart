import 'package:flutter/material.dart';

class Stories extends StatelessWidget {
  const Stories(
      {super.key, required this.profileImage, required this.statusImage});
  final String? profileImage;
  final String? statusImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 150,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        statusImage.toString(),
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20)),
            ),
            Positioned(
                bottom: 5,
                // left: 5,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red, width: 3)),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green, width: 3)),
                    child: profileImage == null
                        ? Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.blue, width: 3)),
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.blue, width: 3),
                                image: DecorationImage(
                                    image:
                                        NetworkImage(profileImage.toString()),
                                    fit: BoxFit.cover)),
                          ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class FirstImageWithCircleOverlay extends StatelessWidget {
  const FirstImageWithCircleOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 150,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(20)),
            ),
            Positioned(
                bottom: 5,
                // left: 5,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red, width: 3)),
                  child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 3)),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 3)),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
