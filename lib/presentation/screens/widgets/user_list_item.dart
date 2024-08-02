import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_user_list/domain/entities/user/user_entity.dart';

class UserListItem extends StatelessWidget {
  final UserEntity user;
  final Function() onFavoriteToggle;

  const UserListItem({
    super.key,
    required this.user,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.amberAccent,
      ),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 16),
            child: CachedNetworkImage(
              imageUrl: user.avatar,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) =>
                  SvgPicture.asset("assets/svgs/ic_user.svg"),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user.firstName} ${user.lastName}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  user.email,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: user.isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              onFavoriteToggle();
            },
          ),
        ],
      ),
    );
  }
}
