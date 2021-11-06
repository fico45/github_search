import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    Key? key,
    required this.repozitoryName,
    required this.lastUpdate,
    required this.avatarURL,
    required this.language,
  }) : super(key: key);

  final String repozitoryName;
  final String lastUpdate;
  final String avatarURL;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 24,
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 8,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          repozitoryName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text(
                          'Last updated at: ' +
                              DateFormat('dd-MM-yyyy H:mm')
                                  .format(DateTime.parse(lastUpdate))
                                  .toString(),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Row(
                        children: [
                          const Icon(Icons.language),
                          Text(language),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          right: null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(avatarURL),
          ),
        ),
        Positioned.fill(
          top: 0,
          left: MediaQuery.of(context).size.width * 0.8,
          right: 0,
          child: const Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 86,
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
