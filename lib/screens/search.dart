import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_search/models/data.dart';
import 'package:github_search/screens/details.dart';
import 'package:github_search/widgets/custom_page_route.dart';
import 'package:github_search/widgets/search_item.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final StreamController<Data> _streamController = StreamController<Data>();
  Stream<Data> get _stream => _streamController.stream;

  Future<void> _getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.github.com/search/repositories?q=${_controller.text}'));
    Data data = Data.fromJson(jsonDecode(response.body));
    data.items.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
    _streamController.sink.add(data);
    return;
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) {
            return [
              SliverAppBar(
                floating: true,
                snap: true,
                title: const Text("GitHub Search"),
                bottom: AppBar(
                  title: Container(
                    width: double.infinity,
                    height: 45,
                    color: Colors.white,
                    child: Center(
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (value) {
                          _getData();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search for something',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          body: StreamBuilder<Data>(
            stream: _stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text("No results"),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.items.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            FadeRoute(
                                page: Details(
                                    item: snapshot.data!.items[index])));
                      },
                      child: SearchItem(
                        repozitoryName: snapshot.data!.items[index].name,
                        lastUpdate: snapshot.data!.items[index].updatedAt,
                        avatarURL: snapshot.data!.items[index].owner.avatarUrl,
                        language: snapshot.data!.items[index].language!,
                      ),
                    );
                  },
                );
              }
            },
          )),
    );
  }
}
