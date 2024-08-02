import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  const UserListItem(
      {super.key,
      required this.imageUrl,
      required this.firstName,
      required this.lastName,
      required this.email});

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
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
          )
        ],
      ),
    );
  }
}
