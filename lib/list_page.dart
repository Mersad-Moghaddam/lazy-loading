import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_loading/post_model.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _page = 1;
  bool _loading = false;
  final _scrollCtrl = ScrollController();
  final List<PostModel> _posts = [];
  @override
  void initState() {
    _posts.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getPosts();
    });
    _scrollCtrl.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollCtrl.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
        ListView.builder(
            controller: _scrollCtrl,
            itemCount: _posts.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200.withOpacity(0.2),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(_posts[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Text(_posts[index].body),
                  leading: Text(_posts[index].id.toString()),
                ),
              );
            }),
        if (_loading)
          const Center(
            child: CircularProgressIndicator(),
          )
      ])),
    );
  }

  Future<void> _getPosts() async {
    setState(() {
      _loading = true;
    });
    final response = await http.get(_apiUrl(_page));

    if (response.statusCode == 200) {
      if (_page == 1) {
        _posts.clear();
      }
      final jsonMap = jsonDecode(response.body);
      for (final jsonItem in jsonMap) {
        _posts.add(PostModel.fromJson(jsonItem));
      }
      setState(() {
        _loading = false;
        _page++;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  Uri _apiUrl(
    int page,
  ) =>
      Uri.parse(
          "https://jsonplaceholder.typicode.com/posts?_page=$page&_per_page=10");
  void _scrollListener() {
    if (_scrollCtrl.position.pixels == _scrollCtrl.position.maxScrollExtent) {
      _getPosts();
    }
  }
}
