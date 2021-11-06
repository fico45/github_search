import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:github_search/models/data.dart';

class Details extends StatelessWidget {
  const Details({Key? key, required this.item}) : super(key: key);

  final Items item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        title: Text(item.name),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                height: 120,
                color: Colors.orange[300],
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(item.owner.avatarUrl),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Owner: " + item.owner.login,
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Row(
                          children: [
                            const Text(
                              'Last updated: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy H:mm')
                                  .format(DateTime.parse(item.updatedAt))
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.language),
                          Text(
                            " " + item.language!,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Description:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        item.description.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
