import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_user_list/core/theme/app_color.dart';
import 'package:flutter_user_list/domain/entities/user/user_entity.dart';

class UserGridItem extends StatelessWidget {
  final UserEntity user;
  final Function() onFavoriteToggle;
  const UserGridItem({
    super.key,
    required this.user,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 4),
            child: CachedNetworkImage(
              imageUrl: user.avatar,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) =>
                  SvgPicture.asset("assets/svgs/ic_user.dart"),
            ),
          ),
          Text(
            "${user.firstName} ${user.lastName}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              color: (Theme.of(context) == Brightness.dark)
                  ? AppColors.dark().text
                  : AppColors.light().text,
            ),
          ),
          Text(
            user.email,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: (Theme.of(context) == Brightness.dark)
                  ? AppColors.dark().text
                  : AppColors.light().text,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              onFavoriteToggle();
            },
            child: Icon(
              Icons.favorite,
              color: user.isFavorite
                  ? (Theme.of(context) == Brightness.dark)
                      ? AppColors.dark().heartEnable
                      : AppColors.light().heartEnable
                  : (Theme.of(context) == Brightness.dark)
                      ? AppColors.dark().heartDisable
                      : AppColors.light().heartDisable,
            ),
          ),
        ],
      ),
    );
  }
}
