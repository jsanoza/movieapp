import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class VideoContainer extends StatelessWidget {
  const VideoContainer({super.key, this.videoList, required this.onClick});

  final dynamic videoList;
  final Function(dynamic index) onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        height: 200,
        width: Get.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: videoList.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                onClick(index);
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      height: 200,width: 300,
                        foregroundDecoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0, 0.8],
                          ),
                        ),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: videoList[index].image.toString(),
                          memCacheHeight: 1942,
                          memCacheWidth: 1031,
                        )),
                  ),
                  Positioned.fill(
                    child: Align(
                      child: Icon(
                        LucideIcons.playCircle,
                        color: Colors.green,
                        size: 60,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
