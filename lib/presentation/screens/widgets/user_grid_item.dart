import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserGridItem extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  const UserGridItem(
      {super.key,
      required this.imageUrl,
      required this.firstName,
      required this.lastName,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.amberAccent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 4),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) =>
                  SvgPicture.asset("assets/svgs/ic_user.dart"),
            ),
          ),
          Text(
            "$firstName $lastName",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            email,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
